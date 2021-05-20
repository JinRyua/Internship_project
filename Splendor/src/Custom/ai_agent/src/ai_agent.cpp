#include "ros/ros.h"
#include "ai_agent/ai_agent.h"
#include "board/do_action_srv.h"
#include "rosplan_dispatch_msgs/ActionFeedback.h"
#include "diagnostic_msgs/KeyValue.h"

#include <chrono>
#include <iostream>
using namespace std;
 

namespace Custom{
    AI::AI(ros::NodeHandle &nh){
        node_handle = &nh;
        state = GAME;
        node_name = ros::this_node::getName();
        cout<<node_name<<endl;
        feedback_pub = nh.advertise<rosplan_dispatch_msgs::ActionFeedback>("/rosplan_plan_dispatcher/action_feedback/from_ai", 1000);
        // //state call

        ros::service::waitForService("/board/do_action", ros::Duration(20));
        do_action_cli = nh.serviceClient<board::do_action_srv>("/board/do_action");
        
    }

    AI::~AI(){

    }

    int AI::change_to_color_int_from_string(std::string& n){
        if(n=="white")
            return WHITE;
        else if(n=="blue")
            return BLUE;
        else if(n=="green")
            return GREEN;
        else if(n=="red")
            return RED;
        else if(n=="black")
            return BLACK;
    }

    void AI::dispatch_callback(const rosplan_dispatch_msgs::ActionDispatch& msg){
        state = GAME;
        //publish enabled
        if(msg.name == "cancel_action")
            return;
        rosplan_dispatch_msgs::ActionFeedback feed;
        feed.action_id = msg.action_id;
        feed.status = "action enabled";
        feed.information = msg.parameters;
        feedback_pub.publish(feed);
        ros::spinOnce();
        plan = msg;
        board::do_action_srv srv;
        srv.request.name = node_name;
        if(msg.name == "three_coin"){
            srv.request.action = 0;
            vector<int> details;
            vector<int> abandon;

            vector<diagnostic_msgs::KeyValue> params = msg.parameters;
            
            for(int i =0; i<params.size();i++){
                if(params[i].key.find("get")!=-1){
                    if(params[i].value != "none")
                        details.push_back(change_to_color_int_from_string(params[i].value));
                }
                else{
                    if(params[i].value != "none")
                        abandon.push_back(change_to_color_int_from_string(params[i].value));
                }
                    
            }
            srv.request.details = details;
            srv.request.abandon = abandon;
        }
        else if(msg.name == "two_coin"){
            srv.request.action = 1;
            vector<int> details;

            vector<diagnostic_msgs::KeyValue> params = msg.parameters;
            
            details.push_back(change_to_color_int_from_string(params[0].value));


            srv.request.details = details;
        }
        else if(msg.name == "buy"){
            srv.request.action = 2;
            vector<int> details;

            vector<diagnostic_msgs::KeyValue> params = msg.parameters;

            if (params[0].value == "buy_level1")
                details.push_back(0);
            else if (params[0].value == "buy_level2")
                details.push_back(1);
            else if (params[0].value == "buy_level3")
                details.push_back(2);

            if (params[1].value == "order1")
                details.push_back(0);
            else if (params[1].value == "order2")
                details.push_back(1);
            else if (params[1].value == "order3")
                details.push_back(2);
            else if (params[1].value == "order4")
                details.push_back(3);


            srv.request.details = details;

        }

        ros::service::waitForService("/board/do_action", ros::Duration(20));
        if (do_action_cli.call(srv)) {
            if (srv.response.success == true) {
                feed.status = "action achieved";
                feedback_pub.publish(feed);
                state = WAIT;
            }
        }else {
        cout<<"why?"<<endl;
        }
    }
        
}


int main(int argc, char **argv)
{
    ros::init(argc, argv, "ai");
    ros::NodeHandle nh("~");

    Custom::AI ai(nh);

 
    //subscriber
    std::string dispatch_topic = "/rosplan_plan_dispatcher/action_dispatch/to_ai";
    nh.getParam("dispatch_name", dispatch_topic);
    ros::Subscriber dispatch_sub = nh.subscribe(dispatch_topic, 1000, &Custom::AI::dispatch_callback,
                                               dynamic_cast<Custom::AI *>(&ai));


    std::cout<<"ready to run ai"<<std::endl;
    
    double act_time = 0.04;
    int i =0;

    while (ros::ok())
    {
        sleep(0);
        double start_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
        ros::spinOnce();
    }

    return 0;    
}