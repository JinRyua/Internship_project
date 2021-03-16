
#include "ros/ros.h"
#include "std_msgs/String.h"
#include "chat_client/Num.h"  //msg


#include <sstream>
#include <iostream>
#include <string>

using namespace std;

string node_name; //자신의 이름

void chatterCallback(const chat_client::Num& msg) //채팅 받았을 때의 콜백
{
  if(node_name!=msg.pub)                  //자신이 친 채팅이 아니라면
    cout<<msg.pub<<" : "<<msg.str<<endl;  //출력
}
/**
 * This tutorial demonstrates simple sending of messages over the ROS system.
 */
int main(int argc, char **argv)
{
  
  ros::init(argc, argv, "chatter");

  ros::NodeHandle n;  //node handler

  node_name =ros::this_node::getName();    //자신의 노드 이름 확인
  int point=node_name.find("_",10);         //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
  node_name=node_name.substr(point+1);

  ros::Subscriber sub = n.subscribe("chatting", 1000, chatterCallback);  //listener-> callback함수를 통해 화면에 출력



  ros::Rate loop_rate(10);  //loop rate

  ros::spin();            //spin


  return 0;
}