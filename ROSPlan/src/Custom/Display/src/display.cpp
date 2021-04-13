#include "Display/display.h"
#include <iostream>
#include <chrono>

using namespace std;

namespace Custom{

    void Display_Interface::displayCallback(const Display::display_msg &msg)
    {
        display_info = msg.msg; 
    }

    void Display_Interface::exitCallback(const std_msgs::Empty &msg)
    {
        exit(0);
    }

    Display_Interface::Display_Interface(ros::NodeHandle &nh)
    {
        node_handle = &nh;
        display_info = "hi";
    }

    Display_Interface::~Display_Interface() 
    {

    }

    void Display_Interface::display(){
        cout<<display_info<<endl;
    }

}//close namespace

int main(int argc, char **argv)
{
    ros::init(argc, argv, "display_interface");
    ros::NodeHandle nh("~");

    Custom::Display_Interface di(nh);

    //subscriber
    std::string display_topic = "/Display/display";
    nh.getParam("display_name", display_topic);
    ros::Subscriber display_sub = nh.subscribe(display_topic, 1000, &Custom::Display_Interface::displayCallback,
                                               dynamic_cast<Custom::Display_Interface *>(&di));
    std::string exit_topic = "/Board/exit_call";
    nh.getParam("exit_name", exit_topic);
    ros::Subscriber exit_sub = nh.subscribe(exit_topic, 1, &Custom::Display_Interface::exitCallback,
                                            dynamic_cast<Custom::Display_Interface *>(&di));

    std::cout<<"ready to run display"<<std::endl;
    // ROS_INFO("Custom: (%s) Ready to receive", ros::this_node::getName().c_str());


    double act_time = 0.033;
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