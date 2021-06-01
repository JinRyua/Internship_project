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

    // std::cout<<"ready to run display"<<std::endl;
    // // ROS_INFO("Custom: (%s) Ready to receive", ros::this_node::getName().c_str());


    // double act_time = 0.05;
    // int count =0;
    ros::spin();
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