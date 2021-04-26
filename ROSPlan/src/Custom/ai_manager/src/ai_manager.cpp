#include "ai_manager/ai_manager.h"
#include "rosplan_dispatch_msgs/ActionFeedback.h"
#include "navi/want_route.h"
#include "navi/ask_dist_mat.h"
#include "board/ask_agent_srv.h"
#include "custom_msgs/matrix.h"
#include "ai_manager/ai_action.h"
#include "ai_manager/ai_feedback.h"
#include "custom_msgs/plan.h"
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

        std::string get_stop_state_topic = "/ai_manager/get_state_stop_agent";
        get_state_stop_agent_pub = nh.advertise<std_msgs::Empty>(get_stop_state_topic, 1000);


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
        agent_state_time.resize(agent_names.size());   //state and time after stop
        agent_stop_flag.resize(agent_names.size(), false);  //stop flag
        agents_axis.resize(agent_names.size());



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
        timer = 0;
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
            agent_stop_flag[i] = false;
        }
    }

    void Ai_Manager::game_state_Callback(const board::game_state_msg& msg){
        player_axis = msg.player_axis;
        lcookies_loc = msg.lcookies_loc;
        ghost = msg.ghost;
        get_state = true;
    }

    void Ai_Manager::give_route_Callback(const navi::give_route& msg){
        vector<custom_msgs::plan> temp = msg.plans;
        for (int k = 0; k < temp.size(); k++) {
            std::string name = temp[k].name;
            int i = 0;
            for (i = 0; i < agent_names.size(); i++) {
                if (agent_names[i] == temp[k].name)
                    break;
            }
            plans[k] = temp[k].plan;
        }
        cout<<"good"<<endl;
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
                std::cout<<"get_state"<<std::endl;
                //get state and stop agent
                std_msgs::Empty msg;
                //publish
                get_state_stop_agent_pub.publish(msg);
                get_state = false;
            }
            else if(get_agent_state == true){
                //calc dest
                std::cout<<"get_agent_state"<<std::endl;
                calc_dest();
                //get route from Navi
                //for(int i = 0; i < agents_axis.size(); i++){
                    navi::want_route msg;
                    msg.name = agent_names;
                    msg.from = agents_axis;
                    msg.to = destination;
                    //if(ghost[i]!=1) //TODO:
                        want_route_pub.publish(msg);
                //}
                get_agent_state = false;
            }
            else if (get_route == true){    //check subscribed route and publish
                std::cout<<"get_route"<<std::endl;
                for(int i = 0 ;i < agent_names.size(); i++){
                    //if( agent_route_flag[i] == 1){   //get_route but dont publish
                    //???? TODO: who think?
                    ai_manager::ai_action msg;
                    msg.plan = plans[i];
                    if (ghost[i] != 1)
                        agent_pub[i].publish(msg);
                    //agent_route_flag[i] = 2;
                    //}
                }
                double time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
                timer = time + ((double)(3) * 1000000000);    //set timer
                get_route = false;
                //check all get_route
                // int count = 0;
                // for(int i = 0; i < agent_route_flag.size(); i++){
                //     if( agent_route_flag[i] == 2)
                //         count++;
                // }
                // if( count == agent_route_flag.size()){
                //     get_route = false;
                //     double time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
                //     timer = time + ((double)(3) * 1000000000);    //set timer
                //     for(int i = 0; i < agent_route_flag.size(); i++){
                //         agent_route_flag[i] = 0;    //init route_flag
                //     }
                // }
            }

        }
    }

    void Ai_Manager::calc_dest(){
        int p_num;
        custom_msgs::axis p_temp;
        p_temp.row = player_axis[0].row;
        p_temp.col = player_axis[0].col;
        int direct = player_axis[0].direction;
        std::vector<int> a_num;
        a_num.resize(4);
        for(int i = 0; i < point_name.size(); i++){
            if(point_name[i] == p_temp){
                p_num = i;
            }
            for (int j = 0; j < agents_axis.size(); j++) {
                if (point_name[i].row == agents_axis[j].row &&
                    point_name[i].col == agents_axis[j].col)
                    a_num[j] = i;
            }
        }
        std::vector<int> dest_temp; // player, front, left, right
        dest_temp.resize(4, -1);    //agent_num
        dest_temp[0] = p_num;
        for(int i = 0; i < dist_mat[p_num].size(); i++){    //find dist==2  //TODO:
            if(dist_mat[p_num][i] == 2){
                if(direct == 1){    //direct == left
                    if(p_temp.col > point_name[i].col) //front
                        dest_temp[1] = i;
                    if(p_temp.row < point_name[i].row)  //left
                        dest_temp[2] = i;
                    if(p_temp.row > point_name[i].row)  //right
                        dest_temp[3] = i;
                } else if(direct == 2){   //direct == up
                    if(p_temp.row < point_name[i].row) //front
                        dest_temp[1] = i;
                    if(p_temp.col > point_name[i].col)  //left
                        dest_temp[2] = i;
                    if(p_temp.col < point_name[i].col)  //right
                        dest_temp[3] = i;
                } else if(direct == 3){   //direct == right
                    if(p_temp.col < point_name[i].col) //front
                        dest_temp[1] = i;
                    if(p_temp.row > point_name[i].row)  //left
                        dest_temp[2] = i;
                    if(p_temp.row < point_name[i].row)  //right
                        dest_temp[3] = i;
                } else if(direct == 4){   //direct == down
                    if(p_temp.row > point_name[i].row) //front
                        dest_temp[1] = i;
                    if(p_temp.col < point_name[i].col)  //left
                        dest_temp[2] = i;
                    if(p_temp.col > point_name[i].col)  //right
                        dest_temp[3] = i;
                }
            }
            // int j;
            // for(j = 0; j < dest_temp.size(); j++){
            //     if(dest_temp[j] == -1)
            //         break;
            // }
            // if(j == dest_temp.size())
            //     break;
        }
        for(int j = 1; j < dest_temp.size(); j++){      //보정(없을 경우)
            if(dest_temp[j] == -1){
                for( int k = 1; k < dest_temp.size(); k++){
                    if( dest_temp[k] != -1)
                        dest_temp[j] = dest_temp[k];
                }
            }
        }
        
        //가까운 순서대로
        std::vector<diagnostic_msgs::KeyValue> param = big_plan.parameters;
        destination.resize(4);
        int flag[4] = {0,};
        std::string act = param[0].value;
        int plan = stoi(act.substr(4));  //plan number
        cout<<"hi"<<plan<<endl;
        for(int i = 0; i < 5 - plan; i++){  //전략에 따라
            int min;
            int d_temp = 10000;
            for (int j = 0; j < ghost.size(); j++) {
                cout<<"ghost : "<<ghost[j]<<", "<<flag[j]<<endl;
                if (ghost[j] != 1 && flag[j] != 1) {    //가장 가까운 agent가 배정
                    cout<<"ha"<<endl;
                    cout<<i<<" "<<j<<" "<<dist_mat[dest_temp[i]][a_num[j]]<<"" << d_temp<<endl;
                    if (dist_mat[dest_temp[i]][a_num[j]] < d_temp){
                        min = j;
                        d_temp = dist_mat[dest_temp[i]][a_num[j]];
                    }
                }
            }
            destination[min] = point_name[dest_temp[i]];
            flag[min] = 1;
        }

        //TODO: make ghost
        
    }

    void Ai_Manager::get_agent_state_Callback(const ros::MessageEvent<ai_manager::get_agent_state const >& event){
        std::string publisher_name = event.getPublisherName();
        ai_manager::get_agent_state::ConstPtr data = event.getConstMessage();
        int point = publisher_name.find("/");

        publisher_name = publisher_name.substr(point+1);
        int i;
        for (i = 0; i < agent_names.size(); i++) {  //find agent number
            if (agent_names[i] == publisher_name)
                break;
        }
        agent_stop_flag[i] = true;
        agents_axis[i] = data->agent;
        int count = 0;

        for (i = 0; i < agent_stop_flag.size(); i++) {  //Check all agent stop
            if (agent_stop_flag[i] == true)
                count++;
        }
        if(count == agent_stop_flag.size()){
            for (i = 0; i < agent_stop_flag.size(); i++) {  //Check all agent stop
                agent_stop_flag[i] = false;
            }
            get_agent_state = true;
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

    std::string state_topic = "/board/state_response";
    ros::Subscriber state_sub = nh.subscribe(state_topic, 1000, &Custom::Ai_Manager::game_state_Callback,
                                               dynamic_cast<Custom::Ai_Manager *>(&mi));                                           

    std::string get_agent_state_topic = "/ai_manager/get_agent_state";
    nh.getParam("get_agent_state", get_agent_state_topic);
    ros::Subscriber get_agent_state_sub = nh.subscribe(get_agent_state_topic, 1000, &Custom::Ai_Manager::get_agent_state_Callback,
                                               dynamic_cast<Custom::Ai_Manager *>(&mi));

    std::string give_route_topic = "/navi/give_route";
    ros::Subscriber give_route_sub = nh.subscribe(give_route_topic, 1000, &Custom::Ai_Manager::give_route_Callback,
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