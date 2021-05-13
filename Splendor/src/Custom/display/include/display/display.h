#include "ros/ros.h"
#include "display/display_info.h"
#include "std_msgs/Empty.h"
#include "custom_msgs/axis.h"
#include<utility>
#include <vector>
#ifndef DISPLAY
#define DISPLAY

#define PLAYER_TURN 1
#define AI_TURN 2
#define WAIT 3

#define WHITE 0
#define BLUE 1
#define GREEN 2
#define RED 3
#define BLACK 4
#define NOBILITY 5

namespace Custom
{

    class Display
    {
    private:
        ros::NodeHandle *node_handle;

        int display_row;
        int display_col;


    public:
        Display(ros::NodeHandle &nh);
        ~Display();

        void displayCallback(const display::display_info& msg);  //board가 보내는 display callback
        void exitCallback(const std_msgs::Empty& msg);  //board가 보내는 exit callback
        
        void display(); //display

        int calc_index(int row, int col);
        std::string convert_token(const std::string& token);
        int convert_color(const custom_msgs::card& card, const int& color);
        std::string convert_number(const int& token);
    };
}   //close namespace

#endif