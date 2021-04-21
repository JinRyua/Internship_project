#include "ros/ros.h"
#include "custom_msgs/axis.h"
#include "custom_msgs/map.h"
#include "board/ask_map_size.h"
#include "board/ask_agent_srv.h"
#include "board/move_check_srv.h"
#include "board/set_ai_loc_msg.h"
#include "board/player_act_srv.h"
#include "board/select_menu_msg.h"
#include "board/ask_player_stat_srv.h"
#include "board/ask_map_srv.h"
#include "std_msgs/Empty.h"



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

#define LEFT 1
#define UP 2
#define RIGHT 3
#define DOWN 4

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

        float ghost_time;   //ghost 유지 시간

        double timer;       //타이머
        double ghost_timer;

        std::vector<std::string> agent_names;       //problem의 에이전트이름

        std::vector<custom_msgs::axis> init_player; //플레이어 초기상태
        std::vector<custom_msgs::axis> player;      //플레이어 현 상태
        bool in_grid;

        int life;       //목숨
        int score;      //점수

        std::vector<std::pair<custom_msgs::axis, bool>> init_agents;    //AI 초기상태
        std::vector<std::pair<custom_msgs::axis, bool>> agents;         //AI 현상태
        
        std::vector<std::vector<std::string>> init_map;     //초기 맵
        std::vector<std::vector<std::string>> map;          //현 맵

        std::vector<custom_msgs::axis> block;

        
        std::vector<custom_msgs::axis> scookies;
        std::vector<custom_msgs::axis> lcookies;
        std::vector<custom_msgs::axis> init_scookies;
        std::vector<custom_msgs::axis> init_lcookies;
        
        std::vector<std::vector<std::string>> menu;          //메뉴 맵

        std::vector<custom_msgs::axis> menu_axis; //start, end 좌표




    public:
        Board(ros::NodeHandle &nh);
        ~Board();
        //run board
        void run_board();
        //check function
        void check_timer();
        void check_eat_star();
        void check_collision(); //충돌 체크
        void do_collision(std::pair<custom_msgs::axis, bool>& agent);

        //publisher
        ros::Publisher display_pub;
        ros::Publisher state_response_pub;
        ros::Publisher exit_call_pub;
        std::vector<ros::Publisher> set_AI_pub;
        ros::Publisher reset_AI_pub;
        ros::Publisher change_state_pub;
        ros::Publisher set_player_pub;
        //select_

        //service
        bool ask_map_size_callback(board::ask_map_size::Request& req, board::ask_map_size::Response& res);
        bool ask_map_callback(board::ask_map_srv::Request& req, board::ask_map_srv::Response& res);
        bool ask_agent_srv_callback(board::ask_agent_srv::Request& req, board::ask_agent_srv::Response& res);
        bool move_check_srv_callback(board::move_check_srv::Request& req, board::move_check_srv::Response& res);
        bool player_action_callback(board::player_act_srv::Request& req, board::player_act_srv::Response& res);
        bool ask_player_stat_srv_callback(board::ask_player_stat_srv::Request& req, board::ask_player_stat_srv::Response& res);

        //sub callback
        void ask_state_callback(const ros::MessageEvent<std_msgs::Empty>& msg);
        void select_menu_callback(const board::select_menu_msg& msg);
        void set_ai_loc_callback(const ros::MessageEvent<board::set_ai_loc_msg>& msg);
        
        


    };
}   //close namespace

#endif