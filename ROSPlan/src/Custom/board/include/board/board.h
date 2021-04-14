#include "ros/ros.h"
#include "custom_msgs/axis.h"

#include <utility>
#include <set>

#ifndef BOARD
#define BOARD

namespace Custom
{
    class Board
    {
    private:
        ros::NodeHandle *node_handle;

        /* params */
        std::string kb;

        int game_state;

        int map_row, map_col;

        int selecting_menu;

        double timer;

        std::vector<std::string> agent_names;

        std::vector<custom_msgs::axis> init_player;
        std::vector<custom_msgs::axis> player;

        int life;
        int score;

        std::vector<std::pair<custom_msgs::axis, bool>> init_agents;
        std::vector<std::pair<custom_msgs::axis, bool>> agents;

        std::vector<std::vector<int>> init_map; 
        std::vector<std::vector<int>> map;

        std::vector<custom_msgs::axis> menu_screen;




    public:
        Board(ros::NodeHandle &nh);
        ~Board();

        //publisher

    };
}   //close namespace

#endif