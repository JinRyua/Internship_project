#include "ros/ros.h"
#include "custom_msgs/axis.h"
#include "ai_manager/ai_action.h"
#include "std_msgs/Empty.h"
#include "board/reset_ai_msg.h"
#include "board/set_ai_msg.h"
#include "rosplan_knowledge_msgs/KnowledgeItem.h"
#include <vector>
#include <string>
#ifndef AI_AGENT
#define AI_AGNET

#define IDLE 0
#define RUN 1

#define LEFT 1
#define UP 2
#define RIGHT 3
#define DOWN 4


namespace Custom
{

    class Ai_Agent
    {
    private:
        ros::NodeHandle *node_handle;

        int speed;

        custom_msgs::axis agent;    //axis
        custom_msgs::axis post_agent;  //

        rosplan_knowledge_msgs::KnowledgeItem init_knowledge;   //초기화 knowledge
        rosplan_knowledge_msgs::KnowledgeItem knowledge;    //사용 knowledge

        std::string node_name;

        int state;      //FSM state
        int plan_number;    //plan number
        bool stop_flag;     //agent stop flag
        bool replan_flag;   //replanning flag
        bool in_grid;       //is agent in grid
        std::vector<custom_msgs::axis> plan;    //move plan
        


    public:
        Ai_Agent(ros::NodeHandle &nh);
        ~Ai_Agent();

        void run_AI_Agent(double duration);     //agent run
        void update_grid();     //kb에 update 하는 함수 (in grid)

        //publisher
        ros::Publisher set_ai_loc_pub;      //board에게 ai 위치 pub
        ros::Publisher agent_state_pub;     //agent의 state를 pub
        ros::Publisher stop_response_pub;       //stop 명령의 response pub
        ros::Publisher feedback_pub;            //feedback(dispatch) 
        ros::Publisher state_time_pub;          //agent의 state와 남은 time pub
        ros::Publisher call_replan_pub;         //call replan_pub -> plan 다끝남

        //service client
        ros::ServiceClient update_knowledge_client; //kb update

        //callback
        void dispatched_Callback(const ai_manager::ai_action& msg);     //plan dispatch 받고 저장하는 함수
        void state_Callback(const std_msgs::Empty& msg);                //state를 질문 받는 call back
        void state_and_stop_Callback(const std_msgs::Empty& msg);       //stop을 하고 state를 질문 받는 callback
        void stop_Callback(const std_msgs::Empty& msg);                 //무조건적 stop을 원하는 callback
        void exit_Callback(const std_msgs::Empty& msg);                 //종료 callback
        void set_ai_Callback(const board::set_ai_msg& msg);             //agent 상태 변경 callback
        void reset_ai_Callback(const board::reset_ai_msg& msg);         //ai 초기화 callback
        //TODO: reset ai -> ai?

        //void act_dispatched_Callback(const rosplan_dispatch_msgs::ActionDispatch& msg);
       // void reset_Callback(const std_msgs::Empty& msg);
        //void exit_Callback(const std_msgs::Empty& msg);
        //void want_route_Callback(const navi::want_route& msg);

        //service callback
        //bool ask_dist_mat_Callback(navi::ask_dist_mat::Request& req, navi::ask_dist_mat::Response& res);
    };
}   //close namespace

#endif