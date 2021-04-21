#include "ros/ros.h"
#include "custom_msgs/axis.h"
#include "std_msgs/Empty.h"
#include "navi/ask_dist_mat.h"
#include "navi/want_route.h"
#include <vector>
#include <string>
#include <map>
#ifndef NAVI
#define NAVI

#define INF 100000


namespace Custom
{

    class Navi
    {
    private:
        ros::NodeHandle *node_handle;

        std::vector<std::vector<std::string>> map;
        std::vector<std::vector<int>> world_map;    //for A*
        std::vector<std::vector<int>> use_world_map;
        std::vector<std::vector<int>> map_matrix;
        std::map<int,custom_msgs::axis> point_name;   //위치의 번호
        std::vector<std::vector<int>> dist_mat;

        std::map<std::string, std::vector<std::vector<int>>> player_mat;

        /* params */

        double timer;   //init timer


    public:
        Navi(ros::NodeHandle &nh);
        ~Navi();

        

        

        //publisher


        //service client
        ros::ServiceClient get_player_state_cli;

        //callback
        void reset_Callback(const std_msgs::Empty& msg);
        void exit_Callback(const std_msgs::Empty& msg);

        //service callback
        bool ask_dist_mat_Callback(navi::ask_dist_mat::Request& req, navi::ask_dist_mat::Response& res);
        bool want_route_Callback(ros::ServiceEvent<navi::want_route::Request, navi::want_route::Response>& event);
    };
}   //close namespace

#endif