
#include "ros/ros.h"
#include "std_msgs/String.h"


#include <sstream>
#include <iostream>
#include <string>

using namespace std;

void chatterCallback(const std_msgs::String::ConstPtr& msg)
{
  cout<<"msg"<<endl;
}
/**
 * This tutorial demonstrates simple sending of messages over the ROS system.
 */
int main(int argc, char **argv)
{
  
  ros::init(argc, argv, "keyboard");

  ros::NodeHandle n;  //node handler

  ros::Publisher chatter_pub = n.advertise<std_msgs::String>("chatting", 1000); //talker
  
  string node_name =ros::this_node::getName();    //자신의 노드 이름 확인

  //ros::Subscriber sub = n.subscribe("chatter", 1000, chatterCallback);  //listener-> callback함수를 통해 화면에 출력

  ros::Rate loop_rate(10);

  while (ros::ok())
  {
    std_msgs::String buff;

    string msg;

    std::stringstream ss;
    //msg.data = ss.str();

    //cin>>msg;
    
    //buff=msg;
    
    //ros::spinOnce();

    //chatter_pub.publish(msg);

    loop_rate.sleep();
  }


  return 0;
}