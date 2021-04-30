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

        rosplan_knowledge_msgs::KnowledgeItem init_knowledge;
        rosplan_knowledge_msgs::KnowledgeItem knowledge;

        std::string node_name;

        int state;
        int plan_number;
        bool stop_flag;
        bool in_grid;
        std::vector<custom_msgs::axis> plan;
        // std::vector<std::vector<std::string>> map;
        // std::vector<std::vector<int>> world_map;    //for A*
        // std::vector<std::vector<int>> use_world_map;
        // std::vector<std::vector<int>> map_matrix;
        //std::vector<custom_msgs::axis> point_name;   //위치의 번호
        //std::vector<std::vector<int>> dist_mat;     //distance matrix

        //std::vector<std::string> agent_names;       //problem의 에이전트이름

        //std::vector<ros::Publisher> agent_pub;      //agent dispatch pub
        // std::map<std::string, std::vector<std::vector<int>>> player_mat;

        /* params */

        //double timer;   //init timer


    public:
        Ai_Agent(ros::NodeHandle &nh);
        ~Ai_Agent();

        void run_AI_Agent(double duration);
        void update_grid();

        //void write_launch(std::vector<std::string>& f, const std::string path);     //write launch for agent

        //publisher
        ros::Publisher set_ai_loc_pub;
        ros::Publisher agent_state_pub;
        ros::Publisher stop_response_pub;
        ros::Publisher feedback_pub;
        ros::Publisher state_time_pub;
        //ros::Publisher want_route_pub;
        //service client
        ros::ServiceClient update_knowledge_client;

        //callback
        void dispatched_Callback(const ai_manager::ai_action& msg);
        void state_Callback(const std_msgs::Empty& msg);
        void state_and_stop_Callback(const std_msgs::Empty& msg);
        void stop_Callback(const std_msgs::Empty& msg);
        void exit_Callback(const std_msgs::Empty& msg);
        void set_ai_Callback(const board::set_ai_msg& msg);
        void reset_ai_Callback(const board::reset_ai_msg& msg);
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