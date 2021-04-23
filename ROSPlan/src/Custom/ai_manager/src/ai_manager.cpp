#include "ai_manager/ai_manager.h"
#include "rosplan_dispatch_msgs/ActionFeedback.h"
#include "navi/want_route.h"
#include "navi/ask_dist_mat.h"
#include "board/ask_agent_srv.h"
#include "custom_msgs/matrix.h"
#include "ai_manager/ai_action.h"
#include "ai_manager/ai_feedback.h"
#include <iostream>
#include <fstream>
#include <chrono>
using namespace std;

namespace Custom{
    Ai_Manager::Ai_Manager(ros::NodeHandle &nh){
        node_handle = &nh;

        //set publihser
        std::string act_feedback_topic = "/rosplan_plan_dispatcher/action_feedback";
        action_feedback_pub = nh.advertise<rosplan_dispatch_msgs::ActionFeedback>(act_feedback_topic, 1000);

        std::string want_route_topic = "/navi/want_route";
        want_route_pub = nh.advertise<navi::want_route>(want_route_topic, 1000);

        std::string game_state_topic = "/board/ask_state";
        game_state_pub = nh.advertise<std_msgs::Empty>(game_state_topic, 1000);


        std::string get_agent_topic = "/board/ask_agent";
        nh.getParam("agent_name", get_agent_topic);
        ros::service::waitForService(get_agent_topic, ros::Duration(20));
        ros::ServiceClient get_agent_client = nh.serviceClient<board::ask_agent_srv>(get_agent_topic);
        board::ask_agent_srv get_agent_srv;

        agent_names.clear();

        if (get_agent_client.call(get_agent_srv)){
            agent_names = get_agent_srv.response.agents_name;
        }

        std::string path = "/home/jylee/jylee/ROSPlan/node.launch";
        nh.getParam("path", path);
        write_launch(agent_names, path);  //write_agent_launch
        path = "roslaunch " + path + " &";
        system(path.c_str());      //exec agent

        for (int i = 0; i < agent_names.size(); i++) {  //make agent pub sub
            ros::Publisher pub = nh.advertise<ai_manager::ai_action>("/ai_manager/ai_action/to_" + agent_names[i], 1000);
            agent_pub.push_back(pub);
        }

        plans.resize(agent_names.size());       //resize vector plans, agent_route_flag ... for agent
        agent_route_flag.resize(agent_names.size(), 0);
        agent_dispatched.resize(agent_names.size());

        std::string dist_mat_topic = "/navi/ask_dist_mat";      //get dist_mat from srv
        nh.getParam("dist_name", dist_mat_topic);
        ros::service::waitForService(dist_mat_topic, ros::Duration(20));
        ros::ServiceClient dist_mat_client = nh.serviceClient<navi::ask_dist_mat>(dist_mat_topic);
        navi::ask_dist_mat dist_mat_srv;

        std::vector<custom_msgs::matrix> temp_dist;
        if (dist_mat_client.call(dist_mat_srv)){            //make dist_mat and point name
            temp_dist = dist_mat_srv.response.dist_mat;
            point_name = dist_mat_srv.response.num_name;

            for(int i = 0; i < temp_dist.size(); i++){      //dist_mat
                std::vector<int> temp = temp_dist[i].value;
                dist_mat.push_back(temp);
            }
        }


    }
    
    Ai_Manager::~Ai_Manager(){

    }

    void Ai_Manager::write_launch(std::vector<std::string> &f, const std::string path) {
        std::ofstream wf;
        wf.open(path);
        if (wf.is_open()) {
            wf << "<?xml version=\"1.0\"?>" << endl
               << "<launch>" << endl;

            wf << "<!-- arguments -->" << endl;
            wf << "<arg name=\"pddl_action_name\" />" << endl;
            for (int i = 0; i < f.size(); i++) {
                wf << "<node name=\"" << f[i] << "\" pkg=\"ai_agent\" type=\"ai_agent\" respawn=\"false\" output=\"screen\">" << endl;
                wf << "</node>" << endl;
            }
            wf << "</launch>";
            wf.close();
        }

    }

    void Ai_Manager::act_dispatched_Callback(const rosplan_dispatch_msgs::ActionDispatch& msg){
        big_plan = msg;
        dispatched = true;
    }

    void Ai_Manager::ai_feedback_Callback(const ros::MessageEvent<ai_manager::ai_feedback const >& event){
        const std::string publisher_name = event.getPublisherName();
        ai_manager::ai_feedback::ConstPtr data = event.getConstMessage();
        if(data -> status == "enable"){
            int i;
            for (i = 0; i < agent_names.size(); i++) {  //find agent number
                if (agent_names[i] == publisher_name)
                    break;
            }
            agent_dispatched[i] = ENABLE;

            //check all enable
            int count = 0;
            for (i = 0; i < agent_dispatched.size(); i++) {  //find agent number
                if (agent_dispatched[i] == ENABLE)
                    count++;
            }
            if (count == agent_dispatched.size()) {   //publish
                rosplan_dispatch_msgs::ActionFeedback msg;
                msg.action_id = big_plan.action_id;
                msg.status = "enable";
                action_feedback_pub.publish(msg);
            }
        } else if (data -> status == "achieved"){
            int i;
            for (i = 0; i < agent_names.size(); i++) {  //find agent number
                if (agent_names[i] == publisher_name)
                    break;
            }
            agent_dispatched[i] = ACHIEVED;

            //check all achieved
            int count = 0;
            for (i = 0; i < agent_dispatched.size(); i++) {  //find agent number
                if (agent_dispatched[i] == ACHIEVED)
                    count++;
            }
            if (count == agent_dispatched.size()) {       //publish
                rosplan_dispatch_msgs::ActionFeedback msg;
                msg.action_id = big_plan.action_id;
                msg.status = "achieved";
                action_feedback_pub.publish(msg);
                for (i = 0; i < agent_dispatched.size(); i++) {  //init dispatched
                    agent_dispatched[i] = NOT_DISPATCHED;
                }
            }
        }
    }

    void Ai_Manager::exit_Callback(const std_msgs::Empty& msg){
        exit(0);
    }

    void Ai_Manager::stop_Callback(const std_msgs::Empty& msg){
        dispatched = false;
        for (int i = 0; i < agent_dispatched.size(); i++) {  //init dispatched
            agent_dispatched[i] = NOT_DISPATCHED;
        }
    }

    void Ai_Manager::game_state_Callback(const board::game_state_msg& msg){
        player_axis = msg.player_axis;
        lcookies_loc = msg.lcookies_loc;
        ghost = msg.ghost;
        get_state = true;
    }

    void Ai_Manager::give_route_Callback(const navi::give_route& msg){
        std::string name = msg.name;
        int i = 0;
        for(i = 0; i < agent_names.size(); i++){
            if(agent_names[i] == name)
                break;
        }

        get_route = true;
        
    }

    void Ai_Manager::run_AI_Manager(){
        if(dispatched == true){ //run if dispatched
            double now_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
            if (now_time >= timer) {  //run out timer
                std_msgs::Empty temp;
                game_state_pub.publish(temp);   //publish ask game_state
                for(int i = 0; i < agent_route_flag.size(); i++)        //init route_flag
                    agent_route_flag[i] = 0;
                timer = now_time + ((double)(100) * 1000000000);    //set timer(INF)
            }
            
            if (get_state == true){     //subscribe game_state
                //TODO: get state and stop agent
                
                //publish

                get_state = false;
            }
            else if(get_agent_state == true){
                //TODO: calc dest

                //get route from Navi
                for(int i = 0; i < agents_axis.size(); i++){
                    navi::want_route msg;
                    msg.name = agent_names[i];
                    msg.from = agents_axis[i];
                    msg.to = destination[i];
                    want_route_pub.publish(msg);
                }
                get_agent_state = false;
            }
            else if (get_route == true){    //check subscribed route and publish
                for(int i = 0 ;i < agent_route_flag.size(); i++){
                    if( agent_route_flag[i] == 1){   //get_route but dont publish
                        //???? TODO: who think?
                        ai_manager::ai_action msg;
                        msg.plan = plans[i];
                        agent_pub[i].publish(msg);
                        agent_route_flag[i] = 2;
                    }
                }
                
                //check all get_route
                int count = 0;
                for(int i = 0; i < agent_route_flag.size(); i++){
                    if( agent_route_flag[i] == 2)
                        count++;
                }
                if( count == agent_route_flag.size()){
                    get_route = false;
                    double time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
                    timer = time + ((double)(3) * 1000000000);    //set timer
                    for(int i = 0; i < agent_route_flag.size(); i++){
                        agent_route_flag[i] = 0;    //init route_flag
                    }
                }
            }

        }
    }

}


int main(int argc, char **argv)
{
    ros::init(argc, argv, "ai_manager");
    ros::NodeHandle nh("~");

    Custom::Ai_Manager mi(nh);

    //  //subscriber
    std::string act_dispatch_topic = "/rosplan_plan_dispatcher";
    nh.getParam("dispatcher", act_dispatch_topic);
    ros::Subscriber dispatched_sub = nh.subscribe(act_dispatch_topic + "/action_dispatch", 1000, &Custom::Ai_Manager::act_dispatched_Callback,
                                               dynamic_cast<Custom::Ai_Manager *>(&mi));

    ros::Subscriber feedback_sub = nh.subscribe("/ai_manager/ai_feedback", 1000,
                                       &Custom::Ai_Manager::ai_feedback_Callback, dynamic_cast<Custom::Ai_Manager *>(&mi));

    std::string exit_topic = "/board/exit_call";
    nh.getParam("exit_name", exit_topic);
    ros::Subscriber exit_sub = nh.subscribe(exit_topic, 1000, &Custom::Ai_Manager::exit_Callback,
                                               dynamic_cast<Custom::Ai_Manager *>(&mi));

    std::string stop_topic = "/ai_manager/stop_manager";
    nh.getParam("stop_name", stop_topic);
    ros::Subscriber stop_sub = nh.subscribe(stop_topic, 1000, &Custom::Ai_Manager::stop_Callback,
                                               dynamic_cast<Custom::Ai_Manager *>(&mi));

    while(1){
        sleep(0);
        ros::spinOnce();
        mi.run_AI_Manager();
    }
    // std::string exit_topic = "/board/exit_call";
    // nh.getParam("exit_name", exit_topic);
    // ros::Subscriber exit_sub = nh.subscribe(exit_topic, 1, &Custom::Navi::exit_Callback,
    //                                         dynamic_cast<Custom::Navi *>(&ni));

    // std::string want_topic = "/navi/want_route";
    // nh.getParam("want_name", want_topic);
    // ros::Subscriber want_sub = nh.subscribe(want_topic, 1, &Custom::Navi::want_route_Callback, dynamic_cast<Custom::Navi *>(&ni));

    // //service server
    // ros::ServiceServer ask_dist_mat_srv = nh.advertiseService("/navi/ask_dist_mat", &Custom::Navi::ask_dist_mat_Callback, dynamic_cast<Custom::Navi *>(&ni));
    
    return 0;    
}