#include "display/display.h"
#include <iostream>

#include <chrono>

using namespace std;
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/select.h>
#include <termios.h>
static struct termios initial_settings, new_settings;
 
static int peek_character = -1;
 
void init_keyboard()
{
    tcgetattr(0,&initial_settings);
    new_settings = initial_settings;
    new_settings.c_lflag &= ~ICANON;
    new_settings.c_lflag &= ~ECHO;
    new_settings.c_cc[VMIN] = 0;
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
    new_settings.c_cc[VMIN]=0;
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
    Display::Display(ros::NodeHandle &nh)
    {
        node_handle = &nh;
        string board_name = "/board";
        nh.getParam("board_name", board_name);

        display_row = 35;
        display_col = 130;
    }

    void Display::displayCallback(const display::display_info &msg)
    {
        int game_state;     //게임 상태

        vector<string> display_info;
        display_info.resize(display_row, "");
        for (int i = 0; i < display_row; i++) {         //35*135(+1)
            for (int j = 0; j < display_col; j++) {
                display_info[i] += " ";
            }
        }


        if (msg.game_state == PLAYER_TURN)      //print game state
            display_info[0].replace( 1, 14, "Player's turn");
        else if (msg.game_state == AI_TURN)
            display_info[0].replace( 1, 10, "AI's turn");

        display_info[3].replace(50, 13, "AI score : " + to_string(msg.ai_score));    //print AI
        string temp = "coin :  \x1b[0m◆ : \x1b[0m" + to_string(msg.ai_coin.white)
                + "  \x1b[34m● : \x1b[0m" + to_string(msg.ai_coin.blue)
                + "  \x1b[32m■ : \x1b[0m" + to_string(msg.ai_coin.green)
                + "  \x1b[31m♥ : \x1b[0m" + to_string(msg.ai_coin.red)
                + "  \x1b[33m★ : \x1b[0m" + to_string(msg.ai_coin.black);
        display_info[5].replace(35, 40, temp);

        temp = "card :  \x1b[0m◆ : \x1b[0m" + to_string(msg.ai_card[WHITE].holder.size())
                + "  \x1b[34m● : \x1b[0m" + to_string(msg.ai_card[BLUE].holder.size())
                + "  \x1b[32m■ : \x1b[0m" + to_string(msg.ai_card[GREEN].holder.size())
                + "  \x1b[31m♥ : \x1b[0m" + to_string(msg.ai_card[RED].holder.size())
                + "  \x1b[33m★ : \x1b[0m" + to_string(msg.ai_card[BLACK].holder.size())
                + "  \x1b[0mN : \x1b[0m" + to_string(msg.ai_card[NOBILITY].holder.size());

        display_info[7].replace(35, 45, temp);

        for(int i=0;i<display_info[8].size();i++){      //print line
            display_info[8][i] = '=';
        }
        for(int i=0;i<display_info[8].size();i++){
            display_info[12][i] = '=';
        }
        for(int i=0;i<display_info[8].size();i++){
            display_info[16][i] = '=';
        }
        for(int i=0;i<display_info[8].size();i++){
            display_info[20][i] = '=';
        }
        for(int i=0;i<display_info[8].size();i++){
            display_info[24][i] = '=';
        }
        for(int i=0;i<display_info[8].size();i++){
            display_info[28][i] = '=';
        }

        display_info[10] = "               Level 3 (" + to_string(msg.level3_fold) + ")   ";   //level3 card
        for (int i = 0; i < msg.level3_open.size(); i++) {
            int count = 0;
            display_info[10] += to_string(msg.level3_open[i].point) + convert_token(msg.level3_open[i].token);
            display_info[10] += "(";
            for (int j = 0; j < 5; j++) {
                if (convert_color(msg.level3_open[i], j) != 0)
                    display_info[10] += convert_number(j) + to_string(convert_color(msg.level3_open[i], j));
                else
                    count += 3;
            }

            display_info[10] += ")";
            for (int j = 0; j < count; j++) {
                display_info[10] += " ";
            }
        }

        display_info[14] = "               Level 2 (" + to_string(msg.level2_fold) + ")   ";   //level2 card
        for (int i = 0; i < msg.level2_open.size(); i++) {
            int count = 0;
            display_info[14] += to_string(msg.level2_open[i].point) + convert_token(msg.level2_open[i].token);
            display_info[14] += "(";
            for (int j = 0; j < 5; j++) {
                if (convert_color(msg.level2_open[i], j) != 0)
                    display_info[14] += convert_number(j) + to_string(convert_color(msg.level2_open[i], j));
                else
                    count += 3;
            }

            display_info[14] += ")";
            for (int j = 0; j < count; j++) {
                display_info[14] += " ";
            }
        }

        display_info[18] = "               Level 1 (" + to_string(msg.level1_fold) + ")   ";   //level1 card
        for (int i = 0; i < msg.level1_open.size(); i++) {
            int count = 0;
            display_info[18] += to_string(msg.level1_open[i].point) + convert_token(msg.level1_open[i].token);
            display_info[18] += "(";
            for (int j = 0; j < 5; j++) {
                if (convert_color(msg.level1_open[i], j) != 0)
                    display_info[18] += convert_number(j) + to_string(convert_color(msg.level1_open[i], j));
                else
                    count += 3;
            }

            display_info[18] += ")";
            for (int j = 0; j < count; j++) {
                display_info[18] += " ";
            }
        }

        display_info[22] = "               Nobility               ";   //nobility card
        for (int i = 0; i < msg.nobility_open.size(); i++) {
            int count = 0;
            display_info[22] += to_string(msg.nobility_open[i].point);
            display_info[22] += "(";
            for (int j = 0; j < 5; j++) {
                if (convert_color(msg.nobility_open[i], j) != 0)
                    display_info[22] += convert_number(j) + to_string(convert_color(msg.nobility_open[i], j));
                else
                    count += 3;
            }

            display_info[22] += ")";
            for (int j = 0; j < count; j++) {
                display_info[22] += " ";
            }
        }

        display_info[26] = "               Field Coin                 ";   //field coin
        temp = " \x1b[0m◆ : \x1b[0m" + to_string(msg.field_coin.white)
                + "  \x1b[34m● : \x1b[0m" + to_string(msg.field_coin.blue)
                + "  \x1b[32m■ : \x1b[0m" + to_string(msg.field_coin.green)
                + "  \x1b[31m♥ : \x1b[0m" + to_string(msg.field_coin.red)
                + "  \x1b[33m★ : \x1b[0m" + to_string(msg.field_coin.black);

        display_info[26] += temp;
        // for (int i = 0; i < 5; i++) {
        //     int count = 0;
        //     display_info[26] += to_string(msg.nobility_open[i].point);
        //     display_info[26] += "(";
        //     for (int j = 0; j < 5; j++) {
        //         if (convert_color(msg.nobility_open[i], j) != 0)
        //             display_info[26] += convert_number(j) + to_string(convert_color(msg.nobility_open[i], j));
        //         else
        //             count += 3;
        //     }

        //     display_info[22] += ")";
        //     for (int j = 0; j < count; j++) {
        //         display_info[26] += " ";
        //     }
        // }

        display_info[30].replace(50, 13, "Player score : " + to_string(msg.player_score));    //print Player
        temp = "coin :  \x1b[0m◆ : \x1b[0m" + to_string(msg.player_coin.white)
                + "  \x1b[34m● : \x1b[0m" + to_string(msg.player_coin.blue)
                + "  \x1b[32m■ : \x1b[0m" + to_string(msg.player_coin.green)
                + "  \x1b[31m♥ : \x1b[0m" + to_string(msg.player_coin.red)
                + "  \x1b[33m★ : \x1b[0m" + to_string(msg.player_coin.black);
        display_info[32].replace(35, 40, temp);

        temp = "card :  \x1b[0m◆ : \x1b[0m" + to_string(msg.player_card[WHITE].holder.size())
                + "  \x1b[34m● : \x1b[0m" + to_string(msg.player_card[BLUE].holder.size())
                + "  \x1b[32m■ : \x1b[0m" + to_string(msg.player_card[GREEN].holder.size())
                + "  \x1b[31m♥ : \x1b[0m" + to_string(msg.player_card[RED].holder.size())
                + "  \x1b[33m★ : \x1b[0m" + to_string(msg.player_card[BLACK].holder.size())
                + "  \x1b[0mN : \x1b[0m" + to_string(msg.player_card[NOBILITY].holder.size());

        display_info[34].replace(35, 45, temp);


        std::vector<std::vector<custom_msgs::card>> player_card;  //player's card  order = white, blue, green, red, black, nobility

        std::vector<std::vector<custom_msgs::card>> ai_card;  //ai's card


        for(int i = 0;i<display_info.size();i++)
            cout<<display_info[i]<<endl;

    }

    int Display::calc_index(int row, int col){
        return ((display_col + 1) * (row) ) + (col - 1);
    }

    string Display::convert_number(const int& token){
        if(token == 0)
            return "\x1b[0m◆ \x1b[0m";
        else if (token == 1)
            return "\x1b[34m● \x1b[0m";
        else if (token == 2)
            return "\x1b[32m■ \x1b[0m";
        else if (token == 3)
            return "\x1b[31m♥ \x1b[0m";
        else if (token == 4)
            return "\x1b[33m★ \x1b[0m";
    }

    string Display::convert_token(const string& token){
        if(token == "white")
            return "\x1b[0m◆ \x1b[0m";
        else if (token == "blue")
            return "\x1b[34m● \x1b[0m";
        else if (token == "green")
            return "\x1b[32m■ \x1b[0m";
        else if (token == "red")
            return "\x1b[31m♥ \x1b[0m";
        else if (token == "black")
            return "\x1b[33m★ \x1b[0m";
    }

    int Display::convert_color(const custom_msgs::card& card,const int& color){
        if(color == 0)
            return card.white;
        else if (color == 1)
            return card.blue;
        else if (color == 2)
            return card.green;
        else if (color == 3)
            return card.red;
        else if (color == 4)
            return card.black;
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

    init_keyboard();
    double act_time = 0.05;
    int count =0;
    //ros::spin();
    ros::AsyncSpinner spinner(4); // Use 4 threads
    spinner.start();
    while(1){
        sleep(0);
        if(_kbhit()){
            int buf = _getch();
            if(buf==27){    //esc
                close_keyboard();
                string tm = "rosnode kill -a";
                system(tm.c_str());
                break;
            }
            if(buf==10){    //enter

            }
        }
    }
    close_keyboard();
    // while (1)
    // {
    //     sleep(0);
    //     double start_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
    //     ros::spinOnce();
    //     di.display();
    //     double finish_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
    //     double rate = (double)(act_time * 1000000000 - (finish_time - start_time)) / 1000000000;
    //     if (rate > 0)
    //     {
    //         ros::Rate wait = 1 / rate;
    //         wait.sleep();
    //     }
    // }
    return 0;
}