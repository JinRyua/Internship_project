#include "ros/ros.h"
#include "custom_msgs/axis.h"
#include "custom_msgs/map.h"
#include "board/ask_map_size.h"


#include <utility>
#include <set>
#include <string>
#include <vector>

#ifndef BOARD
#define BOARD

#define DONT_DISPLAY -1
#define MENU_START 0
#define MENU_END 1

#define IN_MENU 0
#define IN_GAME 1
namespace Custom
{
    class Board
    {
    private:
        ros::NodeHandle *node_handle;

        /* params */
        std::string kb;

        int game_state;     //게임 상태

        int map_row, map_col;   //맵 크기

        int selecting_menu; //고르고 있는 메뉴

        double timer;       //타이머

        std::vector<std::string> agent_names;       //problem의 에이전트이름

        std::vector<custom_msgs::axis> init_player; //플레이어 초기상태
        std::vector<custom_msgs::axis> player;      //플레이어 현 상태

        int life;       //목숨
        int score;      //점수

        std::vector<std::pair<custom_msgs::axis, bool>> init_agents;    //AI 초기상태
        std::vector<std::pair<custom_msgs::axis, bool>> agents;         //AI 현상태

        std::vector<std::vector<std::string>> init_map;     //초기 맵
        std::vector<std::vector<std::string>> map;          //현 맵

        std::vector<std::vector<std::string>> menu;          //메뉴 맵

        std::vector<custom_msgs::axis> menu_axis; //start, end 좌표




    public:
        Board(ros::NodeHandle &nh);
        ~Board();
        //run board
        void run_board();
        //publisher
        ros::Publisher display_pub;
        //select_

        //service
        bool ask_map_size_callback(board::ask_map_size::Request& req, board::ask_map_size::Response& res);


    };
}   //close namespace

#endif