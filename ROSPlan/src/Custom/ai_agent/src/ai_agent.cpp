#include "ros/ros.h"

int main(int argc, char **argv)
{
    ros::init(argc, argv, "ai_agent");
    ros::NodeHandle nh("~");

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