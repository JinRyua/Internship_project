#include "ros/ros.h"
#include "ai_agent/ai_agent.h"
#include "board/set_ai_loc_msg.h"
#include "ai_manager/get_agent_state.h"

#include <chrono>
#include <iostream>
using namespace std;

namespace Custom{
    Ai_Agent::Ai_Agent(ros::NodeHandle &nh){
        node_handle = &nh;
        state = IDLE;
        node_name = ros::this_node::getName();    //자신의 노드 이름 확인
        int point = node_name.find("/", 0);      //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
        node_name = node_name.substr(point + 1);  //노드 이름 저장

        //set publisher
        std::string set_ai_loc_topic = "/board/set_ai_loc";
        set_ai_loc_pub = nh.advertise<board::set_ai_loc_msg>(set_ai_loc_topic, 1000);

        speed = 3;
        plan_number = -1;
        std::string get_agent_state_topic = "/ai_manager/get_agent_state";
        agent_state_pub = nh.advertise<ai_manager::get_agent_state>(get_agent_state_topic, 1000);

        agent.col = 11;
        agent.row = 11;
        agent.direction = 1;

    }

    Ai_Agent::~Ai_Agent(){

    }

    void Ai_Agent::run_AI_Agent(double duration){
        if(state == RUN){
            custom_msgs::axis dest = plan[plan_number]; //현재 목적지

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
            
            if (direction == LEFT && dest.col >= agent.col){     //보정 In_Grid
                agent.col = dest.col;
                plan_number++;
            }
            else if (direction == RIGHT && dest.col <= agent.col){
                agent.col = dest.col;
                plan_number++;
            }
            else if (direction == UP && dest.row >= agent.row){
                agent.row = dest.row;
                plan_number++;
            }
            else if (direction == DOWN && dest.row <= agent.row){
                agent.row = dest.row;
                plan_number++;
            }

            //cout<<node_name<<" : "<<agent.row<<", "<<agent.col<<", "<<agent.direction<<endl;

            board::set_ai_loc_msg temp;
            temp.loc = agent;
            set_ai_loc_pub.publish(temp);

            //cout<<
        }
    }

    void Ai_Agent::dispatched_Callback(const ai_manager::ai_action& msg){
        plan = msg.plan;
        plan_number = 0;
        state = RUN;
    }

    void Ai_Agent::state_and_stop_Callback(const std_msgs::Empty& msg){
        ai_manager::get_agent_state temp;
        state = IDLE;   //TODO:
        if(plan_number != -1)
            temp.agent = plan[plan_number];
        else
            temp.agent = agent;

        agent_state_pub.publish(temp);
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

    std::string state_stop_topic = "/ai_manager/get_state_stop_agent";
    ros::Subscriber state_and_stop_sub = nh.subscribe(state_stop_topic, 1000, &Custom::Ai_Agent::state_and_stop_Callback,
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