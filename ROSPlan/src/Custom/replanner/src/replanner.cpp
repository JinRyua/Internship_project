#include "replanner/replanner.h"
#include "board/game_state_msg.h"
#include "std_srvs/Empty.h"
#include "player/player_state_time_srv.h"
#include "rosplan_knowledge_msgs/KnowledgeUpdateServiceArray.h"
#include "rosplan_knowledge_msgs/KnowledgeItem.h"
#include "board/ask_agent_srv.h"
#include <chrono>
#include <iostream>

#include "ros/ros.h"
using namespace std;

namespace Custom{
    Replanner::Replanner(ros::NodeHandle &nh) {
        node_handle = &nh;

        timer = 0;
        state = IDLE;

        std::string get_agent_topic = "/board/ask_agent";       //get agent_names
        nh.getParam("agent_name", get_agent_topic);
        ros::service::waitForService(get_agent_topic, ros::Duration(20));
        ros::ServiceClient get_agent_client = nh.serviceClient<board::ask_agent_srv>(get_agent_topic);
        board::ask_agent_srv get_agent_srv;

        agent_names.clear();

        if (get_agent_client.call(get_agent_srv)){
            agent_names = get_agent_srv.response.agents_name;
        }

        agents.resize(agent_names.size());      //set vector size
        agent_state_flag.resize(agent_names.size(), false);


        //publihser
        agent_state_pub.resize(agent_names.size());
        for(int i = 0; i < agent_names.size(); i++){
            std::string agent_state_topic = "/ai_agent/get_state_agent/to_"+agent_names[i];
            agent_state_pub[i] = nh.advertise<std_msgs::Empty>(agent_state_topic, 1000);
        }

        std::string ask_state_topic = "/board/ask_state";
        ask_state_pub = nh.advertise<std_msgs::Empty>(ask_state_topic, 1000);

        std::string stop_manager_topic = "/ai_manager/stop_manager";
        stop_manager_pub = nh.advertise<std_msgs::Empty>(stop_manager_topic, 1000);
        
        //service
        std::string s = "/rosplan_plan_dispatcher/cancel_dispatch";
        ros::service::waitForService(s, ros::Duration(20));
        cancel_dispatch_client = nh.serviceClient<std_srvs::Empty>(s);

        s = "/player/player_state_time";     //get player state and time
        ros::service::waitForService(s, ros::Duration(20));
        player_state_client = nh.serviceClient<player::player_state_time_srv>(s);
        
    }

    Replanner::~Replanner() {
    }

    void Replanner::state_Callback(const board::game_state_msg& msg ){
        post_player = player;
        post_agents = agents;
        post_lcookies = lcookies;
        post_ghost = ghost;
        
        player = msg.player_axis;
        agents = agents;
        lcookies = msg.lcookies_loc;
        ghost = ghost;

        if(!post_ghost.empty())
            state = CHECK;
    }

    void Replanner::agent_state_Callback(const ros::MessageEvent<ai_agent::agent_state_time>& event){
        std::string publisher_name = event.getPublisherName();
        ai_agent::agent_state_time::ConstPtr data = event.getConstMessage();
        int point = publisher_name.find("/", 0);      //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
        publisher_name = publisher_name.substr(point + 1);  //노드 이름 저장

        int i;
        for (i = 0; i < agent_names.size(); i++) {  //find agent number
            if (agent_names[i] == publisher_name)
                break;
        }
        
        if(i < agent_names.size()){
            agents[i] = data -> axis;
            agent_state_flag[i] = true;
        }

        int count = 0;
        for (i = 0; i < agent_state_flag.size(); i++) {
            if(agent_state_flag[i] == true){
                count++;
            }
        }
        if(count >= agent_state_flag.size()){
            state = JUDGE;
        }

    }

    void Replanner::check_replan(){
        //TODO: check replan
        //simple ghost check
        if(post_ghost.empty())
            return;
        for(int i = 0; i < ghost.size(); i++){
            if(ghost[i] != post_ghost[i]){
                state = CANCEL;
                return;
            }
        }

        state = IDLE;
        double now_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
        timer = now_time + ((double)(3)*1000000000);
    }

    void Replanner::update_ghost(){
        std::string update_str = "/rosplan_knowledge_base/update_array";     //service KB update array
        ros::service::waitForService(update_str.c_str(), ros::Duration(20));
        ros::ServiceClient update_client = node_handle->serviceClient<rosplan_knowledge_msgs::KnowledgeUpdateServiceArray>(update_str.c_str());
        rosplan_knowledge_msgs::KnowledgeUpdateServiceArray update_srv;


        std::vector<rosplan_knowledge_msgs::KnowledgeItem> item;
        std::vector<unsigned char> type;

        for (int i = 0; i < ghost.size(); i++) {

            //make knowledge
            rosplan_knowledge_msgs::KnowledgeItem temp;
            temp.knowledge_type = 1;    //FACT
            temp.attribute_name = "is-ghost";   //ghost operator

            std::vector<diagnostic_msgs::KeyValue> value;  //make value
            diagnostic_msgs::KeyValue temp_value;
            temp_value.key = "a";
            temp_value.value = agent_names[i];
            value.push_back(temp_value);
            temp.values = value;

            item.push_back(temp);

            if (ghost[i] == true) { //set type
                type.push_back(0);  //ADD_KNOWLEDGE
            } else {
                type.push_back(2);  //REMOVE_KNOWLEDGE
            }
        }

        update_srv.request.knowledge = item;
        update_srv.request.update_type = type;

        if (update_client.call(update_srv)){  //call update
            state = GO_PLAN;
        }

        
    }

    void Replanner::run_replanner(){
        if(state == IDLE){ //check timer runout
            double now_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
            if(now_time >= timer){
                std_msgs::Empty msg;
                ask_state_pub.publish(msg);
                state = WAIT;
            }
        }
        else if(state == CHECK){
            cout<<"check"<<endl;
            check_replan();
        }
        else if(state == CANCEL){
            //cancel dispatcher
            cout<<"cancel"<<endl;
            std_srvs::Empty srv;
            cancel_dispatch_client.call(srv);

            //stop manager
            std_msgs::Empty msg;
            stop_manager_pub.publish(msg);

            //get agent, player state   //TODO: time need
            for(int i =0;i<agent_state_pub.size();i++){
                agent_state_pub[i].publish(msg);
            }

            player::player_state_time_srv player_srv;

            if (player_state_client.call(player_srv)) {
                player = player_srv.response.player;
            }

            state = WAIT;
        } else if (state == JUDGE) {
            //all non-stop TODO:
            cout<<"judge"<<endl;
            state = UPDATE;
        } else if (state == UPDATE) {
            cout<<"update"<<endl;
            update_ghost();
        } else if (state == GO_PLAN) {
            cout<<"go_plan"<<endl;
            std::string call_str = "/rosplan_problem_interface/problem_generation_server";  //service KB update array
            ros::service::waitForService(call_str.c_str(), ros::Duration(20));
            ros::ServiceClient call_client = node_handle->serviceClient<std_srvs::Empty>(call_str.c_str());
            std_srvs::Empty call_srv;
            call_client.call(call_srv);
            state = IDLE;

            double now_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
            timer = now_time + ((double)(3)*1000000000);
        }
    }

}  // namespace Custom
int main(int argc, char **argv) {
    ros::init(argc, argv, "replanner");
    ros::NodeHandle nh("~");
    std::string node_name = ros::this_node::getName();    //자신의 노드 이름 확인
    int point = node_name.find("/", 0);      //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
    node_name = node_name.substr(point + 1);  //노드 이름 저장

    Custom::Replanner ri(nh);

    //subscriber
    std::string state_topic = "/board/state_response";
    ros::Subscriber state_sub = nh.subscribe(state_topic, 1, &Custom::Replanner::state_Callback,
                                             dynamic_cast<Custom::Replanner *>(&ri));

    std::string agent_state_topic = "/ai_agent/agent_state_time/to_replanner";
    ros::Subscriber agent_state_sub = nh.subscribe(agent_state_topic, 1000, &Custom::Replanner::agent_state_Callback,
                                             dynamic_cast<Custom::Replanner *>(&ri));

    while(1){
        sleep(0);
        ri.run_replanner();
    }
    // std::string exit_topic = "/board/exit_call";
    // nh.getParam("exit_name", exit_topic);
    // ros::Subscriber exit_sub = nh.subscribe(exit_topic, 1, &Custom::Player::exitCallback,
    //                                         dynamic_cast<Custom::Player *>(&ai));


    ros::spin();
    return 0;
}