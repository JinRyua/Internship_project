#include "display/display.h"
#include "board/ask_map_size.h"
#include <iostream>

#include <chrono>

using namespace std;

namespace Custom{
    Display::Display(ros::NodeHandle &nh)
    {
        node_handle = &nh;
        string board_name = "/board";
        nh.getParam("board_name", board_name);

        //service call
        std::stringstream ss;
        ss << board_name << "/ask_state";
        ros::service::waitForService(ss.str(), ros::Duration(20));
        ros::ServiceClient client = nh.serviceClient<board::ask_map_size>(ss.str());
        board::ask_map_size srv;
        if (client.call(srv)){
            row = srv.response.row + 1;
            col = srv.response.col;
        }
        else{
        }

        // white_board = "";
        // for(int i = 0; i < row; i++){
        //     for(int j = 0; j < col; j++){
        //         white_board = white_board + " ";
        //     }
        //     white_board = white_board + "\n";
        // }
        //
    }

    void Display::displayCallback(const board::display_info &msg)
    {
        //메세지 내용 저장
        player = msg.player_axis;
        std::vector<custom_msgs::axis> temp = msg.agents_axis;
        agents.clear();
        for(int i = 0; i < temp.size(); i++){
            agents.push_back(pair<custom_msgs::axis, bool>(temp[i], msg.ghost[i]));
        }
        // scookies = msg.scookies_loc; 
        // lcookies = msg.lcookies_loc; 
        selecting_menu = msg.selecting_menu;
        score = msg.score;
        life = msg.life;

        //map mapping
        std::vector<custom_msgs::map> map_temp = msg.map;

        map.clear();
        for(int i = 0; i < map_temp.size(); i++){
            std::vector<std::string> row_temp;
            row_temp.clear();
            for(int j = 0; j < map_temp[i].value.size(); j++){
                row_temp.push_back(map_temp[i].value[j]);
            }
            map.push_back(row_temp);
        }
        

        // temp = msg.defa;
        // if(!temp.empty()){
        //     display_info = white_board;
        //     for(int i = 0; i < temp.size(); i++){
        //         display_info[((temp[i].row - 1) * (col + 1)) + (temp[i].col - 1)] = '■';
        //     }
        // }
    }

    void Display::exitCallback(const std_msgs::Empty &msg)
    {
        exit(0);
    }

    

    Display::~Display() 
    {

    }

    void Display::display(){
        string display_info = "";
        std::vector<std::vector<std::string>> map_temp = map;   //map temp
        

        //player
        for(int i = 0; i < player.size(); i++){
            if(player[0].direction == 1)
                map_temp[player[0].row - 1][player[0].col - 1] = ">";
            else if(player[0].direction == 2)
                map_temp[player[0].row - 1][player[0].col - 1] = "∨";
            else if(player[0].direction == 3)
                map_temp[player[0].row - 1][player[0].col - 1] = "＜";
            else if(player[0].direction == 4)
                map_temp[player[0].row - 1][player[0].col - 1] = "∧";  
        }
        //agents
        for(int i = 0; i < agents.size(); i++){
            if(agents[i].second = true){    //ghost
                if (agents[i].first.direction == 1)
                    map_temp[agents[i].first.row - 1][agents[i].first.col - 1] = "◁";
                else if (agents[i].first.direction == 2)
                    map_temp[agents[i].first.row - 1][agents[i].first.col - 1] = "▷";
                else if (agents[i].first.direction == 3)
                    map_temp[agents[i].first.row - 1][agents[i].first.col - 1] = "△";
                else if (agents[i].first.direction == 4)
                    map_temp[agents[i].first.row - 1][agents[i].first.col - 1] = "▽";
            }
            else{
                if (agents[i].first.direction == 1)
                    map_temp[agents[i].first.row - 1][agents[i].first.col - 1] = "a";
                else if (agents[i].first.direction == 2)
                    map_temp[agents[i].first.row - 1][agents[i].first.col - 1] = "▲";
                else if (agents[i].first.direction == 3)
                    map_temp[agents[i].first.row - 1][agents[i].first.col - 1] = "▶";
                else if (agents[i].first.direction == 4)
                    map_temp[agents[i].first.row - 1][agents[i].first.col - 1] = "▼";
            }
        }
        if(player.size()>0&&agents.size()>1)
        cout<<player[0].row<<" "<<player[0].col<<" "<<agents[0].first.row<<" "<<agents[0].first.col<<endl;
        for(int i = 0; i < map_temp.size(); i++){
            for(int j = 0; j < map_temp[i].size(); j++){
                display_info = display_info + map_temp[i][j];
            }
        }
        // //scookies
        // for(int i = 0; i < scookies.size(); i++){
        //     display_info[((scookies[i].row - 1) * (col + 1)) + (scookies[i].col - 1)] = '·';
        // }
        // //large cookies
        // for(int i = 0; i < lcookies.size(); i++){
        //     display_info[((lcookies[i].row - 1) * (col + 1)) + (lcookies[i].col - 1)] = '●';
        // }

        cout<<display_info;

    }

}//close namespace

int main(int argc, char **argv)
{
    ros::init(argc, argv, "display");
    ros::NodeHandle nh("~");

    Custom::Display di(nh);

    //subscriber
    std::string display_topic = "/display/display";
    nh.getParam("display_name", display_topic);
    ros::Subscriber display_sub = nh.subscribe(display_topic, 1000, &Custom::Display::displayCallback,
                                               dynamic_cast<Custom::Display *>(&di));
    std::string exit_topic = "/board/exit_call";
    nh.getParam("exit_name", exit_topic);
    ros::Subscriber exit_sub = nh.subscribe(exit_topic, 1, &Custom::Display::exitCallback,
                                            dynamic_cast<Custom::Display *>(&di));

    std::cout<<"ready to run display"<<std::endl;
    // ROS_INFO("Custom: (%s) Ready to receive", ros::this_node::getName().c_str());


    double act_time = 0.05;
    int count =0;
    while (1)
    {
        sleep(0);
        double start_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
        ros::spinOnce();
        di.display();
        double finish_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
        double rate = (double)(act_time * 1000000000 - (finish_time - start_time)) / 1000000000;
        if (rate > 0)
        {
            ros::Rate wait = 1 / rate;
            wait.sleep();
        }
    }
    return 0;
}