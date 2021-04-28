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

        std::vector<custom_msgs::axis> player;
        std::vector<custom_msgs::axis> agents;
        std::vector<custom_msgs::axis> lcookies;
        std::vector<custom_msgs::map> map;
        std::vector<int> ghost;

        std::vector<custom_msgs::axis> post_player;     //post value for check  maybe...
        std::vector<custom_msgs::axis> post_agents;
        std::vector<custom_msgs::axis> post_lcookies;
        std::vector<custom_msgs::map> post_map;
        std::vector<int> post_ghost;

        std::vector<bool> agent_state_flag;
        
        
        
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
        Replanner(ros::NodeHandle &nh, std::string node_n);
        ~Replanner();
        
        void run_replanner();
        void check_replan();
        void update_ghost();
        //void write_launch(std::vector<std::string>& f, const std::string path);     //write launch for agent

        //publisher
        std::vector<ros::Publisher> agent_state_pub;
        ros::Publisher ask_state_pub;       //ask game state to board
        ros::Publisher stop_manager_pub;    //stop manager
        ros::Publisher change_pub;
        //ros::Publisher want_route_pub;
        //service client
        ros::ServiceClient cancel_dispatch_client;
        ros::ServiceClient player_state_client;
        //ros::ServiceClient get_player_state_cli;

        //callback
        void exit_Callback(const std_msgs::Empty& msg);
        void state_Callback(const board::game_state_msg& msg );
        void agent_state_Callback(const ros::MessageEvent<ai_agent::agent_state_time>& msg);
        void exitCallback(const std_msgs::Empty& msg);

        //void act_dispatched_Callback(const rosplan_dispatch_msgs::ActionDispatch& msg);
       // void reset_Callback(const std_msgs::Empty& msg);
        //void exit_Callback(const std_msgs::Empty& msg);
        //void want_route_Callback(const navi::want_route& msg);

        //service callback
        //bool ask_dist_mat_Callback(navi::ask_dist_mat::Request& req, navi::ask_dist_mat::Response& res);
    };
}   //close namespace

#endif