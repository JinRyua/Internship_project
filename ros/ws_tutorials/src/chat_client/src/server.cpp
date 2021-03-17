
#include "ros/ros.h"
#include "std_msgs/String.h"
#include "chat_client/stdi.h"  //std_input msg
#include "chat_client/response.h"
#include "chat_client/login_msg.h"
#include "chat_client/want_list_msg.h"
#include "chat_client/give_list_msg.h"
#include "chat_client/select_msg.h"
#include "chat_client/send_chat_msg.h"
#include "chat_client/exit_group_msg.h"
#include "chat_client/spread_chat_msg.h"

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
ros::Publisher select_response_pub;
ros::Publisher spread_chat_pub;


void login_Callback(const chat_client::login_msg& lmsg) //채팅 받았을 때의 콜백
{
    vector<string> temp;
    cout<<"Hi"<<endl;
    temp.push_back(lmsg.id); temp.push_back(lmsg.pw);
    auto it=find(login_info.begin(),login_info.end(),temp);
    
    string str_temp="login_response/to_"+lmsg.node_id;
    cout<<str_temp<<endl;
    login_response_pub= nn->advertise<chat_client::response>(str_temp, 1000);
    ros::Duration(0.5).sleep();
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

void want_list_Callback(const chat_client::want_list_msg &msg)
{
  map<string, vector<string>>::iterator iter;
  iter = group_info.find(msg.id);
  string give_list_msg = "";
  if (iter != group_info.end())
  {
    vector<string> temp = iter->second;
    for (int i = 0; i < temp.size(); i++)
    {
      give_list_msg = give_list_msg + temp[i];
      if (i != temp.size() - 1)
        give_list_msg = give_list_msg + ",";
    }
  }
  else
  {
    vector<string> temp;
    group_info.insert(pair<string, vector<string>>(msg.id, temp));
  }
  string str_temp = "give_list/to_" + msg.node_id;
  give_list_pub = nn->advertise<chat_client::give_list_msg>(str_temp, 1000);
  ros::Duration(0.5).sleep();
  chat_client::give_list_msg msg_temp;
  msg_temp.list_group = give_list_msg;
  give_list_pub.publish(msg_temp);
  cout << "send give list to " << msg.node_id << " : " << give_list_msg << endl;
}

void select_group_Callback(const chat_client::select_msg &msg)//id 안씀 세션
{ 
  cout<<msg.node_id<<" , "<<msg.id<<" select group : "<<msg.group<<endl;
  map<string, vector<string>>::iterator iter;
  iter = group_info.find(msg.id);
  string give_list_msg = "";
  if (iter != group_info.end())
  {
    vector<string> temp = iter->second;
    vector<string>::iterator it = find(temp.begin(), temp.end(), msg.group);

    string str_temp = "select_response/to_" + msg.node_id;
    select_response_pub = nn->advertise<chat_client::response>(str_temp, 1000);
    ros::Duration(0.5).sleep();
    chat_client::response msg_temp;
    if (it != temp.end())
    {
      msg_temp.msg = "";
    }
    else
    {
      iter->second.push_back(msg.group);
      msg_temp.msg = "enter new group";
    }

    msg_temp.success = true;
    select_response_pub.publish(msg_temp);
    cout<<msg.node_id<<" , "<<msg.id<<" select group : "<<msg.group<<endl;
  }
}

void send_chat_Callback(const chat_client::send_chat_msg& msg){
  cout<<msg.node_id<<" , "<<msg.id<<" send msg : "<<msg.msg<<" to "<<msg.group<<endl;
  string str_temp = "spread_chat/to_" + msg.group;
  spread_chat_pub = nn->advertise<chat_client::spread_chat_msg>(str_temp, 1000);
  ros::Duration(0.5).sleep();
  chat_client::spread_chat_msg msg_temp;
  msg_temp.id=msg.id;
  msg_temp.msg=msg.msg;
  spread_chat_pub.publish(msg_temp);
  
}

int main(int argc, char **argv)
{
  
  ros::init(argc, argv, "server");

  ros::NodeHandle n;  //node handler
  nn=&n;
  vector<string> temp;
  temp.push_back("id");
  temp.push_back("pw");
  login_info.push_back(temp);
  temp[0]="id2";
  login_info.push_back(temp);
  temp[0]="id3";
  login_info.push_back(temp);

  vector<string> group_temp;
  group_temp.push_back("group1");
  group_temp.push_back("group2");
  group_info.insert(pair<string, vector<string>>("id",group_temp));

  cout<<login_info[0][0]<<" "<<login_info[0][1]<<endl;

  ros::Subscriber login_sub = n.subscribe("login/to_server", 1000, login_Callback);  //listener-> callback함수를 통해 화면에 출력
  ros::Subscriber want_list_sub = n.subscribe("want_list/to_server", 1000, want_list_Callback);  //listener-> callback함수를 통해 화면에 출력
  ros::Subscriber select_group_sub = n.subscribe("select_group/to_server", 1000, select_group_Callback);  //listener-> callback함수를 통해 화면에 출력
  ros::Subscriber exit_group_sub = n.subscribe("exit_group/to_server", 1000, want_list_Callback);  //listener-> callback함수를 통해 화면에 출력
  ros::Subscriber send_chat_sub = n.subscribe("send_chat/to_server", 1000, send_chat_Callback);  //listener-> callback함수를 통해 화면에 출력



  ros::Rate loop_rate(10);  //loop rate

  ros::spin();            //spin


  return 0;
}