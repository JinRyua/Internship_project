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

        int speed;

        int player_state;

        int want_direction;

        std::vector<custom_msgs::axis> init_player;
        std::vector<custom_msgs::axis> player;
        /* params */
        

    public:
        Player(ros::NodeHandle &nh);
        ~Player();

        void have_input(const int buf);
        void ready_game();  
        void run_action(double duration);

        //publisher
        ros::Publisher select_menu_pub;

        //service client
        ros::ServiceClient move_check_cli;
        ros::ServiceClient player_action_cli;

        //callback
        void change_state_Callback(const board::change_state_msg& msg);
        void exitCallback(const std_msgs::Empty& msg);
        void setCallback(const board::set_ai_loc_msg& msg);

        //service callback
        bool player_state_time_Callback(player::player_state_time_srv::Request& req, player::player_state_time_srv::Response& res);
    };
}   //close namespace

#endif