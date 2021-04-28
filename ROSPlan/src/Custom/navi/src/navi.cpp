#include "navi/navi.h"
#include "board/ask_map_srv.h"
#include "custom_msgs/map.h"
#include "custom_msgs/matrix.h"
#include "navi/findpath.h"      //AStar
#include "navi/give_route.h"
#include "custom_msgs/plan.h"

#include <iostream>
#include <chrono>
#include <cmath>
using namespace std;

int getSmallIndex(int& number, vector<bool>& visited, vector<int>& distance)
{
    int min = INF;
    int index = 0;

    for (int i = 0; i < number; i++)
    {
        // 방문하지 않았고, 현재 최솟값보다 더 작은 비용을 가지는 거리가 존재한다면,
        // 최솟값 갱신
        if (distance[i] < min && !visited[i])
        {
            min = distance[i];
            index = i; // 최소 비용의 위치 기억
        }
    }
    return index;
}

// 다익스트라 수행(특정 정점에서 다른 모든 정점으로 가는 최소비용 구하는 함수)
void dijkstra(int start , int& number, vector<bool>& visited, vector<int>& distance, vector<vector<int>>& a)
{
    for (int i = 0; i < number; i++)
    {
        distance[i] = a[start][i]; // 시작점에서 출발했을 때, 모든 경로까지의 비용 담아줌
    }
    visited[start] = true; // 시작점 방문

    for (int i = 0; i < number - 2; i++)
    {                                  // 첫 노드, 마지막 노드 제외(-2)
        int current = getSmallIndex(number, visited, distance); // 현재 방문하지 않은 노드 중, 가장 비용이 적게드는 인덱스를 가져오고,
        visited[current] = true;       // 방문처리

        // 그 노드에 인접한 모든 노드 확인
        for (int j = 0; j < number; j++)
        {
            if (!visited[j])
            {
                if (distance[current] + a[current][j] < distance[j])
                {
                    distance[j] = distance[current] + a[current][j];
                }
            }
        }
    }
}  

//다익스트라 출처 https://velog.io/@max9106/Algorithm-%EB%8B%A4%EC%9D%B5%EC%8A%A4%ED%8A%B8%EB%9D%BC-%EC%95%8C%EA%B3%A0%EB%A6%AC%EC%A6%98Dijkstra-Algorithm


namespace Custom{
    Navi::Navi(ros::NodeHandle &nh){
        node_handle = &nh;


        std::string give_topic = "/navi/give_route";
        nh.getParam("give_name", give_topic);
        give_route_pub = nh.advertise<navi::give_route>(give_topic, 1000);

        std::string map_topic = "/board/ask_map";
        nh.getParam("map_name", map_topic);
        ros::service::waitForService(map_topic, ros::Duration(20));
        ros::ServiceClient client = nh.serviceClient<board::ask_map_srv>(map_topic);
        board::ask_map_srv srv;

        player_mat.clear();

        vector<custom_msgs::map> map_temp;
        if (client.call(srv)){
            map_temp = srv.response.map;
        }
        else{
        }

        map.clear();
        for(int i = 0; i < map_temp.size(); i++){
            vector<string> temp = map_temp[i].value;
            map.push_back(temp);
        }

        world_map.clear();
        int count = 0;
        for(int i = 0; i < map.size(); i++){            //make point's number and make world map(int)
            vector<int> world_temp;
            world_temp.clear();
            for(int j = 0; j < map[i].size(); j++){
                if(map[i][j] != "■"){
                    custom_msgs::axis temp;
                    temp.row = i + 1;
                    temp.col = j + 1;
                    point_name.insert({count, temp});
                    count++;
                    world_temp.push_back(1);
                }
                else{
                    world_temp.push_back(INF);
                }
            }
            world_map.push_back(world_temp);
        }

        int row = map.size();               //make map matrix
        int col = map[0].size();
        int size = point_name.size();
        for(int i = 0; i < point_name.size(); i++){
            std::vector<int> temp_vec(size, INF); //10000 = infinite
            custom_msgs::axis temp_axis = point_name[i];
            for(int j = 0; j < size; j++){
                if( (abs( point_name[j].row - temp_axis.row) + abs(point_name[j].col - temp_axis.col)) == 1){
                    temp_vec[j] = 1;
                } 
            }
            temp_vec[i] = 0;
            map_matrix.push_back(temp_vec);
        }
        //make dist mat use diikstra
        dist_mat.clear();
        vector<bool> init_visited(size, false);
        vector<int> init_distance(size, 0);
        for(int i = 0; i < map_matrix.size(); i++){
            vector<bool> visited = init_visited;
            vector<int> distance = init_distance;
            dijkstra(i, size, visited, distance, map_matrix);
            dist_mat.push_back(distance);
        }

        //use_dist_mat = dist_mat;

        timer = 0;

        use_world_map = world_map;
        // custom_msgs::axis from;
        // from.row = 2;
        // from.col = 2;
        // custom_msgs::axis to;
        // to.row = 25;
        // to.col = 20;
        
        // double now_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
        
        // run_star(from, to,world_map);
        // double noww_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();

        // cout<<(noww_time-now_time)/1000000000<<endl;
        

        // for(int i = 0; i < world_map.size(); i++){
        //     for(int j = 0; j < world_map[i].size(); j++){
        //         cout<<world_map[i][j]<<" ";
        //     }
        //     cout<<endl;
        // }
       
    }
    
    Navi::~Navi(){

    }

    void Navi::reset_Callback(const std_msgs::Empty& msg){
        use_world_map = world_map;
        player_mat.clear();
        return;
    }
    void Navi::exit_Callback(const std_msgs::Empty& msg){
        exit(0);
    }

    bool Navi::ask_dist_mat_Callback(navi::ask_dist_mat::Request& req, navi::ask_dist_mat::Response& res){
        vector<custom_msgs::matrix> temp_mat;
        vector<custom_msgs::axis> temp_number;
        for(int i = 0; i < dist_mat.size(); i++){
            custom_msgs::matrix temp;
            temp.value = dist_mat[i];
            temp_mat.push_back(temp);

            temp_number.push_back(point_name[i]);
        }
        
        res.dist_mat = temp_mat;
        res.num_name = temp_number;
        return true;
    }

// navi::want_route::Request& req, navi::want_route::Response& res)
    void Navi::want_route_Callback(const navi::want_route& msg){
        vector<string> a = msg.name;
        vector<custom_msgs::plan> plans;
        for (int k = 0; k < a.size(); k++) {
            double now_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
            if (now_time >= timer) {  //run out timer
                use_world_map = world_map;
                player_mat.clear();
                timer = now_time + ((double)(30) * 1000000000);
            }

            //get player state  why need???
            // std::string topic = "/player/player_state_time";
            // ros::service::waitForService(topic, ros::Duration(20));
            // ros::ServiceClient client = nh.serviceClient<player::player_state_time_srv>(topic);
            // player::player_state_time_srv srv;

            // vector<custom_msgs::axis> player;
            // if (client.call(srv)){
            //     player = srv.response.player;
            // }
            // else{
            // }

            //중복 처리
            //cout << "hi" << endl;
            auto it = player_mat.find(msg.name[k]);
            if (it != player_mat.end()) {  //이미 route가 있으면 제거
                for (int i = 0; i < use_world_map.size(); i++) {
                    for (int j = 0; j < use_world_map[i].size(); j++) {
                        use_world_map[i][j] = use_world_map[i][j] - it->second[i][j];  //mat 제거
                    }
                }
                player_mat.erase(it);  //제거
            }

            vector<custom_msgs::axis> plan;
            run_star(msg.from[k], msg.to[k], use_world_map, plan);

            custom_msgs::plan response;
            response.name = msg.name[k];
            response.plan = plan;
            plans.push_back(response);

            //make player_mat and update use_world_map
            vector<int> temp(world_map[0].size(), 0);
            vector<vector<int>> temp_mat(world_map.size(), temp);
            for (int i = 0; i < plan.size(); i++) {
                temp_mat[plan[i].row - 1][plan[i].col - 1] = 5;
                use_world_map[plan[i].row - 1][plan[i].col - 1] += 5;
            }
            player_mat.insert(pair<string, vector<vector<int>>>(msg.name[k], temp_mat));
        }
        navi::give_route res;
        res.plans = plans;
        give_route_pub.publish(res);
        return;
    }
}


int main(int argc, char **argv)
{
    ros::init(argc, argv, "player");
    ros::NodeHandle nh("~");

    Custom::Navi ni(nh);

     //subscriber
    std::string reset_topic = "/navi/reset";
    nh.getParam("reset_name", reset_topic);
    ros::Subscriber reset_sub = nh.subscribe(reset_topic, 1000, &Custom::Navi::reset_Callback,
                                               dynamic_cast<Custom::Navi *>(&ni));

    std::string exit_topic = "/board/exit_call";
    nh.getParam("exit_name", exit_topic);
    ros::Subscriber exit_sub = nh.subscribe(exit_topic, 1, &Custom::Navi::exit_Callback,
                                            dynamic_cast<Custom::Navi *>(&ni));

    std::string want_topic = "/navi/want_route";
    nh.getParam("want_name", want_topic);
    ros::Subscriber want_sub = nh.subscribe(want_topic, 1, &Custom::Navi::want_route_Callback, dynamic_cast<Custom::Navi *>(&ni));

    //service server
    ros::ServiceServer ask_dist_mat_srv = nh.advertiseService("/navi/ask_dist_mat", &Custom::Navi::ask_dist_mat_Callback, dynamic_cast<Custom::Navi *>(&ni));
    

    ros::Rate loopRate(1);
    ros::AsyncSpinner spinner(4);		//다중 스레드 사용
    spinner.start();
    ros::waitForShutdown();
    return 0;    
}