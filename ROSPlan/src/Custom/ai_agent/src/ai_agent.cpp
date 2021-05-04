#include "ros/ros.h"
#include "ai_agent/ai_agent.h"
#include "board/set_ai_loc_msg.h"
#include "ai_manager/get_agent_state.h"
#include "ai_agent/stop_response.h"
#include "ai_manager/ai_feedback.h"
#include "ai_agent/agent_state_time.h"
#include "rosplan_knowledge_msgs/KnowledgeUpdateServiceArray.h"
#include "diagnostic_msgs/KeyValue.h"
#include "board/set_ai_msg.h"
#include "board/reset_ai_msg.h"
#include "std_msgs/Empty.h"

#include <chrono>
#include <iostream>
using namespace std;

void print_log(string node_name, string func,string str);

namespace Custom{
    Ai_Agent::Ai_Agent(ros::NodeHandle &nh){
        node_handle = &nh;
        state = IDLE;
        in_grid = true;     //grid에 있음 
        node_name = ros::this_node::getName();    //자신의 노드 이름 확인
        int point = node_name.find("/", 0);      //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
        node_name = node_name.substr(point + 1);  //노드 이름 저장

        //set publisher
        std::string set_ai_loc_topic = "/board/set_ai_loc";
        set_ai_loc_pub = nh.advertise<board::set_ai_loc_msg>(set_ai_loc_topic, 1000);

        std::string agent_state_time_topic = "/ai_agent/agent_state_time/to_replanner";
        state_time_pub = nh.advertise<ai_agent::agent_state_time>(agent_state_time_topic, 1000);

        std::string get_agent_state_topic = "/ai_manager/get_agent_state";
        agent_state_pub = nh.advertise<ai_manager::get_agent_state>(get_agent_state_topic, 1000);

        std::string stop_response_topic = "/ai_agent/stop_response/";
        stop_response_pub = nh.advertise<ai_agent::stop_response>(stop_response_topic, 1000);

        std::string ai_feedback_topic = "/ai_manager/ai_feedback/";
        feedback_pub = nh.advertise<ai_manager::ai_feedback>(ai_feedback_topic, 1000);

        std::string replan_topic = "/replanner/call_replanner";
        call_replan_pub = nh.advertise<std_msgs::Empty>(replan_topic, 1000);

        //set client srv
        std::stringstream ss;
        ss.str("");
        ss << "/rosplan_knowledge_base/update_array";
        update_knowledge_client = node_handle->serviceClient<rosplan_knowledge_msgs::KnowledgeUpdateServiceArray>(ss.str());

        speed = 2;
        plan_number = -1;
        replan_flag = false;

        agent.col = 11; //TODO:
        agent.row = 11;
        agent.direction = 1;
        stop_flag = false;
        init_knowledge.knowledge_type = 1;   //FACT
        init_knowledge.attribute_name = "in-block";

        vector<diagnostic_msgs::KeyValue> temp;
        diagnostic_msgs::KeyValue value;
        value.key = "c";
        value.value = node_name;
        temp.push_back(value);
        value.key = "p";
        value.value = "point" + to_string((int)(agent.row)) + "_" + to_string((int)(agent.col));
        temp.push_back(value);

        init_knowledge.values = temp;
        knowledge = init_knowledge;

        

    }

    Ai_Agent::~Ai_Agent(){

    }

    void Ai_Agent::run_AI_Agent(double duration){
        if(state == RUN){
            custom_msgs::axis dest = plan[plan_number]; //현재 목적지
            if(plan_number >= plan.size() - 4 && replan_flag == false){
                std_msgs::Empty msg;
                call_replan_pub.publish(msg);
                replan_flag = true;
                print_log(node_name, __func__, "call replanner");
            }
            float move_distance = duration * speed;
            
            int direction = LEFT;
            if(dest.col < agent.col)
                direction = LEFT;
            else if(dest.row < agent.row)
                direction = UP;
            else if(dest.col > agent.col)
                direction = RIGHT;
            else if(dest.row > agent.row)
                direction = DOWN;

            if (direction == LEFT)
                agent.col -= move_distance;
            else if (direction == RIGHT)
                agent.col += move_distance;
            else if (direction == UP)
                agent.row -= move_distance;
            else if (direction == DOWN)
                agent.row += move_distance;
            if(in_grid == true){
                //update and remove KB
                update_grid();
            }
            in_grid = false;

            if (direction == LEFT && dest.col >= agent.col){     //보정 In_Grid
                agent.col = dest.col;
                plan_number++;
                in_grid = true;
                if(stop_flag == true){
                    state = IDLE;
                    stop_flag = false;
                }
            }
            else if (direction == RIGHT && dest.col <= agent.col){
                agent.col = dest.col;
                plan_number++;
                in_grid = true;
                if(stop_flag == true){
                    state = IDLE;
                    stop_flag = false;
                }
            }
            else if (direction == UP && dest.row >= agent.row){
                agent.row = dest.row;
                plan_number++;
                in_grid = true;
                if(stop_flag == true){
                    state = IDLE;
                    stop_flag = false;
                }
            }
            else if (direction == DOWN && dest.row <= agent.row){
                agent.row = dest.row;
                plan_number++;
                in_grid = true;
                if(stop_flag == true){
                    state = IDLE;
                    stop_flag = false;
                }
            }

            //cout<<node_name<<" : "<<agent.row<<", "<<agent.col<<", "<<agent.direction<<endl;
            agent.direction = direction;
            board::set_ai_loc_msg temp;
            temp.loc = agent;
            set_ai_loc_pub.publish(temp);

            if(plan_number >= plan.size() ){ //finish
                state = IDLE;
                ai_manager::ai_feedback feed;
                feed.status = "achieved";
                feedback_pub.publish(feed);
                print_log(node_name, __func__ , "finish plan");
            }

            //cout<<
        }
    }

    void Ai_Agent::update_grid(){
        vector<unsigned char> type;
        vector<rosplan_knowledge_msgs::KnowledgeItem> know;

        type.push_back(2);  //remove present
        know.push_back(knowledge);
        rosplan_knowledge_msgs::KnowledgeUpdateServiceArray srv;

        type.push_back(0);  //ADD present(next GRID)
        for (int i = 0; i < knowledge.values.size(); i++) {  //make knowledge
            if (knowledge.values[i].key == "p") {
                knowledge.values[i].value = "point" + to_string((int)(plan[plan_number].row)) + "_" + to_string((int)(plan[plan_number].col));
                break;
            }
        }
        know.push_back(knowledge);
        srv.request.update_type = type;
        srv.request.knowledge = know;

        update_knowledge_client.call(srv);  //call update array
    }

    void Ai_Agent::dispatched_Callback(const ai_manager::ai_action& msg){
        plan = msg.plan;
        plan_number = 0;
        state = RUN;
        stop_flag = false;
        replan_flag = false;
        ai_manager::ai_feedback temp;
        temp.status = "enabled";
        feedback_pub.publish(temp);
    }

    void Ai_Agent::state_Callback(const std_msgs::Empty& msg){
        ai_agent::agent_state_time temp;
           //TODO:
        if(state != IDLE)
            temp.axis = plan[plan_number];
        else
            temp.axis = agent;
        state_time_pub.publish(temp);
    }

    void Ai_Agent::state_and_stop_Callback(const std_msgs::Empty& msg){
        ai_manager::get_agent_state temp;
           //TODO:
        if(state != IDLE)
            temp.agent = plan[plan_number];
        else
            temp.agent = agent;
        stop_flag = true;
        agent_state_pub.publish(temp);
    }

    void Ai_Agent::stop_Callback(const std_msgs::Empty& msg){
        state = IDLE;
        ai_agent::stop_response temp;
        temp.axis = agent;
        stop_response_pub.publish(temp);
        
    }
    
    void Ai_Agent::exit_Callback(const std_msgs::Empty& msg){
        exit(0);
    }

    void Ai_Agent::set_ai_Callback(const board::set_ai_msg& msg){
        //TODO: set ai  speed, state....
        state = IDLE;
        agent = msg.loc;
        speed = msg.speed;
        
    }

    void Ai_Agent::reset_ai_Callback(const board::reset_ai_msg& msg){
        //TODO: reset ai -> ai?
        state = IDLE;
        agent = msg.loc;

    }

}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "ai_agent");
    ros::NodeHandle nh("~");
    std::string node_name = ros::this_node::getName();    //자신의 노드 이름 확인
    int point = node_name.find("/", 0);      //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
    node_name = node_name.substr(point + 1);  //노드 이름 저장

    Custom::Ai_Agent ai(nh);

    //subscriber
    std::string dispatched_topic = "/ai_manager/ai_action/to_" + node_name;
    nh.getParam("dispatched", dispatched_topic);
    ros::Subscriber dispatched_sub = nh.subscribe(dispatched_topic, 1000, &Custom::Ai_Agent::dispatched_Callback,
                                               dynamic_cast<Custom::Ai_Agent *>(&ai));

    std::string state_topic = "/ai_agent/get_state_agent/to_"+node_name;
    ros::Subscriber state__sub = nh.subscribe(state_topic, 1000, &Custom::Ai_Agent::state_Callback,
                                                      dynamic_cast<Custom::Ai_Agent *>(&ai));

    std::string state_stop_topic = "/ai_manager/get_state_stop_agent/to_" + node_name;
    ros::Subscriber state_and_stop_sub = nh.subscribe(state_stop_topic, 1000, &Custom::Ai_Agent::state_and_stop_Callback,
                                               dynamic_cast<Custom::Ai_Agent *>(&ai));

    std::string stop_topic = "/ai_agent/stop_agent/to_" + node_name;
    ros::Subscriber stop_sub = nh.subscribe(stop_topic, 1000, &Custom::Ai_Agent::stop_Callback,
                                                      dynamic_cast<Custom::Ai_Agent *>(&ai));

    std::string exit_topic = "/board/exit_call";
    ros::Subscriber exit_sub = nh.subscribe(exit_topic, 1, &Custom::Ai_Agent::exit_Callback,
                                            dynamic_cast<Custom::Ai_Agent *>(&ai));
    std::string set_ai_topic = "/board/set_ai/to_" + node_name;
    ros::Subscriber set_ai_sub = nh.subscribe(set_ai_topic, 1000, &Custom::Ai_Agent::set_ai_Callback,
                                            dynamic_cast<Custom::Ai_Agent *>(&ai));
    std::string reset_topic = "/board/reset_ai";
    ros::Subscriber reset_sub = nh.subscribe(reset_topic, 1000, &Custom::Ai_Agent::reset_ai_Callback,
                                            dynamic_cast<Custom::Ai_Agent *>(&ai));
    // std::string exit_topic = "/board/exit_call";
    // nh.getParam("exit_name", exit_topic);
    // ros::Subscriber exit_sub = nh.subscribe(exit_topic, 1, &Custom::Player::exitCallback,
    //                                         dynamic_cast<Custom::Player *>(&ai));

    double act_time = 0.04;
    int i =0;
    //player_state = GAME;
    while (1)
    {
        sleep(0);
        double start_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
        ros::spinOnce();

        ai.run_AI_Agent(act_time);


             
        double finish_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
        double rate = (double)(act_time * 1000000000 - (finish_time - start_time)) / 1000000000;
        if (rate > 0){
            ros::Rate wait = 1 / rate;
            wait.sleep();
        }
        act_time = (finish_time - start_time) / 1000000000;
        if(act_time < 0.04) act_time = 0.04;
    }
    // Custom::Ai_Manager mi(nh);

    // //  //subscriber
    // std::string act_dispatch_topic = "/rosplan_plan_dispatcher";
    // nh.getParam("dispatcher", act_dispatch_topic);
    // ros::Subscriber dispatched_sub = nh.subscribe(act_dispatch_topic + "/action_dispatch", 1000, &Custom::Ai_Manager::act_dispatched_Callback,
    //                                            dynamic_cast<Custom::Ai_Manager *>(&mi));

    // ros::Subscriber sub = nh.subscribe("/ai_manager/ai_feedback", 1000,
    //                                    &Custom::Ai_Manager::act_dispatched_Callback, dynamic_cast<Custom::Ai_Manager *>(&mi));

    // // std::string exit_topic = "/board/exit_call";
    // nh.getParam("exit_name", exit_topic);
    // ros::Subscriber exit_sub = nh.subscribe(exit_topic, 1, &Custom::Navi::exit_Callback,
    //                                         dynamic_cast<Custom::Navi *>(&ni));

    // std::string want_topic = "/navi/want_route";
    // nh.getParam("want_name", want_topic);
    // ros::Subscriber want_sub = nh.subscribe(want_topic, 1, &Custom::Navi::want_route_Callback, dynamic_cast<Custom::Navi *>(&ni));

    // //service server
    // ros::ServiceServer ask_dist_mat_srv = nh.advertiseService("/navi/ask_dist_mat", &Custom::Navi::ask_dist_mat_Callback, dynamic_cast<Custom::Navi *>(&ni));
    

    ros::spin();
    return 0;    
}

void print_log(string node_name, string func,string str){
	cout<< "[";
	cout.width(9);cout.fill(' ');cout<<fixed;cout.precision(3);
	cout<<std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::now().time_since_epoch()).count()/1000.0<<"][";
	cout.width(13);cout.fill(' ');
	cout<<node_name<<"][";
	cout.width(17);cout.fill(' ');
	cout<<func<<"] ( "<<str<<" )"<<endl;
}