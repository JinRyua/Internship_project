#include "ros/ros.h"
#ifndef BOARD_INTERFACE
#define BOARD_INTERFACE

namespace Custom
{
    class Board_Interface
    {
    private:
        ros::NodeHandle *node_handle;

        /* params */
        std::string Board_name;

    public:
        Board_Interface(ros::NodeHandle &nh);
        virtual ~Board_Interface();

    };
}   //close namespace

#endif