
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

#include <sstream>
#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <map>
using namespace std;

vector<vector<string>> login_info;        //id pw=>info
map<string, vector<string>> group_info;   //id가 가지고 있는 group info

ros::NodeHandle *nn;                      //NodeHandler

ros::Publisher login_response_pub;        //토픽들의 publisher 
ros::Publisher give_list_pub;
ros::Publisher select_response_pub;
ros::Publisher spread_chat_pub;
ros::Publisher exit_response_pub;

void login_Callback(const chat_client::login_msg &lmsg){ //로그인 시도를 받았을 때의 콜백
  vector<string> temp;        //받은 로그인 정보를 담기 위한 vector
  temp.push_back(lmsg.id);
  temp.push_back(lmsg.pw);
  auto it = find(login_info.begin(), login_info.end(), temp); //서버가 가지고 있는 정보에 있는지 확인

  string str_temp = "login_response/to_" + lmsg.node_id;
  login_response_pub = nn->advertise<chat_client::response>(str_temp, 1000);  //login_response를 위한 publisher
  ros::Duration(0.5).sleep();     //publisher를 위한 대기
  chat_client::response msg_temp; //msg type

  if (it == login_info.end()){  //정보가 없으면
    msg_temp.success = false;   //실패
    msg_temp.msg = "일치하는 id 또는 pw가 없음";  
    login_response_pub.publish(msg_temp); //전송
    cout << "login false : " << temp[0] << " " << temp[1] << endl;
  }
  else{
    msg_temp.success = true;  //성공
    msg_temp.msg = "";
    login_response_pub.publish(msg_temp); //전송
    cout << "login success :" << temp[0] << " " << temp[1] << endl;
  }
}

void want_list_Callback(const chat_client::want_list_msg &msg){ //그룹 리스트를 요구할 때의 콜백
  map<string, vector<string>>::iterator iter;   //탐색을 위한 이터레이터
  iter = group_info.find(msg.id);     //key(id)로 탐색

  string give_list_msg = "";

  if (iter != group_info.end()){      //존재하면
    vector<string> temp = iter->second;
    for (int i = 0; i < temp.size(); i++){      //그룹들을 하나의 string으로 만듬
      give_list_msg = give_list_msg + temp[i];
      if (i != temp.size() - 1)
        give_list_msg = give_list_msg + ",";
    }
  }
  else{                       //아니면(vector가 없으면)
    vector<string> temp;      
    group_info.insert(pair<string, vector<string>>(msg.id, temp));    //새롭게 id의 그룹 저장소를 추가하여 만듬
  }

  string str_temp = "give_list/to_" + msg.node_id;
  give_list_pub = nn->advertise<chat_client::give_list_msg>(str_temp, 1000);    //publisher
  ros::Duration(0.5).sleep();       //wait

  chat_client::give_list_msg msg_temp;    //msg type
  msg_temp.list_group = give_list_msg;
  give_list_pub.publish(msg_temp);      //publish

  cout << "send give list to " << msg.node_id << " : " << give_list_msg << endl;
}

void select_group_Callback(const chat_client::select_msg &msg){ //group을 선택했을 때 콜백
  cout << msg.node_id << " , " << msg.id << " select group : " << msg.group << endl;

  map<string, vector<string>>::iterator iter;     //group이 있는 지 확인하기 위한 이터레이터
  iter = group_info.find(msg.id);                 //id로 탐색
  string give_list_msg = "";

  if (iter != group_info.end()){   //있으면
    vector<string> temp = iter->second;
    vector<string>::iterator it = find(temp.begin(), temp.end(), msg.group);  //그룹 벡터에서 선택한 group이 있는지 확인

    string str_temp = "select_response/to_" + msg.node_id;
    select_response_pub = nn->advertise<chat_client::response>(str_temp, 1000); //publisher
    ros::Duration(0.5).sleep();
    chat_client::response msg_temp; //msg_type

    if (it != temp.end()) {  //그룹 벡터에 있으면
      msg_temp.msg = "";   
    }
    else{       //없으면
      iter->second.push_back(msg.group);    //그룹 벡터에 그룹을 새롭게 추가해줌 
      msg_temp.msg = "enter new group";
    }

    msg_temp.success = true;                //성공
    select_response_pub.publish(msg_temp);  //publish

    cout << msg.node_id << " , " << msg.id << " select group : " << msg.group << endl;
  }
}

void send_chat_Callback(const chat_client::send_chat_msg &msg){  //메세지를 보내는 걸 받았을 때 콜백
  cout << msg.node_id << " , " << msg.id << " send msg : " << msg.msg << " to " << msg.group << endl;

  string send_chat_str_temp = "spread_chat/to_" + msg.group;      //보내는 group들에게 spread
  spread_chat_pub = nn->advertise<chat_client::spread_chat_msg>(send_chat_str_temp, 1000);  //publisher
  ros::Duration(0.5).sleep();

  chat_client::spread_chat_msg msg_temp;    //msg_type
  msg_temp.id = msg.id;
  msg_temp.msg = msg.msg;

  spread_chat_pub.publish(msg_temp);    //publish
}

void exit_group_Callback(const chat_client::exit_group_msg &msg){   //그룹 탈출을 받았을 때 콜백
  cout << msg.node_id << " , " << msg.id << " exit : " << msg.group << endl;

  string exit_group_str_temp = "exit_response/to_" + msg.node_id;
  exit_response_pub = nn->advertise<chat_client::response>(exit_group_str_temp, 1000);  //publisher
  ros::Duration(0.5).sleep();

  chat_client::response msg_temp;   //msg type
  msg_temp.success = true;
  msg_temp.msg = "";

  exit_response_pub.publish(msg_temp);    //publish
}

int main(int argc, char **argv){

  ros::init(argc, argv, "server");

  ros::NodeHandle n; //node handler
  nn = &n;    //전역 변수로

  vector<string> temp;      //login info 하드 코딩으로 저장 (id,pw) (id2,pw) (id3,pw)
  temp.push_back("id");
  temp.push_back("pw");
  login_info.push_back(temp);
  temp[0] = "id2";
  login_info.push_back(temp);
  temp[0] = "id3";
  login_info.push_back(temp);

  vector<string> group_temp;        //group info 하드 코딩으로 저장 id에만 group1 group2저장
  group_temp.push_back("group1");
  group_temp.push_back("group2");
  group_info.insert(pair<string, vector<string>>("id", group_temp));

  cout << login_info[0][0] << " " << login_info[0][1] << endl;

  ros::Subscriber login_sub = n.subscribe("login/to_server", 1000, login_Callback);                      //login/to_server topic sub
  ros::Subscriber want_list_sub = n.subscribe("want_list/to_server", 1000, want_list_Callback);          //want_list topic sub
  ros::Subscriber select_group_sub = n.subscribe("select_group/to_server", 1000, select_group_Callback); //select_group sub
  ros::Subscriber exit_group_sub = n.subscribe("exit_group/to_server", 1000, exit_group_Callback);       //exit_group sub
  ros::Subscriber send_chat_sub = n.subscribe("send_chat/to_server", 1000, send_chat_Callback);          //send_chat sub

  ros::Rate loop_rate(10); //loop rate

  ros::spin(); //spin

  return 0;
}