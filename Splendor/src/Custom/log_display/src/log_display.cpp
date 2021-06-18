#include "log_display/log_display.h"
#include <iostream>

#include <chrono>

using namespace std;

namespace Custom{
    Log_Display::Log_Display(ros::NodeHandle &nh)
    {
        node_handle = &nh;

    }

    void Log_Display::displayCallback(const log_display::log_msg &msg)
    {
        str = msg.log_str;
        cout<<str<<endl;
    }
    void Log_Display::exitCallback(const std_msgs::Empty &msg)
    {
        exit(0);
    }

    

    Log_Display::~Log_Display() 
    {

    }


}//close namespace

int main(int argc, char **argv)
{
    ros::init(argc, argv, "log");
    ros::NodeHandle nh("~");

    Custom::Log_Display li(nh);

    //subscriber
    std::string display_topic = "/log_display/log";
    nh.getParam("display_name", display_topic);
    ros::Subscriber display_sub = nh.subscribe(display_topic, 1000, &Custom::Log_Display::displayCallback,
                                               dynamic_cast<Custom::Log_Display *>(&li));
    std::string exit_topic = "/board/exit_call";
    nh.getParam("exit_name", exit_topic);
    ros::Subscriber exit_sub = nh.subscribe(exit_topic, 1, &Custom::Log_Display::exitCallback,
                                            dynamic_cast<Custom::Log_Display *>(&li));


    ros::spin();

    return 0;
}