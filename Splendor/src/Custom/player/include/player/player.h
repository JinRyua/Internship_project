#include "ros/ros.h"
#include "rosplan_dispatch_msgs/ActionDispatch.h"


#include "std_msgs/Empty.h"

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

        rosplan_dispatch_msgs::ActionDispatch plan; //dispatched plan

   
        

    public:
        Player(ros::NodeHandle &nh);
        ~Player();

        int change_to_color_int_from_string(std::string& n);


        // //publisher
        ros::Publisher feedback_pub;

        // //service client
        ros::ServiceClient do_action_cli;

        // //callback
        void dispatch_callback(const rosplan_dispatch_msgs::ActionDispatch& msg);   //if dispatched convert do_action and publish 
    };
}   //close namespace

#endif