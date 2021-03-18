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
#include <vector>
#include <algorithm>
#include <map>
using namespace std;

struct pub_struct{//session의 형태 (노드마다 존재)
  ros::Publisher login_response_pub; //로그인 응답하는 토픽
  ros::Publisher give_list_pub;       //그룹 리스트를 보내는 토픽
  ros::Publisher select_response_pub;   //그룹 선택 응답을 하는 토픽
  ros::Publisher exit_response_pub;     //그룹 탈출 응답을 하는 토픽
  string id;        //노드가 접속한 id
  string group;     //노드가 접속한 group
};

void make_node_name(string&);  //publisher_name에서 node_id를 추출

vector<vector<string>> login_info;        //id pw=>info
map<string, vector<string>> group_info;   //id가 가지고 있는 group info
map<string, pub_struct> session;
map<string, ros::Publisher> spread_chat_group;

ros::NodeHandle *nn;                      //NodeHandler

void login_Callback(const ros::MessageEvent<chat_client::login_msg>& event)
{                             //로그인 시도를 받았을 때의 콜백
  string node_id = event.getPublisherName();    //subcribe를 받았을 때 event의 publisher를 가져옴
  make_node_name(node_id);    //publisher에서 node_id 추출

  //const chat_client::login_msg& data = event.getMessage();
  chat_client::login_msg::ConstPtr data = event.getConstMessage(); //login_msg 데이터 가져옴
  string id = data -> id;   //id 추출
  string pw = data -> pw;   //pw 추출

  map<string, pub_struct>::iterator iter = session.find(node_id); //session에 해당 노드가 있는지 체크

  if(iter == session.end()){    //없으면 session 만듬 -> 1회만
    struct pub_struct temp;     //session struct (publisher, id , node_id, group 이 있음)
    string str_temp = "login_response/to_" + node_id;
    temp.login_response_pub = nn->advertise<chat_client::response>(str_temp, 1000); //login_response를 위한 publisher
    str_temp = "give_list/to_" + node_id;
    temp.give_list_pub = nn->advertise<chat_client::give_list_msg>(str_temp, 1000); //give_list_publisher (리스트를 주기위한)
    str_temp = "select_response/to_" + node_id;
    temp.select_response_pub = nn->advertise<chat_client::response>(str_temp, 1000); //select_response_publisher  (그룹 선택 응답을 위한)
    str_temp = "exit_response/to_" + node_id;
    temp.exit_response_pub = nn->advertise<chat_client::response>(str_temp, 1000); //exit_response_publisher    (그룹 탈출 응답)
    session.insert(pair<string, pub_struct>(node_id, temp));                   //세션에 추가(node마다)
  }
  
  vector<string> temp;        //받은 로그인 정보를 담기 위한 vector
  temp.push_back(id);     //id 담음
  temp.push_back(pw);     //pw 담음
  auto it = find(login_info.begin(), login_info.end(), temp); //서버가 가지고 있는 정보에 있는지 확인

  chat_client::response msg_temp; //msg type

  if (it == login_info.end()){  //정보가 없으면
    msg_temp.success = false;   //실패
    msg_temp.msg = "일치하는 id 또는 pw가 없음";  
    cout << "login false : " << temp[0] << " " << temp[1] << endl;
  }
  else{
    msg_temp.success = true;  //성공
    msg_temp.msg = "";
    cout << "login success :" << temp[0] << " " << temp[1] << endl;
    session[node_id].id = id; //세션에 id추가
  }
  while (session[node_id].login_response_pub.getNumSubscribers() < 1); //대기 time connect_response publisher가 완성 되면
  session[node_id].login_response_pub.publish(msg_temp);  //session에 저장된 정보로 login_Response 응답
}

void want_list_Callback(const ros::MessageEvent<std_msgs::Empty>& event){ //그룹 리스트를 요구할 때의 콜백
  map<string, vector<string>>::iterator iter;   //탐색을 위한 이터레이터
  string node_id = event.getPublisherName();    //subcribe를 받았을 때 event의 publisher를 가져옴
  make_node_name(node_id);    //publisher에서 node_id 추출
  struct pub_struct& node_sess = session[node_id]; //세션에서 노드에 관한 정보 가져옴

  string id = session[node_id].id;    //세션에서 node에 해당된 id를 가져옴
  iter = group_info.find(id);     //key(노드의 id)로 탐색

  string give_list_msg = "";

  if (iter != group_info.end()){      //존재하면
    vector<string> temp = iter->second;
    for (int i = 0; i < temp.size(); i++){      //그룹들을 하나의 string으로 만듬
      give_list_msg = give_list_msg + temp[i];  //ex) group1,group2...
      if (i != temp.size() - 1)
        give_list_msg = give_list_msg + ",";
    }
  }
  else{                       //아니면(vector가 없으면)
    vector<string> temp;      
    group_info.insert(pair<string, vector<string>>(id, temp));    //새롭게 id의 그룹 저장소를 추가하여 만듬
  }

  chat_client::give_list_msg msg_temp;    //msg type
  msg_temp.list_group = give_list_msg;    //group list 담음
  node_sess.give_list_pub.publish(msg_temp);      //publish

  cout << "send give list to " << id << " : " << give_list_msg << endl;   //서버에 어떤 리스트를 보냈는지 출력
}

void select_group_Callback(const ros::MessageEvent<chat_client::select_msg>& event){ //group을 선택했을 때 콜백
  string node_id = event.getPublisherName();    //subcribe를 받았을 때 event의 publisher를 가져옴
  make_node_name(node_id);    //publisher에서 node_id 추출
  chat_client::select_msg::ConstPtr data = event.getConstMessage(); //메세지 추출
  string group = data -> group;   //메세지에서 group 정보 가져옴

  struct pub_struct& node_sess = session[node_id]; //세션에서 노드에 관한 정보 가져옴
  cout << node_id << " , " << node_sess.id << " select group : " << group << endl;  //어떤 노드가 어떤 id로 어떤 group 선택했는지 서버에 출력
  //서버에 node_id, id, group 정보 출력

  map<string, vector<string>>::iterator iter;     //id에 해당되는 group 벡터가 있는 지 확인하기 위한 이터레이터
  iter = group_info.find(node_sess.id);                 //id로 탐색
  //cout<<node_sess.id<< " "<<(iter==group_info.end())<<endl;
  string give_list_msg = "";

  if (iter != group_info.end()){   //있으면
    vector<string> temp = iter->second;     //id에 해당되는 group 벡터 가져옴
    vector<string>::iterator it = find(temp.begin(), temp.end(), group);  //그룹 벡터에서 선택한 group이 있는지 확인

    chat_client::response msg_temp; //msg_type

    if (it != temp.end()) {  //그룹 벡터에 있으면
      msg_temp.msg = "";   
      msg_temp.success = true;                //성공
      node_sess.group = group;                //세션에 그룹 정보 저장
    }
    else{       //없으면
      msg_temp.msg = "don't exist group";
      msg_temp.success = false;             //실패
    }
    cout<<"Send"<<endl;
    node_sess.select_response_pub.publish(msg_temp);  //publish
  }
}

void send_chat_Callback(const ros::MessageEvent<chat_client::send_chat_msg>& event){  //메세지를 보내는 걸 받았을 때 콜백
  string node_id = event.getPublisherName();    //subcribe를 받았을 때 event의 publisher를 가져옴
  make_node_name(node_id);    //publisher에서 node_id 추출
  chat_client::send_chat_msg::ConstPtr data = event.getConstMessage(); //메세지 추출
  string msg = data -> msg;   //메세지에서 msg 정보 가져옴
  struct pub_struct& node_sess = session[node_id]; //세션에서 노드에 관한 정보 가져옴

  cout << node_id << " , " << node_sess.id << " send msg : " << msg << " to " << node_sess.group << endl;
  //누가 어떤 아이디로 어느 그룹에 무엇을 보내는지 출력

  chat_client::spread_chat_msg msg_temp;    //msg_type
  msg_temp.id = node_sess.id;             //보내는 사람 id
  msg_temp.msg = msg;                     //보내는 사람의 메세지

  spread_chat_group[node_sess.group].publish(msg_temp);    //spread_chat_group으로 group에 publish
}

void exit_group_Callback(const ros::MessageEvent<std_msgs::Empty>& event){   //그룹 탈출을 받았을 때 콜백
  string node_id = event.getPublisherName();    //subcribe를 받았을 때 event의 publisher를 가져옴
  make_node_name(node_id);    //publisher에서 node_id 추출
  struct pub_struct& node_sess = session[node_id]; //세션에서 노드에 관한 정보 가져옴
  
  cout << node_id << " , " << node_sess.id << " exit : " << node_sess.group << endl;
  //노드와 id와 탈출할 group 출력

  chat_client::response msg_temp;   //msg type
  msg_temp.success = true;          //성공
  msg_temp.msg = "";

  node_sess.exit_response_pub.publish(msg_temp);    //탈출했다는 응답 publish
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

  vector<string> group_temp;        //group info 하드 코딩으로 저장 id에 group1 group2저장, id2에 group1저장
  group_temp.push_back("group1");
  group_temp.push_back("group2");
  group_info.insert(pair<string, vector<string>>("id", group_temp));
  group_temp.pop_back();
  group_info.insert(pair<string, vector<string>>("id2", group_temp));
  cout << login_info[0][0] << " " << login_info[0][1] << endl;

  for (map<string, vector<string>>::iterator iter = group_info.begin();     //저장되어 있는 모든 group들에게 미리 spread_chat publisher 배정
       iter != group_info.end(); iter++){   //모든 id의 그룹 확인 
        for (int i = 0; i < iter->second.size(); i++)   //해당 id의 그룹 벡터 크기 만큼
        {
          string group_temp = iter->second[i];    //해당 id의 i번째 그룹명 가져옴 
          map<string, ros::Publisher>::iterator iter2 = spread_chat_group.find(group_temp);     //그룹이 이미 있는지 확인
          if(iter2 == spread_chat_group.end()){               //처음이면 spread_chat_group에 저장
            string str_temp = "spread_chat/to_" + group_temp;
            ros::Publisher spread_chat_pub = n.advertise<chat_client::spread_chat_msg>(str_temp, 1000); //해당 group에 메세지를 뿌려주는 publisher 생성
            cout<<str_temp<<endl;   //토픽명 출력
            spread_chat_group.insert( pair<string, ros::Publisher>(group_temp, spread_chat_pub));   //spread_chat_group에 group, publisher 형태로 저장
          }
        }
  }


//서버의 기본 subscriber    -> 전부 chatter가 보냄
ros::Subscriber login_sub = n.subscribe("login/to_server", 1000, login_Callback);                      //로그인 토픽
ros::Subscriber want_list_sub = n.subscribe("want_list/to_server", 1000, want_list_Callback);          //그룹 리스트 요구하는 토픽
ros::Subscriber select_group_sub = n.subscribe("select_group/to_server", 1000, select_group_Callback); //그룹을 선택하는 토픽
ros::Subscriber exit_group_sub = n.subscribe("exit_group/to_server", 1000, exit_group_Callback);       //그룹을 탈출하는 걸 원하는 토픽
ros::Subscriber send_chat_sub = n.subscribe("send_chat/to_server", 1000, send_chat_Callback);          //채팅을 보내는 토픽

ros::Rate loop_rate(10);                                                                               //loop rate

ros::spin(); //spin

return 0;
}

void make_node_name(string& name){
  int point = name.find("_", 10);   //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
  name = name.substr(point + 1);
  
}