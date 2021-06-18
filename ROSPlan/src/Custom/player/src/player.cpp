#include "ros/ros.h"
#include "player/player.h"
#include "custom_msgs/axis.h"
#include "board/ask_player_stat_srv.h"
#include "board/select_menu_msg.h"
#include "board/move_check_srv.h"
#include "board/player_act_srv.h"
#include "board/set_ai_loc_msg.h"

#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/select.h>
#include <termios.h>
#include <chrono>
#include <iostream>
using namespace std;
 
static struct termios initial_settings, new_settings;
 
static int peek_character = -1;
 
void init_keyboard()
{
    tcgetattr(0,&initial_settings);
    new_settings = initial_settings;
    new_settings.c_lflag &= ~ICANON;
    new_settings.c_lflag &= ~ECHO;
    new_settings.c_cc[VMIN] = 1;
    new_settings.c_cc[VTIME] = 0;
    tcsetattr(0, TCSANOW, &new_settings);
}
 
void close_keyboard()
{
    tcsetattr(0, TCSANOW, &initial_settings);
}
 
int _kbhit()
{
    unsigned char ch;
    int nread;
 
    if (peek_character != -1) return 1;
    new_settings.c_cc[VMIN]=0;
    tcsetattr(0, TCSANOW, &new_settings);
    nread = read(0,&ch,1);
    new_settings.c_cc[VMIN]=1;
    tcsetattr(0, TCSANOW, &new_settings);
    if(nread == 1)
    {
        peek_character = ch;
        return 1;
    }
    return 0;
}
 
int _getch()
{
    char ch;
 
    if(peek_character != -1)
    {
        ch = peek_character;
        peek_character = -1;
        return ch;
    }
    read(0,&ch,1);
    return ch;
}
 
int _putch(int c) {
    putchar(c);
    fflush(stdout);
    return c;
}


//출처 https://eastskykang.wordpress.com/2015/01/28/c-c-kbhit-function-in-linux/


namespace Custom{
    Player::Player(ros::NodeHandle &nh){
        node_handle = &nh;
        player_state = GAME;
        //state call
        std::string state_topic = "/board/ask_player_stat";
        nh.getParam("state_name", state_topic);
        ros::service::waitForService(state_topic, ros::Duration(20));
        ros::ServiceClient client = nh.serviceClient<board::ask_player_stat_srv>(state_topic);
        board::ask_player_stat_srv srv;
        if (client.call(srv)){
            init_player = srv.response.player;
            player = init_player;
        }
        else{
        }

        speed = 4;  //speed

        //player_state = MENU;

        std::string select_topic = "/player/select_menu";
        nh.getParam("select_name", select_topic);
        select_menu_pub = nh.advertise<board::select_menu_msg>(select_topic, 1000);

        std::string exit_topic = "/board/exit_call";
        exit_pub = nh.advertise<std_msgs::Empty>(exit_topic, 1000);

        //service cli select_menu
        std::string check_topic = "/board/move_check";
        nh.getParam("check_name", check_topic);
        ros::service::waitForService(check_topic, ros::Duration(20));
        move_check_cli = nh.serviceClient<board::move_check_srv>(check_topic);

        //service cli player_action
        std::string action_topic = "/board/player_action";
        nh.getParam("action_name", action_topic);
        ros::service::waitForService(action_topic, ros::Duration(20));
        player_action_cli = nh.serviceClient<board::player_act_srv>(action_topic);

        want_direction = init_player[0].direction;
    }

    Player::~Player(){

    }

    void Player::have_input(const int buf){
        if(player_state == MENU){   //menu 선택 상태
            board::select_menu_msg msg_temp;
            if(buf == 13){ //엔터일 때
                msg_temp.action = "select";
                ready_game();       //init position
                player_state = WAIT;
            }
            else if(buf >= 67 && buf <= 68){
                msg_temp.action = "move";
            }
            select_menu_pub.publish(msg_temp);
        }
        else if(player_state == GAME){  //게임 상태일때 키보드
            if (buf == 68)
                want_direction = LEFT;
            if (buf == 65)
                want_direction = UP;
            if (buf == 67)
                want_direction = RIGHT;
            if (buf == 66)
                want_direction = DOWN;
        }
        return;
    }

    void Player::ready_game(){      //init position
        player = init_player;
        return;
    }

    void Player::run_action(double duration){
        if(player_state == GAME){           //게임 상태일때 action 취하기
            board::move_check_srv srv_temp;
            srv_temp.request.want_direction = want_direction;
            if (move_check_cli.call(srv_temp)){     //원하는 방향 가능한지 check srv
                if(player[0].direction != srv_temp.response.direction)
                    want_direction = srv_temp.response.direction;
                player[0].direction = srv_temp.response.direction;
                
            }
            else
            {
            }
            
            float move_distance = duration * speed;     //이동함
            if(player[0].direction == LEFT)
                player[0].col -= move_distance;
            else if(player[0].direction == RIGHT)
                player[0].col += move_distance;
            else if(player[0].direction == UP)
                player[0].row -= move_distance;
            else if(player[0].direction == DOWN)
                player[0].row += move_distance;

            board::player_act_srv act_srv;
            act_srv.request.loc = player[0];
        
            if (player_action_cli.call(act_srv)){       //이동해도 되는지 되면 이동 하게 하는 srv
                player[0] =  act_srv.response.result;
            }
            else
            {}


        }
        
    }

    void Player::change_state_Callback(const board::change_state_msg& msg){
        if(msg.state == "wait"){    //change state
            player_state = WAIT;
        }
        else if(msg.state == "playing game"){
            player_state = GAME;
        }
        else if(msg.state == "menu"){
            player_state = MENU;
        }
        return;
    }

    void Player::exitCallback(const std_msgs::Empty& msg){
        ros::shutdown();
    }

    void Player::setCallback(const board::set_ai_loc_msg& msg){
        player[0] = msg.loc;
    }

    bool Player::player_state_time_Callback(player::player_state_time_srv::Request& req, player::player_state_time_srv::Response& res){
        int point_row = player[0].row;          //player의 현 상태를 return
        int point_col = player[0].col;
        float time;
        if(player[0].direction == LEFT){
            point_col = floor(player[0].col);
            time = abs((point_col - player[0].col) / speed);
        }
        else if(player[0].direction == UP){
            point_row = floor(player[0].row);
            time = abs((point_row - player[0].row) / speed);
        }
        else if(player[0].direction == RIGHT){
            point_col = ceil(player[0].col);
            time = abs((point_col - player[0].col) / speed);
        }
        else if(player[0].direction == DOWN){
            point_row = ceil(player[0].row);
            time = abs((point_row - player[0].row) / speed);
        }
        
        res.player = player;
        res.player[0].row = point_row;
        res.player[0].col = point_col;
        res.time = time;
        
        return true;
    }
}


int main(int argc, char **argv)
{
    ros::init(argc, argv, "player");
    ros::NodeHandle nh("~");

    Custom::Player pi(nh);

    //service server        //header 참조
    ros::ServiceServer player_state_time = nh.advertiseService("/player/player_state_time", &Custom::Player::player_state_time_Callback, dynamic_cast<Custom::Player *>(&pi));

    //subscriber
    std::string change_topic = "/board/change_state";
    nh.getParam("change_name", change_topic);
    ros::Subscriber change_state_sub = nh.subscribe(change_topic, 1000, &Custom::Player::change_state_Callback,
                                               dynamic_cast<Custom::Player *>(&pi));

    std::string exit_topic = "/board/exit_call";
    nh.getParam("exit_name", exit_topic);
    ros::Subscriber exit_sub = nh.subscribe(exit_topic, 1, &Custom::Player::exitCallback,
                                            dynamic_cast<Custom::Player *>(&pi));

                                            
    std::string set_topic = "/player/set_player";
    ros::Subscriber set_sub = nh.subscribe(set_topic, 1, &Custom::Player::setCallback,
                                            dynamic_cast<Custom::Player *>(&pi));


    std::cout<<"ready to run player"<<std::endl;
    // ROS_INFO("Custom: (%s) Ready to receive", ros::this_node::getName().c_str());
    double act_time = 0.04;
    int i =0;
    //player_state = GAME;
    while (1)
    {
        sleep(0);
        double start_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
        ros::spinOnce();

        if(_kbhit()){       //들어온 입력이 있는가?
            int buf;
            buf = _getch();
            //cout<<buf<<endl;
            if(buf == 27){
                if (_kbhit()){
                    buf = _getch();
                    if (buf == 91){
                        buf = _getch();
                        if(buf >= 65 && buf <=68)   //키보드 입력 일 때
                            pi.have_input(buf);
                    }
                }
            }
            else if(buf == 13){     //엔터일때
                pi.have_input(buf);
            }
            else if(buf == 3){   //eof
                std_msgs::Empty msg;
                pi.exit_pub.publish(msg);
                string tm = "rosnode kill -a";
                system(tm.c_str());
                break;
            }
        }
        while(_kbhit()){    //남은 입력 제거
            int trash = _getch();
        }
        pi.run_action(act_time);


             
        double finish_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
        double rate = (double)(act_time * 1000000000 - (finish_time - start_time)) / 1000000000;
        if (rate > 0){
            ros::Rate wait = 1 / rate;
            wait.sleep();
        }
        act_time = (finish_time - start_time) / 1000000000;
        if(act_time < 0.04) act_time = 0.04;
    }

    return 0;    
}