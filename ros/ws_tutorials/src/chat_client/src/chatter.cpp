
#include "ros/ros.h"
#include "std_msgs/String.h"
#include "std_msgs/Empty.h"

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

int state=0;    //현재 상태
ros::NodeHandle* nn;  //전역 nodehandler

ros::Publisher login_pub;         //로그인을 하는 토픽
ros::Publisher select_group_pub;  //그룹을 선택하는 토픽
ros::Publisher want_list_pub;     //그룹 리스트를 요구하는 토픽
ros::Publisher exit_group_pub;    //그룹을 탈출하는 토픽
ros::Publisher send_chat_pub;     //메세지를 보내는 토픽

ros::Subscriber chat_sub; //spread_chat subscriber

vector<string> split(string str, char delimiter); //문자열을 vector로 나누기 위한 함수

//function=> 입력을 받았을 때 작동
void login();           //로그인
void want_list();       //그룹 리스트 요구
void select_group();    //그룹 선택
void send_chat();       //메세지 전송
void exit_group();      //그룹 탈출


//Callback들 topic_Callback 구조
void stdi_Callback(const chat_client::stdi& msg);                       //키보드 입력을 받는 subscriber
void login_response_Callback(const chat_client::response& msg);         //로그인에 대한 응답을 받음
void give_list_Callback(const chat_client::give_list_msg& msg);         //그룹 리스트를 받음
void select_response_Callback(const chat_client::response& msg);        //그룹 선택에 대한 응답을 받음
void exit_response_Callback(const chat_client::response& msg);          //그룹 탈출에 대한 응답을 받음
void spread_chat_Callback(const chat_client::spread_chat_msg& msg);     //그룹별로 나누어 지는 채팅 응답을 받음


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
        exit_group();       //맞으면 탈출
    }
    buffer = "";    //buffer 제거
}

void login_response_Callback(const chat_client::response &msg){ //로그인 응답을 받았을 때의 콜백
  if (msg.success == true){   //성공일 경우
    cout << "login success!" << endl<<endl;     //로그인 성공 출력
    state = 1;    //list를 요구하는 상태
    want_list();    //그룹 list 요구
  }
  else{
    cout << msg.msg << endl;  //로그인 실패면 메세지 출력후 다시 로그인 시도 상태
    state=0;        //로그인을 해야하는 상태
  }
}

void give_list_Callback(const chat_client::give_list_msg &msg){   //리스트를 받았을 때 콜백
  vector<string> temp = split(msg.list_group, ',');   //받은 리스트들을 vector로 분리 => a,b,c... [a][b][c]

  cout << "possible group : " << endl;
  for (int i = 0; i < temp.size(); i++)   //그룹들 전부 출력
  {
    cout << temp[i] << endl;
  }
  cout<<endl;

  state = 2; //그룹 입력 상태
}

void select_response_Callback(const chat_client::response &msg){    //그룹 선택 응답을 받았을 때 콜백
  if (msg.success == true){ //성공이라면
    state = 4;              //채팅상태로

    cout << "You join in " << group << ". start chat" << endl;    //접속된 그룹의 정보 출력

    string spread_chat_str = "spread_chat/to_" + group;       //선택한 그룹에서 채팅을 받을 수 있도록
    chat_sub = nn->subscribe(spread_chat_str, 1000, spread_chat_Callback);    //속한 그룹의 채팅을 받을 수 있게 subscriber 설정 
  }
  else  {//아니라면 다시 그룹 선택
    cout<<msg.msg<<endl;  //오류 메세지 출력
    state = 2;
  }
}

void exit_response_Callback(const chat_client::response &msg){    // 그룹 탈출 응답 받았을 때 콜백
  if (msg.success == true){
    cout << "exit " << group << "!" << endl<<endl;
    state = 1;    //그룹 리스트를 받는 상태
    group = "";   //속한 group 정보 제거
    want_list();  //그룹 리스트 요구
  }
  else{
    cout << msg.msg << endl;      //오류 메세지 출력
  }
}

void spread_chat_Callback(const chat_client::spread_chat_msg &msg){  //채팅을 받았을 떄 콜백
  if (msg.id != id){
    cout << msg.id << " : " << msg.msg << endl; //자신이 아니라면(id) 메세지 출력
  }
  state = 4;    //채팅 상태
}




void login(){       //로그인 함수
  int point = buffer.find(" ");
  int point2 = buffer.find(" ",point+1);
  string id_temp = buffer.substr(0, point);   //buffer에서 (한줄) id,pw 분리

  if (point != -1 && point2 == -1){     //2개를 입력했다면
    string pw_temp = buffer.substr(point + 1);  //pw 분리
    point = buffer.find(" ");
    chat_client::login_msg temp_login;    //msg type
    temp_login.id = id_temp;            //id와 pw만 적음
    temp_login.pw = pw_temp;

    login_pub.publish(temp_login);    //login/to_server 토픽으로 publish

    id = id_temp; //id 접속 상태
    state=1;      //리스트 대기 상태
  }
  else{
    cout << "please chat (id pw)" << endl;    //id pw 형식으로 입력 안하면 다시 하게 함
  }
}

void want_list(){   //그룹 리스트 요구 함수
  std_msgs::Empty msg;         //Empty 메세지
  
  want_list_pub.publish(msg); //Empty 메세지를 보냄 /want_list/to_server
}

void select_group(){    //그룹 선택 함수
  chat_client::select_msg msg;
  msg.group = buffer;           //접속할 그룹 정보만 저장해서 publish
  select_group_pub.publish(msg);    //select_group/to_server 토픽

  group = msg.group;      //선택한 그룹으로 일시적 저장
  state = 3;              //그룹 선택 대기 상태
}

void send_chat()    {     //채팅을 보내는 함수
  chat_client::send_chat_msg msg;
  msg.msg = buffer;     //메세지만 보냄
  
  send_chat_pub.publish(msg);   //send_chat/to_server 토픽
  state = 5;  //응답 대기 상태
}

void exit_group(){      //그룹 탈출 함수
  std_msgs::Empty msg;    //empty 메세지 전송

  exit_group_pub.publish(msg);     //exit_group/to_server 토픽
  state = 5;    //응답 대기 상태
}



int main(int argc, char **argv){
  ros::init(argc, argv, "chatter");
  ros::NodeHandle n; //node handler
  nn = &n;    //전역 node handler

  node_id = ros::this_node::getName(); //자신의 노드 이름 확인
  int point = node_id.find("_", 10);   //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
  node_id = node_id.substr(point + 1);  //노드 이름 저장

  //server에 관한 publisher
  login_pub = n.advertise<chat_client::login_msg>("login/to_server", 1000);                   //로그인에 대한 pub
  select_group_pub = n.advertise<chat_client::select_msg>("select_group/to_server", 1000);    //그룹 선택에 대한 pub
  want_list_pub = n.advertise<std_msgs::Empty>("want_list/to_server", 1000);                  //그룹 리스트 요구에 대한 pub
  exit_group_pub = n.advertise<std_msgs::Empty>("exit_group/to_server", 1000);                //그룹 탈출 요구에 대한 pub
  send_chat_pub = n.advertise<chat_client::send_chat_msg>("send_chat/to_server", 1000);       //메세지 전송에 대한 pub

  //key 입력에 대한 subscriber
  string stdi_str = "get_input/to_" + node_id;
  ros::Subscriber get_input_sub = n.subscribe(stdi_str, 1000, stdi_Callback); //get_input/to_node_id 키보드 입력을 받는 sub

  //server에 관한 subscriber
  string login_res_str = "login_response/to_" + node_id;
  ros::Subscriber login_response_sub = n.subscribe(login_res_str, 1000, login_response_Callback);   // login_response/to_node_id 로그인 응답을 받는 sub

  string give_list_str = "give_list/to_" + node_id;
  ros::Subscriber give_list_sub = n.subscribe(give_list_str, 1000, give_list_Callback);   // give_list/to_node_id  그룹 리스트를 받는 sub

  string select_res_str = "select_response/to_" + node_id;
  ros::Subscriber select_response_sub = n.subscribe(select_res_str, 1000, select_response_Callback);    //select_response/to_node_id 그룹 선택에 대한 응답을 받는 sub

  string exit_res_str = "exit_response/to_" + node_id;
  ros::Subscriber exit_response_sub = n.subscribe(exit_res_str, 1000, exit_response_Callback);      //exit_response/to_node_id 그룹 탈출에 대한 응답을 받는 sub
  ros::Rate loop_rate(1000); //loop rate

  cout<<"typing login info : id pw"<<endl;

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