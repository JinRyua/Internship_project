#include "ros/ros.h"
#include "custom_msgs/axis.h"
#include "ai_manager/ai_action.h"
#include "std_msgs/Empty.h"
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

        std::string node_name;

        int state;
        int plan_number;
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

        //void write_launch(std::vector<std::string>& f, const std::string path);     //write launch for agent

        //publisher
        ros::Publisher set_ai_loc_pub;
        ros::Publisher agent_state_pub;
        //ros::Publisher want_route_pub;
        //service client
        //ros::ServiceClient get_player_state_cli;

        //callback
        void dispatched_Callback(const ai_manager::ai_action& msg);
        void state_and_stop_Callback(const std_msgs::Empty& msg);
        //void act_dispatched_Callback(const rosplan_dispatch_msgs::ActionDispatch& msg);
       // void reset_Callback(const std_msgs::Empty& msg);
        //void exit_Callback(const std_msgs::Empty& msg);
        //void want_route_Callback(const navi::want_route& msg);

        //service callback
        //bool ask_dist_mat_Callback(navi::ask_dist_mat::Request& req, navi::ask_dist_mat::Response& res);
    };
}   //close namespace

#endif