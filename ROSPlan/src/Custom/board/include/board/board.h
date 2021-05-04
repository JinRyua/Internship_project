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
#include "rosplan_knowledge_msgs/KnowledgeItem.h"



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
        double ghost_timer; //유령화 타이머

        std::vector<std::string> agent_names;       //problem의 에이전트이름

        std::vector<custom_msgs::axis> init_player; //플레이어 초기상태
        std::vector<custom_msgs::axis> player;      //플레이어 현 상태
        bool in_grid;       //player가 grid에 있는가?

        int life;       //목숨
        int score;      //점수

        std::vector<std::pair<custom_msgs::axis, bool>> init_agents;    //AI 초기상태
        std::vector<std::pair<custom_msgs::axis, bool>> agents;         //AI 현상태
        
        std::vector<std::vector<std::string>> init_map;     //초기 맵
        std::vector<std::vector<std::string>> map;          //현 맵

        std::vector<custom_msgs::axis> block;   //벽의 위치들

        
        std::vector<custom_msgs::axis> scookies;    //현재 작은 쿠키의 위치들
        std::vector<custom_msgs::axis> lcookies;    //현재 큰 쿠키의 위치들
        std::vector<custom_msgs::axis> init_scookies;   //작은 쿠키의 위치들의 초기 상태
        std::vector<custom_msgs::axis> init_lcookies;   //작은 쿠키의 위치들의 초기 상태
        
        std::vector<std::vector<std::string>> menu;          //메뉴 맵

        std::vector<custom_msgs::axis> menu_axis; //start, end 좌표

        rosplan_knowledge_msgs::KnowledgeItem post_knowledge;   //player's post knowledge
        rosplan_knowledge_msgs::KnowledgeItem knowledge;




    public:
        Board(ros::NodeHandle &nh);
        ~Board();
        //run board
        void run_board();       //main 작동함수
        //check function
        void check_timer();     //timer들 체크
        void check_eat_star();  //star(cookie) 먹었는지 체크
        void check_collision(); //충돌 체크(agent와)
        void do_collision(std::pair<custom_msgs::axis, bool>& agent, int i);   //충돌시 작동 함수

        //service client
        ros::ServiceClient update_knowledge_client;

        //publisher
        ros::Publisher display_pub;                 //display 정보를 주는 display/display
        ros::Publisher state_response_pub;          //현재 game state를 주는 pub
        ros::Publisher exit_call_pub;               //모든 노드에게 exit call을 하는 pub
        std::vector<ros::Publisher> set_AI_pub;     //특정 agent에게 set value을 하는 pub(속도 등) 
        ros::Publisher reset_AI_pub;                //모든 agent에게 reset을 명령하는 pub
        ros::Publisher change_state_pub;            //player의 상태를 변경하는 pub
        ros::Publisher set_player_pub;              //player의 데이터를 set하는 pub 
        //select_

        //service
        bool ask_map_size_callback(board::ask_map_size::Request& req, board::ask_map_size::Response& res);          //맵의 size를 return하는 srv
        bool ask_map_callback(board::ask_map_srv::Request& req, board::ask_map_srv::Response& res);     //맵 정보를 return 하는 srv
        bool ask_agent_srv_callback(board::ask_agent_srv::Request& req, board::ask_agent_srv::Response& res);   //agent의 이름들을 return 하는 srv
        bool move_check_srv_callback(board::move_check_srv::Request& req, board::move_check_srv::Response& res);    //player가 move할 수 있는지 확인하는 srv
        bool player_action_callback(board::player_act_srv::Request& req, board::player_act_srv::Response& res);     //player의 action을 수행하고 결과를 리턴하는 srv
        bool ask_player_stat_srv_callback(board::ask_player_stat_srv::Request& req, board::ask_player_stat_srv::Response& res); //player의 초기 상태를 물어보는 srv

        //sub callback
        void ask_state_callback(const ros::MessageEvent<std_msgs::Empty>& msg); //현재 게임 상태를 물어보는 sub
        void select_menu_callback(const board::select_menu_msg& msg);           //menu를 선택하는 sub
        void set_ai_loc_callback(const ros::MessageEvent<board::set_ai_loc_msg>& msg);  //ai가 자신의 위치를 set하는 sub
        void exit_callback(const std_msgs::Empty& msg);

    };
}   //close namespace

#endif