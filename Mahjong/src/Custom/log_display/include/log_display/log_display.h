#include "ros/ros.h"
#include "log_display/log_msg.h"
#include "std_msgs/Empty.h"
#include <string>
#ifndef LOG_DISPLAY
#define LOG_DISPLAY


namespace Custom
{

    class Log_Display
    {
    private:
        ros::NodeHandle *node_handle;

        std::string str;

    public:
        Log_Display(ros::NodeHandle &nh);
        ~Log_Display();

        void displayCallback(const log_display::log_msg& msg);  //board가 보내는 display callback
        void exitCallback(const std_msgs::Empty& msg);  //board가 보내는 exit callback
        
    };
}   //close namespace

#endif