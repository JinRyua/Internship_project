
#include "ros/ros.h"
#include "std_msgs/String.h"
#include "chat_client/chatting.h"  //chat msg
#include "chat_client/login_msg.h"
#include "chat_client/response.h"
#include "chat_client/want_list_msg.h"
#include "chat_client/give_list_msg.h"

#include <sstream>
#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <map>
using namespace std;

string node_name; //자신의 이름

vector<vector<string>> login_info;
map<string,vector<string>> group_info;

ros::NodeHandle* nn;

ros::Publisher login_response_pub;
ros::Publisher give_list_pub;


void login_Callback(const chat_client::login_msg& lmsg) //채팅 받았을 때의 콜백
{
    vector<string> temp;
    cout<<"Hi"<<endl;
    temp.push_back(lmsg.id); temp.push_back(lmsg.pw);
    auto it=find(login_info.begin(),login_info.end(),temp);
    
    string str_temp="login_response/to_"+lmsg.node_id;
    cout<<str_temp<<endl;
    login_response_pub= nn->advertise<chat_client::response>(str_temp, 1000);
    ros::Duration(1.0).sleep();
    chat_client::response msg_temp;

    if (it == login_info.end())
    {
      msg_temp.success = false;
      msg_temp.msg = "일치하는 id 또는 pw가 없음";
      login_response_pub.publish(msg_temp);
      cout << "login false : " << temp[0] << " " << temp[1] << endl;
    }
    else
    {
      msg_temp.success = true;
      msg_temp.msg="";
      login_response_pub.publish(msg_temp);
      cout << "login success :" << temp[0] << " " << temp[1] << endl;
    }
}

void want_list_Callback(const chat_client::want_list_msg& msg){
  map<string,vector<string>>::iterator iter;
  iter=group_info.find(msg.id);
  string give_list_msg="";
  if(iter != group_info.end()){
      vector<string> temp=iter->second;
      for(int i=0; i<temp.size(); i++){
        give_list_msg = give_list_msg + temp[i];
        if(i!=temp.size()-1)
          give_list_msg = give_list_msg + ",";
      }
  }
  else{
      vector<string> temp;
      group_info.insert( pair<string, vector<string>>(msg.id, temp) );
  }
  string str_temp="give_list/to_"+msg.node_id;
  give_list_pub= nn->advertise<chat_client::give_list_msg>(str_temp, 1000);
  ros::Duration(1.0).sleep();
  chat_client::give_list_msg msg_temp;
  msg_temp.list_group=give_list_msg;
  give_list_pub.publish(msg_temp);
  cout<<"send give list to "<<msg.node_id<< " : "<<give_list_msg<<endl;

}
/**
 * This tutorial demonstrates simple sending of messages over the ROS system.
 */
int main(int argc, char **argv)
{
  
  ros::init(argc, argv, "server");

  ros::NodeHandle n;  //node handler
  nn=&n;
  vector<string> temp;
  temp.push_back("id");
  temp.push_back("pw");
  login_info.push_back(temp);

  vector<string> group_temp;
  group_temp.push_back("group1");
  group_temp.push_back("group2");
  group_info.insert(pair<string, vector<string>>("id",group_temp));

  cout<<login_info[0][0]<<" "<<login_info[0][1]<<endl;

  ros::Subscriber login = n.subscribe("login/to_server", 1000, login_Callback);  //listener-> callback함수를 통해 화면에 출력
  ros::Subscriber give_list = n.subscribe("want_list/to_server", 1000, want_list_Callback);  //listener-> callback함수를 통해 화면에 출력



  ros::Rate loop_rate(10);  //loop rate

  ros::spin();            //spin


  return 0;
}