#include "Board/board.h"
#include <iostream>

using namespace std;

namespace Custom{
    Board_Interface::Board_Interface(ros::NodeHandle &nh)
    {
        node_handle = &nh;
    }

    Board_Interface::~Board_Interface() 
    {

    }

}//close namespace

int main(int argc, char **argv)
{
    ros::init(argc, argv, "Board_Interface");
    ros::NodeHandle nh("~");

    Custom::Board_Interface bi(nh);

    //subscriber
    

    std::cout<<"ready to run board"<<std::endl;
    // ROS_INFO("Custom: (%s) Ready to receive", ros::this_node::getName().c_str());


    ros::spin();
    return 0;
}