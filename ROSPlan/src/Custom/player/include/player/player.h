#include "ros/ros.h"
#include "custom_msgs/axis.h"
#include "board/change_state_msg.h"
#include "std_msgs/Empty.h"
#include "player/player_state_time_srv.h"
#include "board/set_ai_loc_msg.h"
#include <vector>
#ifndef PLAYER
#define PLAYER

#define MENU 0
#define WAIT 1
#define GAME 2

#define LEFT 1
#define UP 2
#define RIGHT 3
#define DOWN 4

namespace Custom
{

    class Player
    {
    private:
        ros::NodeHandle *node_handle;

        int speed;  //이동 속도
    
        int player_state;       //player FSM

        int want_direction;     //원하는 방향 (키보드)

        std::vector<custom_msgs::axis> init_player;     //초기위치
        std::vector<custom_msgs::axis> player;          //현 위치
        /* params */
        

    public:
        Player(ros::NodeHandle &nh);
        ~Player();

        void have_input(const int buf);     //input이 있는지(키보드)
        void ready_game();                  //game 준비 상태
        void run_action(double duration);   //action run(이동)

        //publisher
        ros::Publisher select_menu_pub;     //메뉴 선택
        ros::Publisher exit_pub;            //종료 call

        //service client
        ros::ServiceClient move_check_cli;      //움직일 수 있는지 물어보는 srv
        ros::ServiceClient player_action_cli;   //player action을 취해도 되는지 물어보는 srv

        //callback
        void change_state_Callback(const board::change_state_msg& msg); //state를 바꾸는 callback
        void exitCallback(const std_msgs::Empty& msg);      //종료 callback
        void setCallback(const board::set_ai_loc_msg& msg);     //set loc 하는 callback

        //service callback
        bool player_state_time_Callback(player::player_state_time_srv::Request& req, player::player_state_time_srv::Response& res); //플레이어의 상태를 주는 srv
    };
}   //close namespace

#endif