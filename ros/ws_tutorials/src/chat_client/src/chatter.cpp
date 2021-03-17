
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

using namespace std;

string node_id; //자신의 이름
string id;   //자신의 id;
string group;
string buffer="";
int state=0;
ros::NodeHandle* nn;

ros::Publisher pub;
ros::Subscriber chat_sub;

vector<string> split(string str, char delimiter);

void login();
void want_list();
void select_group();
void send_chat();

void stdi_Callback(const chat_client::stdi& msg);
void login_response_Callback(const chat_client::response& msg);
void give_list_Callback(const chat_client::give_list_msg& msg);
void select_response_Callback(const chat_client::response& msg);
void exit_response_Callback(const chat_client::response& msg);
void spread_chat_Callback(const chat_client::spread_chat_msg& msg);

void stdi_Callback(const chat_client::stdi& msg) //채팅 받았을 때의 콜백
{ 
    //cout<<msg.str<<endl;  //출력
    // ros::NodeHandle n;
    // chat_client::login_msg temp_login;
    buffer=msg.str;

    if(state==0){
      login();
    }
    else if(state==2){
      select_group();
    }
    else if(state==4){
      send_chat();
    }
    // temp_login.node_id=node_id;
    // temp_login.id="id";
    // temp_login.pw="pw";
    // string login_str="login/to_server";
    // ros::Publisher login_pub = nn->advertise<chat_client::login_msg>(login_str, 1000); //std_input topic
    // login_pub.publish(temp_login);
    buffer = "";
}

void login_response_Callback(const chat_client::response& msg) //채팅 받았을 때의 콜백
{ 
    cout<<"good"<<endl;
    if(msg.success==true){
      cout<<"login success!"<<endl;
      state=1;
      want_list();
    }
    else{
      cout<<msg.msg<<endl;
    }
}

void give_list_Callback(const chat_client::give_list_msg& msg){
    cout<<endl<<"give_list"<<endl;
    int point=0;
    vector<string> temp=split(msg.list_group,',');
    cout<<"possible group : "<<endl;
    for(int i=0;i<temp.size();i++){
        cout<<temp[i]<<endl;
    }
    state=2;
}

void select_response_Callback(const chat_client::response& msg){
  cout << msg.msg << endl;
  if (msg.success == true){
    state = 4;
    cout << "You join in " << group << ". start chat" << endl;
    string spread_chat_str="spread_chat/to_"+group;
    chat_sub = nn->subscribe(spread_chat_str, 1000, spread_chat_Callback);
    ros::Duration(0.5).sleep();
  }
  else
    state = 2;
}

void exit_response_Callback(){

}
void spread_chat_Callback(const chat_client::spread_chat_msg& msg){
  if(msg.id != id){
    cout << msg.id<<" : "<<msg.msg<<endl;
  }
  state=4;
}
void login()
{
  int point = buffer.find(" ");
  string id_temp = buffer.substr(0, point);
  if (point != -1)
  {
    string pw_temp = buffer.substr(point+1);
    chat_client::login_msg temp_login;
    temp_login.node_id = node_id;
    temp_login.id = id_temp;
    temp_login.pw = pw_temp;
    string login_str = "login/to_server";
    pub = nn->advertise<chat_client::login_msg>(login_str, 1000); //std_input topic
    ros::Duration(0.5).sleep();
    pub.publish(temp_login);
    id=id_temp;
  }
  else{
    cout<<"please chat (id pw)"<<endl;
  }
  
}

void want_list(){
  string want_str = "want_list/to_server";
  pub = nn->advertise<chat_client::want_list_msg>(want_str, 1000); //std_input topic
  ros::Duration(0.5).sleep();
  chat_client::want_list_msg msg;
  msg.node_id=node_id;
  msg.id=id;
  pub.publish(msg);
}


void select_group(){
  string select_group_str = "select_group/to_server";
  pub = nn->advertise<chat_client::select_msg>(select_group_str, 1000); //std_input topic
  ros::Duration(0.5).sleep();
  chat_client::select_msg msg;
  msg.node_id = node_id;
  msg.id = id;
  msg.group = buffer;
  pub.publish(msg);
  group = msg.group;
  state = 3;
}

void send_chat(){
  string send_chat_str = "send_chat/to_server";
  pub = nn->advertise<chat_client::send_chat_msg>(send_chat_str, 1000); //std_input topic
  ros::Duration(0.5).sleep();
  chat_client::send_chat_msg msg;
  msg.node_id=node_id;
  msg.id=id;
  msg.group=group;
  msg.msg=buffer;
  pub.publish(msg);
  state=5;
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

  string give_list_str="give_list/to_"+node_id;
  ros::Subscriber give_list_sub = n.subscribe(give_list_str, 1000, give_list_Callback);

  string select_res_str="select_response/to_"+node_id;
  ros::Subscriber select_response_sub = n.subscribe(select_res_str, 1000, select_response_Callback);

  // string exit_res_str="login_response/to_"+node_id;
  // ros::Subscriber exit_response_sub = n.subscribe(exit_res_str, 1000, exit_response_Callback);

  

  ros::Rate loop_rate(10);  //loop rate

  ros::spin();            //spin



  return 0;
}

vector<string> split(string input, char delimiter) {
    vector<string> answer;
    stringstream ss(input);
    string temp;
 
    while (getline(ss, temp, delimiter)) {
        answer.push_back(temp);
    }
 
    return answer;
}