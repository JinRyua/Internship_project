
#include "ros/ros.h"
#include "std_msgs/String.h"
#include "chat_client/chatting.h"  //chat msg
#include "chat_client/group.h"  //group
#include "chat_client/stdi.h"


#include <sstream>
#include <iostream>
#include <string>

using namespace std;

static int state=0;

int main(int argc, char **argv)
{

  ros::init(argc, argv, "keyboard");

  ros::NodeHandle n; //node handler

  string node_id = ros::this_node::getName(); //자신의 노드 이름 확인
  int point = node_id.find("_", 10);          //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
  node_id = node_id.substr(point + 1);

  string publish = "get_input/to_" + node_id;
  ros::Publisher stdi_pub = n.advertise<chat_client::stdi>(publish, 1000); //std_input topic

  ros::Rate loop_rate(10); //loop_rate

  while (ros::ok() && !cin.eof())
  {
    std::stringstream ss; //stringstream
    string temp;
    getline(std::cin, temp);
    fflush(stdin);
    chat_client::stdi stdi_msg;
    ss << temp;
    stdi_msg.str = temp; //내용입력
    stdi_pub.publish(stdi_msg);
    //cin buffer clear
    ros::spinOnce(); //spinonce use while

    loop_rate.sleep();
  }

  return 0;
}