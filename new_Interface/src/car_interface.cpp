#include "ros/ros.h"
#include "std_msgs/Empty.h"

//msg include

#include <sstream>
#include <iostream>
#include <string>
#include <chrono>

using namespace std;

string node_id; //자신의 이름

ros::NodeHandle* nn;  //전역 nodehandler

ros::Publisher give_matrix;

ros::Subscriber chat_sub; //spread_chat subscriber

vector<string> split(string str, char delimiter); //문자열을 vector로 나누기 위한 함수

#include "rosplan_knowledge_msgs/GetInstanceService.h"

#include "rosplan_dispatch_msgs/ActionDispatch.h"
#include "rosplan_dispatch_msgs/ActionFeedback.h"
#include "new_Interface/order_msg.h"
#include "new_Interface/order_feedback.h"
#include "new_Interface/matrix.h"
#include "new_Interface/GetInstanceMatrixService.h"
#include "new_Interface/display_msg.h"

ros::Publisher order_feedback;
ros::ServiceClient get_instance_matrix_client;

#define IDLE 0
#define MOVING 1
#define EXTINGUISH 2
#define EXTINGUISH_FINISH 3
#define RESQUE 4
#define PUT_HUMAN 5



double x = 0;
double y = 0;
double xx, yy;
double past_x = 0;
double past_y = 0;
double per_hour = 2;
double act_time = 0.023;
double twinkle_time = 0;
bool end_action = false;
int agent_state = 0;
int light_count = 0;
bool state = false;

void start_agent();
void moving(double);
void extinguish(double);
void extinguish_finish(double);
void resque(double);
void put_human(double);

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
  
  if(msg.name == "move"){ agent_state = MOVING;}
  else if(msg.name == "extinguish"){ agent_state = EXTINGUISH;}
  else if(msg.name == "extinguish_finish"){ agent_state = EXTINGUISH_FINISH;}
  else if(msg.name == "resque_human"){ agent_state = RESQUE;}
  else if(msg.name == "put_human"){ agent_state = PUT_HUMAN;}

  if(msg.name != "move"){
    twinkle_time = 0;
    light_count = 0;
  }
  else{
    xx = msg.x + 1;
    yy = msg.y;
    past_x = x;
    past_y = y;
  }
}

int main(int argc, char **argv){
  ros::init(argc, argv, "car_interface");
  ros::NodeHandle n("~"); //node handler

  std::string str_time= "manager_start_time";
  std::string temp_time;
	n.getParam(str_time, temp_time);
  temp_time.pop_back();
  manager_start_time = stol(temp_time);
  n.getParam("velocity", per_hour);

  node_id = ros::this_node::getName(); //자신의 노드 이름 확인
  int point = node_id.find("/", 10);   //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
  node_id = node_id.substr(point + 2);  //노드 이름 저장

  get_instance_matrix_client = n.serviceClient<new_Interface::GetInstanceMatrixService>("/agent_manager/Get_Instance_Matrix");
  new_Interface::GetInstanceMatrixService srv;
	srv.request.instance_name = node_id;
	if(get_instance_matrix_client.call(srv)) {
    x = srv.response.point.x;
    y = srv.response.point.y;
	} else {
		ROS_ERROR("KCL: (RPActionInterface) could not call Agent_manager_Instance_Service");
		return 0;
	}

  give_matrix = n.advertise<new_Interface::display_msg>("/car/display",1000);

  order_feedback = n.advertise<new_Interface::order_feedback>("/agent_manager/feedback_order", 1000);                  

  ros::Subscriber order_action = n.subscribe("/agent_manager/order/to_"+node_id, 1000, order_Callback); //get_input/to_node_id 키보드 입력을 받는 sub

  print_log("init", "ready for start");

  per_hour=per_hour;

  start_agent();
  
  

  //ros::spin();
		
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
      
void start_agent(){

  int i=0;
  twinkle_time = 0;

  double duration = 0.023;

  while(1){
    ros::spinOnce();
    sleep(0);
    if(agent_state == IDLE){ continue;}

    double start_time = chrono::duration_cast<chrono::nanoseconds>(chrono::system_clock::now().time_since_epoch()).count();
  
    if(agent_state == MOVING) { moving(duration); }
    else if(agent_state == EXTINGUISH){ extinguish(duration);}
    else if(agent_state == EXTINGUISH_FINISH){ extinguish_finish(duration);}
    else if(agent_state == RESQUE){ resque(duration);}
    else if(agent_state == PUT_HUMAN){ put_human(duration);}

    twinkle_time += act_time;
    if (end_action == true)
      state = false;

    new_Interface::display_msg msgg;
   
    msgg.mat.x = x;
    msgg.mat.y = y;
    msgg.state = state;
    give_matrix.publish(msgg);
    //ros::spinOnce();

    if (end_action == true){
      new_Interface::order_feedback msg_temp;
      msg_temp.status = "action achieved";
      order_feedback.publish(msg_temp);
      //ros::spinOnce();
      agent_state = IDLE;
      end_action = false;
      print_log("order_feedback", "publish to manager : " + msg_temp.status);
    }

    
    ros::spinOnce();

    double finish_time = chrono::duration_cast<chrono::nanoseconds>(chrono::system_clock::now().time_since_epoch()).count();
    double rate = (double)(act_time * 1000000000 - (finish_time - start_time)) / 1000000000;
    if (rate > 0){
      ros::Rate wait = 1 / rate;
      wait.sleep();
    }

    double next_time = chrono::duration_cast<chrono::nanoseconds>(chrono::system_clock::now().time_since_epoch()).count();
    duration = (next_time - start_time)/1000000000;
  }
}

void moving(double duration){

  double dis_x;
  double dis_y;
  double distance;
  dis_x = xx - past_x;
  dis_y = yy - past_y;
  double start_time = chrono::duration_cast<chrono::nanoseconds>(chrono::system_clock::now().time_since_epoch()).count();
  //cout <<std::setprecision(9)<<start_time/1000000000<<endl;
  //위치 계산
  distance = sqrt( pow((dis_x), 2) + pow((dis_y), 2) ); //거리
  double mount_x = dis_x / distance; //이동 거리 1당 변하는 x 크기
  double mount_y = dis_y / distance; //이동 거리 1당 변하는 y 크기

  mount_x = (mount_x * per_hour * duration) + x;
  mount_y = (mount_y * per_hour * duration) + y;
  if ((xx - mount_x) * (xx - x) < 0)
    x = xx;
  else
    x = mount_x;
  if ((yy - mount_y) * (yy - y) < 0)
    y = yy;
  else
    y = mount_y;
  if (x == xx && y == yy){
    end_action = true;
  }
  // ros::Rate wait = 1 / (double)3.0;
  // wait.sleep();
  return;
  //cout<< x<< " "<<y<<endl;
}

void extinguish(double duration){
  if( twinkle_time >= 1){
    state = !state;
    twinkle_time = 0;
    light_count++;
  }
  if( light_count >= 10)
    end_action = true;

  return;
}

void extinguish_finish(double duration){
  return extinguish(duration);
}
void resque(double duration){
  return extinguish(duration);
}
void put_human(double duration){
  return extinguish(duration);
}