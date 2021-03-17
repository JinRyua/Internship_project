
#include "ros/ros.h"
#include "std_msgs/String.h"

//msg
#include "chat_client/stdi.h"

#include <sstream>
#include <iostream>
#include <string>
using namespace std;

int main(int argc, char **argv){
  ros::init(argc, argv, "keyboard");

  ros::NodeHandle n; //node handler

  string node_id = ros::this_node::getName(); //자신의 노드 이름 확인
  int point = node_id.find("_", 10);          //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄  (하드 코딩) 원래는 node_id로
  node_id = node_id.substr(point + 1);

  string publish = "get_input/to_" + node_id;   //topic => get_input/to_node_id
  ros::Publisher stdi_pub = n.advertise<chat_client::stdi>(publish, 1000); //std_input topic pub

  ros::Rate loop_rate(10); //loop_rate

  while (ros::ok() && !cin.eof()){
    string temp;
    getline(std::cin, temp);    //getline으로 한줄 전체 입력 받음
    fflush(stdin);      //cin buffer clear

    chat_client::stdi stdi_msg;   //msg type
    stdi_msg.str = temp; //내용입력
    stdi_pub.publish(stdi_msg);   //publish
 
    ros::spinOnce();    //spinonce use while

    loop_rate.sleep();
  }

  return 0;
}