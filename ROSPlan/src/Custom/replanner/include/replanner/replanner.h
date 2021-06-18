#include "ros/ros.h"
#include "custom_msgs/axis.h"
#include "custom_msgs/map.h"
#include "std_msgs/Empty.h"
#include "board/game_state_msg.h"
#include "ai_agent/agent_state_time.h"
#include <vector>
#include <string>
#ifndef REPLANNER
#define REPLANNER

#define WAIT -2
#define NO_GAME -1
#define IDLE 0
#define CHECK 1
#define CANCEL 2
#define JUDGE 3
#define UPDATE 4
#define GO_PLAN 5

namespace Custom
{

    class Replanner
    {
    private:
        ros::NodeHandle *node_handle;

        std::string node_name;
        
        double timer;
        int state;
        

        std::vector<std::string> agent_names;       //agent_names

        std::vector<custom_msgs::axis> player;      // player, agent lcookies 위치
        std::vector<custom_msgs::axis> agents;
        std::vector<custom_msgs::axis> lcookies;
        std::vector<custom_msgs::map> map;      //맵
        std::vector<int> ghost;     //유령화 상태

        //need plan

        std::vector<custom_msgs::axis> post_player;     //post value for check  maybe...
        std::vector<custom_msgs::axis> post_agents;     
        std::vector<custom_msgs::axis> post_lcookies;
        std::vector<custom_msgs::map> post_map;
        std::vector<int> post_ghost;

        std::vector<bool> agent_state_flag;     //에이전트 상태를 받았는지 체크하는 flag
        
        
       


    public:
        Replanner(ros::NodeHandle &nh, std::string node_n);
        ~Replanner();
        
        void run_replanner();       //replanner 실행 함수
        void check_replan();        //리플래닝이 필요한지 체크하고 replan call
        void update_ghost();        //유령화 상태 update
        //void write_launch(std::vector<std::string>& f, const std::string path);     //write launch for agent

        //publisher
        std::vector<ros::Publisher> agent_state_pub;        //agent state 물어봄
        ros::Publisher ask_state_pub;       //ask game state to board
        ros::Publisher stop_manager_pub;    //stop manager
        ros::Publisher change_pub;          //change state pub
        ros::Publisher reset_pub;           //reset state pub
        //service client
        ros::ServiceClient cancel_dispatch_client;  //dispatch 멈추라는 call
        ros::ServiceClient player_state_client;     //player의 상태 물어보는 call

        //callback
        void exit_Callback(const std_msgs::Empty& msg);     //종료 callback
        void state_Callback(const board::game_state_msg& msg );     //state를 받는 (board에게) callback
        void agent_state_Callback(const ros::MessageEvent<ai_agent::agent_state_time>& msg);    //agent_state 받는 callback
        void exitCallback(const std_msgs::Empty& msg);      
        void callCallback(const std_msgs::Empty& msg);      //replan 실행되었는지 callback
        void dispatchCallback(const std_msgs::Empty& msg);      //dispatch 하기 시작했는지 callback

    };
}   //close namespace

#endif