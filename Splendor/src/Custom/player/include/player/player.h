#include "ros/ros.h"
#include "rosplan_dispatch_msgs/ActionDispatch.h"

#include "custom_msgs/axis.h"
#include "board/change_state_msg.h"
#include "std_msgs/Empty.h"
#include "player/player_state_time_srv.h"
#include "board/set_ai_loc_msg.h"
#include <vector>
#include <string>
#ifndef PLAYER
#define PLAYER

#define WAIT 0
#define GAME 1

#define WHITE 0
#define BLUE 1
#define GREEN 2
#define RED 3
#define BLACK 4

namespace Custom
{

    class Player
    {
    private:
        ros::NodeHandle *node_handle;

        std::string node_name;

        int state;

        rosplan_dispatch_msgs::ActionDispatch plan;

        // int speed;

        // int player_state;

        // int want_direction;

        // std::vector<custom_msgs::axis> init_player;
        // std::vector<custom_msgs::axis> player;
        /* params */
        

    public:
        Player(ros::NodeHandle &nh);
        ~Player();

        int change_to_color_int_from_string(std::string& n);
        // void have_input(const int buf);
        // void ready_game();  
        // void run_action(double duration);

        // //publisher
        ros::Publisher feedback_pub;
        // ros::Publisher exit_pub;

        // //service client
        ros::ServiceClient do_action_cli;
        // ros::ServiceClient player_action_cli;

        // //callback
        void dispatch_callback(const rosplan_dispatch_msgs::ActionDispatch& msg);
        // void exitCallback(const std_msgs::Empty& msg);
        // void setCallback(const board::set_ai_loc_msg& msg);

        // //service callback
        // bool player_state_time_Callback(player::player_state_time_srv::Request& req, player::player_state_time_srv::Response& res);
    };
}   //close namespace

#endif