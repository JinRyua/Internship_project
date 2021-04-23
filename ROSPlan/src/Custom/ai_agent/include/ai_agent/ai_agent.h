#include "ros/ros.h"
#include "custom_msgs/axis.h"
#include "rosplan_dispatch_msgs/ActionDispatch.h"
#include <vector>
#include <string>
#ifndef AI_MANAGER
#define AI_MANAGER


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
        std::vector<custom_msgs::axis> point_name;   //위치의 번호
        std::vector<std::vector<int>> dist_mat;     //distance matrix

        std::vector<std::string> agent_names;       //problem의 에이전트이름

        std::vector<ros::Publisher> agent_pub;      //agent dispatch pub
        // std::map<std::string, std::vector<std::vector<int>>> player_mat;

        /* params */

        double timer;   //init timer


    public:
        Ai_Manager(ros::NodeHandle &nh);
        ~Ai_Manager();

        void write_launch(std::vector<std::string>& f, const std::string path);     //write launch for agent

        //publisher
        ros::Publisher action_feedback_pub;
        ros::Publisher want_route_pub;
        //service client
        //ros::ServiceClient get_player_state_cli;

        //callback
        void act_dispatched_Callback(const rosplan_dispatch_msgs::ActionDispatch& msg);
       // void reset_Callback(const std_msgs::Empty& msg);
        //void exit_Callback(const std_msgs::Empty& msg);
        //void want_route_Callback(const navi::want_route& msg);

        //service callback
        //bool ask_dist_mat_Callback(navi::ask_dist_mat::Request& req, navi::ask_dist_mat::Response& res);
    };
}   //close namespace

#endif