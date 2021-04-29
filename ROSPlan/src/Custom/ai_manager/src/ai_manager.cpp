#include "ai_manager/ai_manager.h"
#include "rosplan_dispatch_msgs/ActionFeedback.h"
#include "navi/want_route.h"
#include "navi/ask_dist_mat.h"
#include "board/ask_agent_srv.h"
#include "custom_msgs/matrix.h"
#include "ai_manager/ai_action.h"
#include "ai_manager/ai_feedback.h"
#include "player/player_state_time_srv.h"
#include "custom_msgs/plan.h"
#include "board/change_state_msg.h"

#include "rosplan_knowledge_msgs/GetDomainOperatorDetailsService.h"
#include "rosplan_knowledge_msgs/GetDomainOperatorService.h"
#include "rosplan_knowledge_msgs/GetDomainPredicateDetailsService.h"
#include "rosplan_knowledge_msgs/KnowledgeItem.h"
#include "rosplan_knowledge_msgs/KnowledgeUpdateService.h"
#include "rosplan_knowledge_msgs/KnowledgeUpdateServiceArray.h"

#include <iostream>
#include <fstream>
#include <chrono>
using namespace std;


void print_log(string node_name, string func,string str);

namespace Custom {


    Ai_Manager::Ai_Manager(ros::NodeHandle &nh, string node_n){
        node_handle = &nh;
        node_name = node_n;

        //set publihser
        std::string act_feedback_topic = "/rosplan_plan_dispatcher/action_feedback";
        action_feedback_pub = nh.advertise<rosplan_dispatch_msgs::ActionFeedback>(act_feedback_topic, 1000);

        std::string want_route_topic = "/navi/want_route";
        want_route_pub = nh.advertise<navi::want_route>(want_route_topic, 1000);

        std::string game_state_topic = "/board/ask_state";
        game_state_pub = nh.advertise<std_msgs::Empty>(game_state_topic, 1000);

        std::string get_stop_state_topic = "/ai_manager/get_state_stop_agent";
        get_state_stop_agent_pub = nh.advertise<std_msgs::Empty>(get_stop_state_topic, 1000);

        std::string change_topic = "/board/change_state";
        change_pub = nh.advertise<board::change_state_msg>(change_topic, 1000);


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
        big_plan.resize(agent_names.size());



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
        
        init_oper();

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

    void Ai_Manager::act_dispatched_Callback(const rosplan_dispatch_msgs::ActionDispatch &msg) {
        if (msg.name != "cancel_action") {
            print_log(node_name, __func__, "dispatched from new plan");
            vector<diagnostic_msgs::KeyValue> params = msg.parameters;
            string name, from, to;
            for (int i = 0; i < params.size(); i++) {
                if (params[i].key == "a") {
                    name = params[i].value;
                } else if (params[i].key == "from") {
                    from = params[i].value;
                } else if (params[i].key == "to") {
                    to = params[i].value;
                }
            }
            
            int number = stoi(name.substr(5)) - 1;  //번호만
            big_plan[number] = msg; //plan 저장
            
            int row, col;
            int point = to.find("_");
            row = stoi(to.substr(5, point - 5));
            col = stoi(to.substr(point + 1));
            
            vector<custom_msgs::axis> send_msg;
            custom_msgs::axis temp;
            temp.row = row;
            temp.col = col;
            send_msg.push_back(temp);
            ai_manager::ai_action msg_temp;
            msg_temp.plan = send_msg;
            agent_pub[number].publish(msg_temp);
            // big_plan = msg;
            // dispatched = true;
            // timer = 0;
            // board::change_state_msg tm;
            // tm.state = "playing game";
            // change_pub.publish(tm);
        }
    }

    void Ai_Manager::ai_feedback_Callback(const ros::MessageEvent<ai_manager::ai_feedback const >& event){
        std::string publisher_name = event.getPublisherName();
        ai_manager::ai_feedback::ConstPtr data = event.getConstMessage();
        int point = publisher_name.find("/", 0);      //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
        publisher_name = publisher_name.substr(point + 1);  //노드 이름 저장
        if(data -> status == "enabled"){
            print_log(node_name, __func__, "recieved enabled");
            int i;
            for (i = 0; i < agent_names.size(); i++) {  //find agent number
                if (agent_names[i] == publisher_name)
                    break;
            }
            agent_dispatched[i] = ENABLE;
            rosplan_dispatch_msgs::ActionFeedback msg;
            msg.action_id = big_plan[i].action_id;
            msg.status = "action enabled";
            update_start(i);
            action_feedback_pub.publish(msg);
            print_log(node_name, __func__, "publish enabled to dispatcher");
            // //check all enable
            // int count = 0;
            // for (i = 0; i < agent_dispatched.size(); i++) {  //find agent number
            //     if (agent_dispatched[i] == ENABLE)
            //         count++;
            // }
            // if (count == agent_dispatched.size()) {  //publish
            // }
        } else if (data -> status == "achieved"){
            int i;
            print_log(node_name, __func__, "recieved achieved");
            for (i = 0; i < agent_names.size(); i++) {  //find agent number
                if (agent_names[i] == publisher_name)
                    break;
            }
            agent_dispatched[i] = ACHIEVED;
            rosplan_dispatch_msgs::ActionFeedback msg;
            msg.action_id = big_plan[i].action_id;
            msg.status = "action achieved";
            update_end(i);
            action_feedback_pub.publish(msg);
            print_log(node_name, __func__, "publish achieved to dispatcher");
            // //check all achieved
            // int count = 0;
            // for (i = 0; i < agent_dispatched.size(); i++) {  //find agent number
            //     if (agent_dispatched[i] == ACHIEVED)
            //         count++;
            // }
            // if (count == agent_dispatched.size()) {       //publish
            //     rosplan_dispatch_msgs::ActionFeedback msg;
            //     msg.action_id = big_plan.action_id;
            //     msg.status = "achieved";
            //     action_feedback_pub.publish(msg);
            //     for (i = 0; i < agent_dispatched.size(); i++) {  //init dispatched
            //         agent_dispatched[i] = NOT_DISPATCHED;
            //     }
            // }
        }
    }

    void Ai_Manager::exit_Callback(const std_msgs::Empty& msg){
        exit(0);
    }

    void Ai_Manager::stop_Callback(const std_msgs::Empty& msg){
        print_log(node_name, __func__, "received stop from replanner");
        dispatched = false;
        get_state = false;
        get_route = false;
        get_agent_state = false;
        for (int i = 0; i < agent_dispatched.size(); i++) {  //init dispatched
            agent_dispatched[i] = NOT_DISPATCHED;
            agent_stop_flag[i] = false;
        }
    }

    void Ai_Manager::game_state_Callback(const board::game_state_msg& msg){
        //player_axis = msg.player_axis;
        lcookies_loc = msg.lcookies_loc;
        ghost = msg.ghost;
        get_state = true;
    }

    void Ai_Manager::give_route_Callback(const navi::give_route& msg){
        print_log(node_name, __func__, "received route from navi");
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
        //cout<<"good"<<endl;
        get_route = true;
        
    }

    void Ai_Manager::run_AI_Manager(){
        if(dispatched == true){ //run if dispatched
            double now_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
            if (now_time >= timer) {  //run out timer

                print_log(node_name, __func__, "run out timer and check player and game state");
                std::string srv_topic = "/player/player_state_time";  //get dist_mat from srv
                ros::service::waitForService(srv_topic, ros::Duration(20));
                ros::ServiceClient client = node_handle->serviceClient<player::player_state_time_srv>(srv_topic);
                player::player_state_time_srv srv;

                if (client.call(srv)) {  //make dist_mat and point name
                    player_axis = srv.response.player;
                }

                std_msgs::Empty temp;
                game_state_pub.publish(temp);   //publish ask game_state
                for(int i = 0; i < agent_route_flag.size(); i++)        //init route_flag
                    agent_route_flag[i] = 0;
                timer = now_time + ((double)(100) * 1000000000);    //set timer(INF)
            }

            if (get_state == true){     //subscribe game_state
                print_log(node_name, __func__, "pub stop agent and get state");
                //get state and stop agent
                std_msgs::Empty msg;
                //publish
                get_state_stop_agent_pub.publish(msg);
                get_state = false;
            }
            else if(get_agent_state == true){
                //calc dest
                print_log(node_name, __func__, "calc_dest");
                calc_dest();
                //get route from Navi
                //for(int i = 0; i < agents_axis.size(); i++){
                    navi::want_route msg;
                    msg.name = agent_names;
                    msg.from = agents_axis;
                    msg.to = destination;
                    //if(ghost[i]!=1) //TODO:
                    print_log(node_name, __func__, "ask route to navi");
                        want_route_pub.publish(msg);
                //}
                get_agent_state = false;
            }
            else if (get_route == true){    //check subscribed route and publish
                print_log(node_name, __func__, "pub plan to agent");
                for(int i = 0 ;i < agent_names.size(); i++){
                    //if( agent_route_flag[i] == 1){   //get_route but dont publish
                    //???? TODO: who think?
                    ai_manager::ai_action msg;
                    msg.plan = plans[i];
                    //if (ghost[i] != 1)
                        agent_pub[i].publish(msg);
                    //agent_route_flag[i] = 2;
                    //}
                }
                double time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
                timer = time + ((double)(1.5) * 1000000000);    //set timer
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
        

        std::vector<diagnostic_msgs::KeyValue> param = big_plan[0].parameters;
        destination.resize(4);
        int flag[4] = {0,};
        std::string act = param[0].value;
        int plan = stoi(act.substr(4));  //plan number
        cout<<plan<<endl;
        cout<<"hello"<<endl;
        //cout<<"hi"<<plan<<endl;
        for(int i = 0; i < 5 - plan; i++){  //전략에 따라
            int min;
            int d_temp = 10000;
            for (int j = 0; j < ghost.size(); j++) {
                //cout<<"ghost : "<<ghost[j]<<", "<<flag[j]<<endl;
                if (ghost[j] != 1 && flag[j] != 1) {    //가장 가까운 agent가 배정
                    // cout<<"ha"<<endl;
                    // cout<<i<<" "<<j<<" "<<dist_mat[dest_temp[i]][a_num[j]]<<"" << d_temp<<endl;
                    if (dist_mat[dest_temp[i]][a_num[j]] < d_temp){
                        min = j;
                        d_temp = dist_mat[dest_temp[i]][a_num[j]];
                    }
                }
            }
            destination[min] = point_name[dest_temp[i]];
            flag[min] = 1;
        }
        for(int i = 0; i < 4; i++){
            if(ghost[i]==1){
            destination[i].row = 2;
            destination[i].col = 2;
            flag[i] = 1;
            }
        }
        
        print_log(node_name, __func__, "calc end");
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

    void Ai_Manager::init_oper() {
        std::string kb = "/rosplan_knowledge_base";
        node_handle->getParam("knowledge_base", kb);

        // fetch action params
        std::stringstream ss;

        ss << "/" << kb << "/domain/operators";
        ros::service::waitForService(ss.str(), ros::Duration(20));
        ros::ServiceClient oper_client = node_handle -> serviceClient<rosplan_knowledge_msgs::GetDomainOperatorService>(ss.str());
        rosplan_knowledge_msgs::GetDomainOperatorService srv_temp;
        std::vector<rosplan_knowledge_msgs::DomainFormula> opNames;
        if (oper_client.call(srv_temp)) {
            opNames = srv_temp.response.operators;
        } else {
            ROS_ERROR("KCL: (ActionInterface) could not call Knowledge Base for operators");
            return;
        }

        for (int i = 0; i < opNames.size(); i++) {
            ss.str("");
            ss << "/" << kb << "/domain/operator_details";
            ros::service::waitForService(ss.str(), ros::Duration(20));
            ros::ServiceClient client = node_handle->serviceClient<rosplan_knowledge_msgs::GetDomainOperatorDetailsService>(ss.str());
            rosplan_knowledge_msgs::GetDomainOperatorDetailsService srv;
            rosplan_knowledge_msgs::DomainFormula params;
            rosplan_knowledge_msgs::DomainOperator op;
            srv.request.name = opNames[i].name;
            if (client.call(srv)) {
                params = srv.response.op.formula;
                op = srv.response.op;
            } else {
                ROS_ERROR("KCL: (ActionInterface) could not call Knowledge Base for operator details, %s", opNames[i].name);
                return;
            }

            // collect predicates from operator description
            std::vector<std::string> predicateNames;

            // effects
            std::vector<rosplan_knowledge_msgs::DomainFormula>::iterator pit = op.at_start_add_effects.begin();
            for (; pit != op.at_start_add_effects.end(); pit++)
                predicateNames.push_back(pit->name);

            pit = op.at_start_del_effects.begin();
            for (; pit != op.at_start_del_effects.end(); pit++)
                predicateNames.push_back(pit->name);

            pit = op.at_end_add_effects.begin();
            for (; pit != op.at_end_add_effects.end(); pit++)
                predicateNames.push_back(pit->name);

            pit = op.at_end_del_effects.begin();
            for (; pit != op.at_end_del_effects.end(); pit++)
                predicateNames.push_back(pit->name);

            // simple conditions
            pit = op.at_start_simple_condition.begin();
            for (; pit != op.at_start_simple_condition.end(); pit++)
                predicateNames.push_back(pit->name);

            pit = op.over_all_simple_condition.begin();
            for (; pit != op.over_all_simple_condition.end(); pit++)
                predicateNames.push_back(pit->name);

            pit = op.at_end_simple_condition.begin();
            for (; pit != op.at_end_simple_condition.end(); pit++)
                predicateNames.push_back(pit->name);

            // negative conditions
            pit = op.at_start_neg_condition.begin();
            for (; pit != op.at_start_neg_condition.end(); pit++)
                predicateNames.push_back(pit->name);

            pit = op.over_all_neg_condition.begin();
            for (; pit != op.over_all_neg_condition.end(); pit++)
                predicateNames.push_back(pit->name);

            pit = op.at_end_neg_condition.begin();
            for (; pit != op.at_end_neg_condition.end(); pit++)
                predicateNames.push_back(pit->name);

            // fetch and store predicate details
            ss.str("");
            ss << "/" << kb << "/domain/predicate_details";
            ros::service::waitForService(ss.str(), ros::Duration(20));
            ros::ServiceClient predClient = node_handle -> serviceClient<rosplan_knowledge_msgs::GetDomainPredicateDetailsService>(ss.str());
            std::map<std::string, rosplan_knowledge_msgs::DomainFormula> predicates;
            std::map<std::string, rosplan_knowledge_msgs::DomainFormula> sensed_predicates;
            std::vector<std::string>::iterator nit = predicateNames.begin();
            for (; nit != predicateNames.end(); nit++) {
                if (predicates.find(*nit) != predicates.end()) continue;
                if (*nit == "=" || *nit == ">" || *nit == "<" || *nit == ">=" || *nit == "<=") continue;
                rosplan_knowledge_msgs::GetDomainPredicateDetailsService predSrv;
                predSrv.request.name = *nit;
                if (predClient.call(predSrv)) {
                    if (predSrv.response.is_sensed) {
                        sensed_predicates.insert(std::pair<std::string, rosplan_knowledge_msgs::DomainFormula>(*nit, predSrv.response.predicate));
                    } else {
                        predicates.insert(std::pair<std::string, rosplan_knowledge_msgs::DomainFormula>(*nit, predSrv.response.predicate));
                    }
                } else {
                    ROS_ERROR("KCL: (ActionInterface) could not call Knowledge Base for predicate details, %s", params.name.c_str());
                    return;
                }
            }

            ss.str("");
            ss << "/" << kb << "/update_array";
            update_knowledge_client = node_handle -> serviceClient<rosplan_knowledge_msgs::KnowledgeUpdateServiceArray>(ss.str());

            struct oper_info temp;
            temp.predicates = predicates;
            temp.sensed_predicates = sensed_predicates;
            temp.params = params;
            temp.op = op;
            operator_info.insert(std::pair<std::string, struct oper_info>(opNames[i].name, temp));
            predicates.clear();
            sensed_predicates.clear();
        }
    }

    void Ai_Manager::update_start(int id) {
        std::string name = big_plan[id].name;
        std::map<std::string, rosplan_knowledge_msgs::DomainFormula> predicates = operator_info[name].predicates;
        std::map<std::string, rosplan_knowledge_msgs::DomainFormula> sensed_predicates = operator_info[name].sensed_predicates;

        rosplan_knowledge_msgs::DomainFormula params = operator_info[name].params;
        rosplan_knowledge_msgs::DomainOperator op = operator_info[name].op;

        std::vector<diagnostic_msgs::KeyValue> parameters = big_plan[id].parameters;

        std::vector<bool> found(params.typed_parameters.size(), false);
        std::map<std::string, std::string> boundParameters;
        for (size_t j = 0; j < params.typed_parameters.size(); j++) {
            for (size_t i = 0; i < parameters.size(); i++) {
                if (params.typed_parameters[j].key == parameters[i].key) {
                    boundParameters[parameters[i].key] = parameters[i].value;
                    found[j] = true;
                    break;
                }
            }
            if (!found[j]) {
                ROS_INFO("KCL: (%s) aborting action dispatch; malformed parameters, missing %s", params.name.c_str(), params.typed_parameters[j].key.c_str());
                return;
            }
        }

        rosplan_knowledge_msgs::KnowledgeUpdateServiceArray updatePredSrv;

        // simple START del effects
        for (int i = 0; i < op.at_start_del_effects.size(); i++) {
            std::map<std::string, rosplan_knowledge_msgs::DomainFormula>::iterator it = sensed_predicates.find(op.at_start_del_effects[i].name);
            if (it != sensed_predicates.end()) continue;  // sensed predicate

            rosplan_knowledge_msgs::KnowledgeItem item;
            item.knowledge_type = rosplan_knowledge_msgs::KnowledgeItem::FACT;
            item.attribute_name = op.at_start_del_effects[i].name;
            item.values.clear();
            diagnostic_msgs::KeyValue pair;
            for (size_t j = 0; j < op.at_start_del_effects[i].typed_parameters.size(); j++) {
                pair.key = predicates[op.at_start_del_effects[i].name].typed_parameters[j].key;
                pair.value = boundParameters[op.at_start_del_effects[i].typed_parameters[j].key];
                item.values.push_back(pair);
            }
            updatePredSrv.request.knowledge.push_back(item);
            updatePredSrv.request.update_type.push_back(rosplan_knowledge_msgs::KnowledgeUpdateService::Request::REMOVE_KNOWLEDGE);
        }

        // simple START add effects
        for (int i = 0; i < op.at_start_add_effects.size(); i++) {
            std::map<std::string, rosplan_knowledge_msgs::DomainFormula>::iterator it = sensed_predicates.find(op.at_start_add_effects[i].name);
            if (it != sensed_predicates.end()) continue;  // sensed predicate

            rosplan_knowledge_msgs::KnowledgeItem item;
            item.knowledge_type = rosplan_knowledge_msgs::KnowledgeItem::FACT;
            item.attribute_name = op.at_start_add_effects[i].name;
            item.values.clear();
            diagnostic_msgs::KeyValue pair;
            for (size_t j = 0; j < op.at_start_add_effects[i].typed_parameters.size(); j++) {
                pair.key = predicates[op.at_start_add_effects[i].name].typed_parameters[j].key;
                pair.value = boundParameters[op.at_start_add_effects[i].typed_parameters[j].key];
                item.values.push_back(pair);
            }
            updatePredSrv.request.knowledge.push_back(item);
            updatePredSrv.request.update_type.push_back(rosplan_knowledge_msgs::KnowledgeUpdateService::Request::ADD_KNOWLEDGE);
        }

        if (updatePredSrv.request.knowledge.size() > 0 && !update_knowledge_client.call(updatePredSrv))
            ROS_INFO("KCL: (%s) failed to update PDDL model in knowledge base", params.name.c_str());

        std::string parameter_temp = big_plan[id].name + " " + to_string(big_plan[id].action_id);
        print_log(node_name, __func__, "update at start by agent" + to_string(id) + " [ " + parameter_temp + " ]");
    }

    void Ai_Manager::update_end(int id) {
        std::string name = big_plan[id].name;
        std::map<std::string, rosplan_knowledge_msgs::DomainFormula> predicates = operator_info[name].predicates;
        std::map<std::string, rosplan_knowledge_msgs::DomainFormula> sensed_predicates = operator_info[name].sensed_predicates;

        rosplan_knowledge_msgs::DomainFormula params = operator_info[name].params;
        rosplan_knowledge_msgs::DomainOperator op = operator_info[name].op;

        std::vector<diagnostic_msgs::KeyValue> parameters = big_plan[id].parameters;

        std::vector<bool> found(params.typed_parameters.size(), false);
        std::map<std::string, std::string> boundParameters;
        for (size_t j = 0; j < params.typed_parameters.size(); j++) {
            for (size_t i = 0; i < parameters.size(); i++) {
                if (params.typed_parameters[j].key == parameters[i].key) {
                    boundParameters[parameters[i].key] = parameters[i].value;
                    found[j] = true;
                    break;
                }
            }
            if (!found[j]) {
                ROS_INFO("KCL: (%s) aborting action dispatch; malformed parameters, missing %s", params.name.c_str(), params.typed_parameters[j].key.c_str());
                return;
            }
        }

        // update knowledge base
        rosplan_knowledge_msgs::KnowledgeUpdateServiceArray updatePredSrv;

        // simple END del effects
        for (int i = 0; i < op.at_end_del_effects.size(); i++) {
            std::map<std::string, rosplan_knowledge_msgs::DomainFormula>::iterator it = sensed_predicates.find(op.at_end_del_effects[i].name);
            if (it != sensed_predicates.end()) continue;  // sensed predicate

            rosplan_knowledge_msgs::KnowledgeItem item;
            item.knowledge_type = rosplan_knowledge_msgs::KnowledgeItem::FACT;
            item.attribute_name = op.at_end_del_effects[i].name;
            item.values.clear();
            diagnostic_msgs::KeyValue pair;
            for (size_t j = 0; j < op.at_end_del_effects[i].typed_parameters.size(); j++) {
                pair.key = predicates[op.at_end_del_effects[i].name].typed_parameters[j].key;
                pair.value = boundParameters[op.at_end_del_effects[i].typed_parameters[j].key];
                item.values.push_back(pair);
            }
            updatePredSrv.request.knowledge.push_back(item);
            updatePredSrv.request.update_type.push_back(rosplan_knowledge_msgs::KnowledgeUpdateService::Request::REMOVE_KNOWLEDGE);
        }

        // simple END add effects
        for (int i = 0; i < op.at_end_add_effects.size(); i++) {
            std::map<std::string, rosplan_knowledge_msgs::DomainFormula>::iterator it = sensed_predicates.find(op.at_end_add_effects[i].name);
            if (it != sensed_predicates.end()) continue;  // sensed predicate

            rosplan_knowledge_msgs::KnowledgeItem item;
            item.knowledge_type = rosplan_knowledge_msgs::KnowledgeItem::FACT;
            item.attribute_name = op.at_end_add_effects[i].name;
            item.values.clear();
            diagnostic_msgs::KeyValue pair;
            for (size_t j = 0; j < op.at_end_add_effects[i].typed_parameters.size(); j++) {
                pair.key = predicates[op.at_end_add_effects[i].name].typed_parameters[j].key;
                pair.value = boundParameters[op.at_end_add_effects[i].typed_parameters[j].key];
                item.values.push_back(pair);
            }
            updatePredSrv.request.knowledge.push_back(item);
            updatePredSrv.request.update_type.push_back(rosplan_knowledge_msgs::KnowledgeUpdateService::Request::ADD_KNOWLEDGE);
        }

        if (updatePredSrv.request.knowledge.size() > 0 && !update_knowledge_client.call(updatePredSrv))
            ROS_INFO("KCL: (%s) failed to update PDDL model in knowledge base", params.name.c_str());

        std::string parameter_temp = big_plan[id].name + " " + to_string(big_plan[id].action_id);
        print_log(node_name, __func__, "update at end by agent" + to_string(id) + " [ " + parameter_temp + " ]");
    }
}  // namespace Custom

int main(int argc, char **argv)
{
    ros::init(argc, argv, "ai_manager");
    ros::NodeHandle nh("~");
    std::string node_name = ros::this_node::getName();  //자신의 노드 이름 확인
    int point = node_name.find("/", 0);                 //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
    node_name = node_name.substr(point + 1);            //노드 이름 저장
    Custom::Ai_Manager mi(nh, node_name);

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


    ros::Rate loopRate(1);
  ros::AsyncSpinner spinner(4);		//다중 스레드 사용
  spinner.start();
  ros::waitForShutdown();
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

void print_log(string node_name, string func,string str){
	cout<< "[";
	cout.width(9);cout.fill(' ');cout<<fixed;cout.precision(3);
	cout<<std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::now().time_since_epoch()).count()/1000.0<<"][";
	cout.width(13);cout.fill(' ');
	cout<<node_name<<"][";
	cout.width(17);cout.fill(' ');
	cout<<func<<"] ( "<<str<<" )"<<endl;
}