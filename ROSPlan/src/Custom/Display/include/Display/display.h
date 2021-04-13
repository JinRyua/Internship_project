#include "ros/ros.h"
#include "Display/display_msg.h"
#include "std_msgs/Empty.h"
#ifndef DISPLAY_INTERFACE
#define DISPLAY_INTERFACE

namespace Custom
{
    class Display_Interface
    {
    private:
        ros::NodeHandle *node_handle;

        /* params */
        std::string Board_name;

        std::string display_info;   //디스플레이 할 내용

    public:
        Display_Interface(ros::NodeHandle &nh);
        virtual ~Display_Interface();

        void displayCallback(const Display::display_msg& msg);
        void exitCallback(const std_msgs::Empty& msg);
        void display();
    };
}   //close namespace

#endif