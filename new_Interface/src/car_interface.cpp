#include "ros/ros.h"
#include "std_msgs/Empty.h"

//msg include

#include <sstream>
#include <iostream>
#include <string>
#include <chrono>

using namespace std;

string node_id; //자신의 이름
string id;   //자신의 id;
string group; //이 노드의 group
string buffer="";   //buffer(입력)

ros::NodeHandle* nn;  //전역 nodehandler

ros::Publisher login_pub;         //로그인을 하는 토픽
ros::Publisher select_group_pub;  //그룹을 선택하는 토픽
ros::Publisher want_list_pub;     //그룹 리스트를 요구하는 토픽
ros::Publisher exit_group_pub;    //그룹을 탈출하는 토픽
ros::Publisher send_chat_pub;     //메세지를 보내는 토픽
ros::Publisher give_matrix;

ros::Subscriber chat_sub; //spread_chat subscriber

vector<string> split(string str, char delimiter); //문자열을 vector로 나누기 위한 함수

#include "rosplan_knowledge_msgs/GetInstanceService.h"

#include "rosplan_dispatch_msgs/ActionDispatch.h"
#include "rosplan_dispatch_msgs/ActionFeedback.h"
#include "new_Interface/order_msg.h"
#include "new_Interface/order_feedback.h"

ros::Publisher order_feedback;
double x = 0;
double y = 0;
double per_hour = 2;
double act_time = 0.023;
bool state = false;
      

chrono::milliseconds::rep manager_start_time;
double time(){
	auto time = chrono::duration_cast<chrono::milliseconds>(chrono::system_clock::now().time_since_epoch()).count() - manager_start_time;
	return (double)time/1000;
}
void print_log(string func,string str){
	cout<< "[";
	cout.width(9);cout.fill(' ');cout<<fixed;cout.precision(3);
	cout<<time()<<"][";
	cout.width(13);cout.fill(' ');
	cout<<node_id<<"][";
	cout.width(17);cout.fill(' ');
	cout<<func<<"] ( "<<str<<" )"<<endl;
}

void order_Callback(const new_Interface::order_msg& msg){
  new_Interface::order_feedback msg_temp;
  msg_temp.status = "action enabled";
  order_feedback.publish(msg_temp);
  print_log("order_callback","subscribe from manager : " + msg_temp.status + " and start action");
  
  double xx, yy;
  double dis_x;
  double dis_y;
  double distance;
  int i=0;
  if(msg.name == "move"){
    
    xx= msg.x;
    yy= msg.y;
    dis_x = xx - x;
    dis_y = yy - y;
    distance = sqrt( pow((xx - x), 2) / pow((yy - y), 2) ) / 1; //거리
  }
  while(1){
    if(msg.name == "move"){
      double start_time = chrono::duration_cast<chrono::nanoseconds>(chrono::system_clock::now().time_since_epoch()).count();
      cout <<std::setprecision(9)<<start_time/1000000000<<endl;
        //위치 계산

      double mount_x = dis_x / distance; //거리 1당 변하는 x 크기
      double mount_y = dis_y / distance; //거리 1당 변하는 y 크기
      mount_x = (mount_x * per_hour * act_time) + x;
      mount_y = (mount_y * per_hour * act_time) + y;
      cout<<x<<" "<<mount_x<<" "<<y<<" "<<mount_y<<" "<<endl;
      if( (xx - mount_x) * (xx - x) < 0)
        x = xx;
      else
        x = mount_x;
      if( (yy - mount_y) * (yy - y) < 0)
        y = yy;
      else
        y = mount_y;
    
      
      print_log("matrix", to_string(x)+", "+to_string(y));
    
      double finish_time = chrono::duration_cast<chrono::nanoseconds>(chrono::system_clock::now().time_since_epoch()).count();
      double rate = (double)(act_time * 1000000000 - (finish_time - start_time)) / 1000000000;
      cout<<rate<<endl;
      if(rate > 0){
        ros::Rate wait = 1 / rate;
        wait.sleep();
        act_time = 0.023;
      }
      else{
        cout<<act_time<<" "<<rate<<endl;
        act_time = rate;
      }
      std_msgs::Empty msgg;
      give_matrix.publish(msgg);
      cout<<act_time<<endl;
      cout<<x<<" "<<y<<endl;
      if( x == xx && y == yy){
        break;
      }
    }
    else{
      double start_time = chrono::duration_cast<chrono::nanoseconds>(chrono::system_clock::now().time_since_epoch()).count();
      state = !state;
      i++;
      double finish_time = chrono::duration_cast<chrono::nanoseconds>(chrono::system_clock::now().time_since_epoch()).count();
      double rate = (double)(0.5 * 1000000000 - (finish_time - start_time)) / 1000000000;
      if(rate > 0){
        ros::Rate wait = 1 / rate;
        wait.sleep();
      }
      std_msgs::Empty msgg;
      give_matrix.publish(msgg);
      if(i>10)
        break;
    }
  }
  state = false;
   std_msgs::Empty msgg;
  give_matrix.publish(msgg);

  msg_temp.status = "action achieved";
  order_feedback.publish(msg_temp);
  print_log("order_feedback", "publish to manager : " + msg_temp.status);
}


int main(int argc, char **argv){
  ros::init(argc, argv, "car_interface");
  ros::NodeHandle n("~"); //node handler

  std::string str_time= "manager_start_time";
  std::string temp_time;
	n.getParam(str_time, temp_time);
  temp_time.pop_back();
  manager_start_time = stol(temp_time);

  node_id = ros::this_node::getName(); //자신의 노드 이름 확인
  int point = node_id.find("/", 10);   //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
  node_id = node_id.substr(point + 2);  //노드 이름 저장

  give_matrix = n.advertise<std_msgs::Empty>("/car/display",1000);

  order_feedback = n.advertise<new_Interface::order_feedback>("/agent_manager/feedback_order", 1000);                  

  ros::Subscriber order_action = n.subscribe("/agent_manager/order/to_"+node_id, 1000, order_Callback); //get_input/to_node_id 키보드 입력을 받는 sub

  print_log("init", "ready for start");
  
 

  ros::spin();
		
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