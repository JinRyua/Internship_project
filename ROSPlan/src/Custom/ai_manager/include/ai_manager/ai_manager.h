#include "ros/ros.h"
#include "custom_msgs/axis.h"
#include "rosplan_dispatch_msgs/ActionDispatch.h"
#include "std_msgs/Empty.h"
#include "board/game_state_msg.h"
#include "navi/give_route.h"
#include "ai_manager/ai_feedback.h"
#include "ai_manager/get_agent_state.h"
#include "rosplan_knowledge_msgs/DomainFormula.h"
#include "rosplan_knowledge_msgs/DomainOperator.h"
#include <vector>
#include <string>
#ifndef AI_MANAGER
#define AI_MANAGER

#define NOT_DISPATCHED 0
#define ENABLE 1
#define ACHIEVED 2


namespace Custom
{   
    struct oper_info {
        std::map<std::string, rosplan_knowledge_msgs::DomainFormula> predicates;
        std::map<std::string, rosplan_knowledge_msgs::DomainFormula> sensed_predicates;

        /* PDDL info and publisher */
        rosplan_knowledge_msgs::DomainFormula params;
        rosplan_knowledge_msgs::DomainOperator op;
    };

    class Ai_Manager
    {
    private:
        ros::NodeHandle *node_handle;

        std::string node_name;

        //game_state
        std::vector<custom_msgs::axis> player_axis; //플레이어 위치
        std::vector<custom_msgs::axis> agents_axis; //에이전트 위치
        std::vector<custom_msgs::axis> lcookies_loc;    //큰 쿠키 위치
        std::vector<int> ghost;

        //dispatched big plan
        std::vector<rosplan_dispatch_msgs::ActionDispatch> big_plan;

        std::vector<custom_msgs::axis> point_name;   //위치의 번호
        std::vector<std::vector<int>> dist_mat;     //distance matrix

        std::vector<std::string> agent_names;       //problem의 에이전트이름

        std::vector<bool> agent_dispatched;   //agent dispatched

        std::vector<std::vector<custom_msgs::axis>> plans;  //route
        std::vector<custom_msgs::axis> destination; //agents' destination

        std::vector< std::pair<custom_msgs::axis, float> > agent_state_time;    //state and time after stop

        std::vector<int> agent_route_flag;  //agent_route_flag
        std::vector<bool> agent_stop_flag;  //stop flag
        // std::map<std::string, std::vector<std::vector<int>>> player_mat;

        std::map<std::string, struct oper_info> operator_info;  //operator info for update kb

        /* params */
        bool dispatched = false;
        bool get_state = false;
        bool get_route = false;
       
        bool get_agent_state = false;
        double timer;   //init timer


    public:
        Ai_Manager(ros::NodeHandle &nh, std::string node_n);
        ~Ai_Manager();

        void write_launch(std::vector<std::string>& f, const std::string path);     //write launch for agent
        void run_AI_Manager();
        void calc_dest();    //calc dest (from now to destination)
        void init_oper();   //init operator
        void update_start(int id);      //미사용
        void update_end(int id);        //미사용

        //publisher
        ros::Publisher action_feedback_pub;     //dispatcher에게 보내는 feedback
        ros::Publisher want_route_pub;          //navi 에게 경로 물어보는 pub
        ros::Publisher game_state_pub;          //board에게 game_state 물어보는 pub
        ros::Publisher change_pub;              //change_pub 게임 상태를 바꾸는 pub
        std::vector<ros::Publisher> agent_pub;      //agent dispatch pub
        std::vector<ros::Publisher> get_state_stop_agent_pub;    //get state and stop agent to agent
        
        //service client
        ros::ServiceClient update_knowledge_client; //for update kb

        //callback
        void act_dispatched_Callback(const rosplan_dispatch_msgs::ActionDispatch& msg);     //dispatched 되었을 때 함수
        void exit_Callback(const std_msgs::Empty& msg);     //종료 함수
        void stop_Callback(const std_msgs::Empty& msg);     //정지 call 함수
        void get_state_Callback(const board::game_state_msg msg);       //물어본 state 물어보는 callback
        void give_route_Callback(const navi::give_route& msg);          //물어본 경로 받는 callback
     
        void ai_feedback_Callback(const ros::MessageEvent<ai_manager::ai_feedback const >& event);      //ai에게 feedback 받는 callback
        void game_state_Callback(const board::game_state_msg& msg);     //state 원하는 callback
        void get_and_stop_Callback(const std_msgs::Empty& msg);         //멈추고 상태 받는 callback
        void get_agent_state_Callback(const ros::MessageEvent<ai_manager::get_agent_state const >& msg);    //특정 agent state받는 callback
      
    };
}   //close namespace

#endif