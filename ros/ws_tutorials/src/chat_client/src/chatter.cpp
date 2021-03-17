
#include "ros/ros.h"
#include "std_msgs/String.h"

//msg include
#include "chat_client/stdi.h"             //std_input_msg 
#include "chat_client/response.h"         //response_msg
#include "chat_client/login_msg.h"        //login_msg
#include "chat_client/want_list_msg.h"    //want_list_msg
#include "chat_client/give_list_msg.h"    //give_list_msg
#include "chat_client/select_msg.h"       //select_msg
#include "chat_client/send_chat_msg.h"    //send_chat_msg
#include "chat_client/exit_group_msg.h"   //exit_group_msg
#include "chat_client/spread_chat_msg.h"  //spread_chat_msg
#include "chat_client/connect_msg.h"      //connect_msg

#include <sstream>
#include <iostream>
#include <string>

using namespace std;

string node_id; //자신의 이름
string id;   //자신의 id;
string group; //이 노드의 group
string buffer="";   //buffer(입력)

int state=-1;    //현재 상태
ros::NodeHandle* nn;  //전역 nodehandler

ros::Publisher pub;   //전역 publisher
ros::Publisher login_pub;
ros::Publisher select_group_pub;
ros::Publisher want_list_pub;
ros::Publisher exit_group_pub;
ros::Publisher send_chat_pub;

ros::Subscriber chat_sub; //spread_chat subscriber

vector<string> split(string str, char delimiter); //문자열을 vector로 나누기 위한 함수

//function=> 입력을 받았을 때 작동
void login();           
void want_list();
void select_group();
void send_chat();
void exit_group();


//Callback들 topic_Callback 구조
void stdi_Callback(const chat_client::stdi& msg);
void login_response_Callback(const chat_client::response& msg);
void give_list_Callback(const chat_client::give_list_msg& msg);
void select_response_Callback(const chat_client::response& msg);
void exit_response_Callback(const chat_client::response& msg);
void spread_chat_Callback(const chat_client::spread_chat_msg& msg);
void connect_response_Callback(const chat_client::response& msg);

void stdi_Callback(const chat_client::stdi& msg) {  //입력 받았을 때의 콜백 
    buffer=msg.str;   //buffer에 입력 스트링 저장

    if(state==0){   //로그인 상태
      login();
    }
    else if(state==2){    //그룹 선택 상태
      select_group();
    }
    else if(state==4){    //채팅 상태
      if(buffer!="/exit") //  /exit을 입력받으면 exit 아니면 채팅
        send_chat();
      else
        exit_group();
    }
    buffer = "";    //buffer 제거
}

void login_response_Callback(const chat_client::response &msg){ //로그인 응답을 받았을 때의 콜백
  if (msg.success == true){   //성공일 경우
    cout << "login success!" << endl<<endl;
    state = 1;    //list를 요구하는 상태
    want_list();    //그룹 list 요구
  }
  else{
    cout << msg.msg << endl;
    state=0;
  }
}

void give_list_Callback(const chat_client::give_list_msg &msg){   //리스트를 받았을 때 콜백
  vector<string> temp = split(msg.list_group, ',');   //받은 리스트들을 vector로 분리 => a,b,c... [a][b][c]

  cout << "possible group : " << endl;
  for (int i = 0; i < temp.size(); i++)   //출력
  {
    cout << temp[i] << endl;
  }
  cout<<endl;

  state = 2; //그룹 입력 상태
}

void select_response_Callback(const chat_client::response &msg){    //그룹 선택 응답을 받았을 때 콜백
  if (msg.success == true){ //성공이라면
    state = 4;              //채팅상태로

    cout<<msg.msg<<endl;
    cout << "You join in " << group << ". start chat" << endl;

    string spread_chat_str = "spread_chat/to_" + group;       //선택한 그룹에서 채팅을 받을 수 있도록
    chat_sub = nn->subscribe(spread_chat_str, 1000, spread_chat_Callback);    //spread_chat
  }
  else  //아니라면 다시 그룹 선택
    state = 2;
}

void exit_response_Callback(const chat_client::response &msg){    // 그룹 탈출 응답 받았을 때 콜백
  if (msg.success == true){
    cout << "exit " << group << "!" << endl<<endl;
    state = 1;    //그룹 리스트를 받는 상태
    group = "";   //속한 group 제거
    want_list();  //리스트 요구
  }
  else{
    cout << msg.msg << endl;
  }
}

void spread_chat_Callback(const chat_client::spread_chat_msg &msg){  //채팅을 받았을 떄 콜백
  if (msg.id != id){
    cout << msg.id << " : " << msg.msg << endl; //자신이 아니라면(id) 출력
  }
  state = 4;    //채팅 상태
}

void connect_response_Callback(const chat_client::response& msg){
  if (msg.success == true){
    cout << "connected"<<endl;
    state = 0;    //그룹 리스트를 받는 상태
    cout<<"typing login info : id pw"<<endl;
  }
  else{
    cout << msg.msg << endl;
  }
}

void login(){       //로그인 함수
  int point = buffer.find(" ");
  string id_temp = buffer.substr(0, point);   //buffer에서 (한줄) id,pw 분리

  if (point != -1){     //2개 이상을 입력했다면
    string pw_temp = buffer.substr(point + 1);  //pw 분리

    chat_client::login_msg temp_login;    //msg type
    temp_login.node_id = node_id;
    temp_login.id = id_temp;
    temp_login.pw = pw_temp;

    //string login_str = "login/to_server";   //login topic
    // pub = nn->advertise<chat_client::login_msg>(login_str, 1000); //login=->topic
    // ros::Duration(0.5).sleep();   //대기

    login_pub.publish(temp_login);    //publish

    id = id_temp; //id 접속 상태
    state=1;      //리스트 대기 상태
  }
  else{
    cout << "please chat (id pw)" << endl;
  }
}

void want_list(){   //그룹 리스트 요구 함수
  chat_client::want_list_msg msg;
  msg.node_id = node_id;
  msg.id = id;
  
  want_list_pub.publish(msg);
}

void select_group(){    //그룹 선택 함수
  chat_client::select_msg msg;
  msg.node_id = node_id;
  msg.id = id;
  msg.group = buffer;
  select_group_pub.publish(msg);

  group = msg.group;      //선택한 그룹으로 일시적 저장
  state = 3;              //그룹 선택 대기 상태
}

void send_chat()    {     //채팅을 보내는 함수
  chat_client::send_chat_msg msg;
  msg.node_id = node_id;
  msg.id = id;
  msg.group = group;
  msg.msg = buffer;
  
  send_chat_pub.publish(msg);
  state = 5;  //응답 대기 상태
}

void exit_group(){      //그룹 탈출 함수
  chat_client::exit_group_msg msg;
  msg.node_id = node_id;
  msg.id = id;
  msg.group = group;

  exit_group_pub.publish(msg);     //publish
  state = 5;    //응답 대기 상태
}

int main(int argc, char **argv){
  ros::init(argc, argv, "chatter");
  ros::NodeHandle n; //node handler
  nn = &n;    //전역 node handler

  node_id = ros::this_node::getName(); //자신의 노드 이름 확인
  int point = node_id.find("_", 10);   //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
  node_id = node_id.substr(point + 1);


  //subscriber
  ros::Publisher connect = n.advertise<chat_client::connect_msg>("connect/to_server", 1000);
  ros::Subscriber connect_response = n.subscribe("connect_response/to_"+node_id,1000,connect_response_Callback);
  chat_client::connect_msg msg;
  msg.node_id = node_id;

  login_pub = n.advertise<chat_client::login_msg>("login/to_server", 1000);
  select_group_pub = n.advertise<chat_client::select_msg>("select_group/to_server", 1000);
  want_list_pub = n.advertise<chat_client::want_list_msg>("want_list/to_server", 1000);
  exit_group_pub = n.advertise<chat_client::exit_group_msg>("exit_group/to_server", 1000);
  send_chat_pub = n.advertise<chat_client::send_chat_msg>("send_chat/to_server", 1000);
  

  string stdi_str = "get_input/to_" + node_id;
  ros::Subscriber get_input_sub = n.subscribe(stdi_str, 1000, stdi_Callback); //get_input

  string login_res_str = "login_response/to_" + node_id;
  ros::Subscriber login_response_sub = n.subscribe(login_res_str, 1000, login_response_Callback);   //login_response

  string give_list_str = "give_list/to_" + node_id;
  ros::Subscriber give_list_sub = n.subscribe(give_list_str, 1000, give_list_Callback);   //give_list

  string select_res_str = "select_response/to_" + node_id;
  ros::Subscriber select_response_sub = n.subscribe(select_res_str, 1000, select_response_Callback);    //select_response

  string exit_res_str = "exit_response/to_" + node_id;
  ros::Subscriber exit_response_sub = n.subscribe(exit_res_str, 1000, exit_response_Callback);      //exit_response
  ros::Rate loop_rate(1000); //loop rate
  ros::Duration(0.5).sleep();
  //loop_rate.sleep();
  connect.publish(msg);

  //

  

  ros::spin(); //spin

  return 0;
}

vector<string> split(string input, char delimiter)
{
  vector<string> answer;
  stringstream ss(input);
  string temp;

  while (getline(ss, temp, delimiter))
  {
    answer.push_back(temp);
  }

  return answer;
}