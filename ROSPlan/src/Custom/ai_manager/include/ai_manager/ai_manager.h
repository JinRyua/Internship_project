#include "ros/ros.h"
#include "custom_msgs/axis.h"
#include "rosplan_dispatch_msgs/ActionDispatch.h"
#include "std_msgs/Empty.h"
#include "board/game_state_msg.h"
#include "navi/give_route.h"
#include "ai_manager/ai_feedback.h"
#include <vector>
#include <string>
#ifndef AI_MANAGER
#define AI_MANAGER

#define NOT_DISPATCHED 0
#define ENABLE 1
#define ACHIEVED 2


namespace Custom
{

    class Ai_Manager
    {
    private:
        ros::NodeHandle *node_handle;
        
        // std::vector<std::vector<std::string>> map;
        // std::vector<std::vector<int>> world_map;    //for A*
        // std::vector<std::vector<int>> use_world_map;
        // std::vector<std::vector<int>> map_matrix;

        //game_state
        std::vector<custom_msgs::axis> player_axis;
        std::vector<custom_msgs::axis> agents_axis;
        std::vector<custom_msgs::axis> lcookies_loc;
        std::vector<int> ghost;

        //dispatched big plan
        rosplan_dispatch_msgs::ActionDispatch big_plan;

        std::vector<custom_msgs::axis> point_name;   //위치의 번호
        std::vector<std::vector<int>> dist_mat;     //distance matrix

        std::vector<std::string> agent_names;       //problem의 에이전트이름

        std::vector<bool> agent_dispatched;   //agent dispatched

        std::vector<std::vector<custom_msgs::axis>> plans;  //route
        std::vector<custom_msgs::axis> destination; //agents' destination
        // std::map<std::string, std::vector<std::vector<int>>> player_mat;

        /* params */
        bool dispatched = false;
        bool get_state = false;
        bool get_route = false;
        std::vector<int> agent_route_flag;
        bool get_agent_state = false;
        double timer;   //init timer


    public:
        Ai_Manager(ros::NodeHandle &nh);
        ~Ai_Manager();

        void write_launch(std::vector<std::string>& f, const std::string path);     //write launch for agent
        void run_AI_Manager();

        //publisher
        ros::Publisher action_feedback_pub;
        ros::Publisher want_route_pub;
        ros::Publisher game_state_pub;
        std::vector<ros::Publisher> agent_pub;      //agent dispatch pub
        //service client
        //ros::ServiceClient get_player_state_cli;

        //callback
        void act_dispatched_Callback(const rosplan_dispatch_msgs::ActionDispatch& msg);
        void exit_Callback(const std_msgs::Empty& msg);
        void stop_Callback(const std_msgs::Empty& msg);
        void get_state_Callback(const board::game_state_msg msg);
        void give_route_Callback(const navi::give_route& msg);
        void ai_feedback_Callback(const ros::MessageEvent<ai_manager::ai_feedback const >& event);
        void game_state_Callback(const board::game_state_msg& msg);
       // void reset_Callback(const std_msgs::Empty& msg);
        //void exit_Callback(const std_msgs::Empty& msg);
        //void want_route_Callback(const navi::want_route& msg);

        //service callback
        //bool ask_dist_mat_Callback(navi::ask_dist_mat::Request& req, navi::ask_dist_mat::Response& res);
    };
}   //close namespace

#endif