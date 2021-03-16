
#include "ros/ros.h"
#include "std_msgs/String.h"
#include "chat_client/chatting.h"  //chat msg
#include "chat_client/group.h"  //group
#include "chat_client/stdi.h"  //std_input msg
#include "chat_client/response.h"
#include "chat_client/login_msg.h"

#include <sstream>
#include <iostream>
#include <string>

using namespace std;

string node_id; //자신의 이름
string buffer="";
int state=0;
ros::NodeHandle* nn;


ros::Subscriber chat_sub;

void stdi_Callback(const chat_client::stdi& msg) //채팅 받았을 때의 콜백
{ 
    cout<<msg.str<<endl;  //출력
    ros::NodeHandle n;
    chat_client::login_msg temp_login;
    temp_login.node_id=node_id;
    temp_login.id="id";
    temp_login.pw="pw";
    string login_str="login/to_server";
    ros::Publisher login_pub = nn->advertise<chat_client::login_msg>(login_str, 1000); //std_input topic
    login_pub.publish(temp_login);
}

void login_response_Callback(const chat_client::response& msg) //채팅 받았을 때의 콜백
{ 
    if(msg.success==true)
      cout<<"login success!"<<endl;
}


int main(int argc, char **argv)
{
  
  ros::init(argc, argv, "chatter");
  ros::NodeHandle n;  //node handler
  nn=&n;

  node_id =ros::this_node::getName();    //자신의 노드 이름 확인
  int point=node_id.find("_",10);         //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
  node_id=node_id.substr(point+1);

  string stdi_str="get_input/to_"+node_id;
  ros::Subscriber get_input_sub = n.subscribe(stdi_str, 1000, stdi_Callback);  //listener-> callback함수를 통해 화면에 출력
  
  string login_res_str="login_response/to_"+node_id;
  ros::Subscriber login_response_sub = n.subscribe(login_res_str, 1000, login_response_Callback);

  string login_str="login/to_server";
  ros::Publisher login_pub = n.advertise<chat_client::login_msg>(login_str, 1000); //std_input topic



  ros::Rate loop_rate(10);  //loop rate

  chat_client::login_msg temp_login;
  temp_login.node_id=node_id;
  temp_login.id="hi";
  temp_login.pw="pw";
  login_pub.publish(temp_login);

  ros::spin();            //spin


  return 0;
}