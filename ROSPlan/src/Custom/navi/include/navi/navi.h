#include "ros/ros.h"
#include "custom_msgs/axis.h"
#include "std_msgs/Empty.h"
#include "navi/ask_dist_mat.h"
#include "navi/want_route.h"
#include "navi/give_route.h"
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

        std::vector<std::vector<std::string>> map;  //map(string)
        std::vector<std::vector<int>> world_map;    //for A*
        std::vector<std::vector<int>> use_world_map;    //사용되는 world_map = > agent들 정보 저장
        std::vector<std::vector<int>> map_matrix;       //map_matrix
        std::map<int,custom_msgs::axis> point_name;   //위치의 번호
        std::vector<std::vector<int>> dist_mat; //distance matrix

        std::map<std::string, std::vector<std::vector<int>>> player_mat;    //player의 matrix

        /* params */

        double timer;   //init timer


    public:
        Navi(ros::NodeHandle &nh);
        ~Navi();

        //publisher
        ros::Publisher give_route_pub;      //계산한 경로 plan pub

        //service client
        ros::ServiceClient get_player_state_cli;        //player의 state 물어봄

        //callback
        void reset_Callback(const std_msgs::Empty& msg);        //reset call
        void exit_Callback(const std_msgs::Empty& msg);         //종료 callback
        void want_route_Callback(const navi::want_route& msg);      //경로 원하는 callback

        //service callback
        bool ask_dist_mat_Callback(navi::ask_dist_mat::Request& req, navi::ask_dist_mat::Response& res);    //dist_mat 원하는 service
    };
}   //close namespace

#endif