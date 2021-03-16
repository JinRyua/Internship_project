
#include "ros/ros.h"
#include "std_msgs/String.h"
#include "chat_client/Num.h"


#include <sstream>
#include <iostream>
#include <string>

using namespace std;

int main(int argc, char **argv)
{
  
  ros::init(argc, argv, "keyboard");

  ros::NodeHandle n;  //node handler

  ros::Publisher chatter_pub = n.advertise<chat_client::Num>("chatting", 1000); //chatting topic
  
  string node_name =ros::this_node::getName();    //자신의 노드 이름 확인
  int point=node_name.find("_",10); //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
  node_name=node_name.substr(point+1);

  ros::Rate loop_rate(10);  //loop_rate

  while (ros::ok()&&!cin.eof())
  {
    chat_client::Num msg; //보낼 msg
    std::stringstream ss; //stringstream
    string temp;

    cin>>temp;
    fflush(stdin);  //buffer flush
    
    ss<<temp;
    msg.str=temp;     //내용입력
    ss<<node_name;
    msg.pub=node_name;  //발송인 입력

    chatter_pub.publish(msg); //chatting topic

    cin.clear();  //cin buffer clear
    
    ros::spinOnce();  //spinonce use while

    loop_rate.sleep();
  }


  return 0;
}