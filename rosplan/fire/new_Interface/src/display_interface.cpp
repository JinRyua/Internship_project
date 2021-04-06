#include "ros/ros.h"
#include "std_msgs/Empty.h"

//msg include

#include <sstream>
#include <iostream>
#include <string>
#include <chrono>

using namespace std;

#include "rosplan_knowledge_msgs/GetInstanceService.h"
#include "rosplan_knowledge_msgs/GetDomainTypeService.h"

#include "new_Interface/matrix.h"
#include "new_Interface/GetInstanceMatrixService.h"
#include "new_Interface/display_msg.h"

ros::Publisher display_feedback;
ros::ServiceClient get_instance_matrix_client;

double act_time = 1;

struct inst{
  double x = 0;
  double y = 0;
  bool state = false;  
  char shape;
};
map<string, struct inst> Instances;
vector<string> InstName;

void make_node_name(string&);
void display();
void initInst();

void display_callback(const ros::MessageEvent<new_Interface::display_msg>& msg){
  string node_id = msg.getPublisherName();    //subcribe를 받았을 때 event의 publisher를 가져옴
  make_node_name(node_id);
  new_Interface::display_msg::ConstPtr data = msg.getConstMessage();
  Instances[node_id].x = data -> mat.x;
  Instances[node_id].y = data -> mat.y;
  Instances[node_id].state = data -> state;
}


int main(int argc, char **argv){
  ros::init(argc, argv, "display_interface");
  ros::NodeHandle n("~"); //node handler
  ros::Subscriber display_feedback = n.subscribe("/car/display", 1000, display_callback);



  initInst();
  while (1){

    sleep(0);
    double start_time = chrono::duration_cast<chrono::nanoseconds>(chrono::system_clock::now().time_since_epoch()).count();
    ros::spinOnce();

    display();

    double finish_time = chrono::duration_cast<chrono::nanoseconds>(chrono::system_clock::now().time_since_epoch()).count();
    double rate = (double)(act_time * 1000000000 - (finish_time - start_time)) / 1000000000;
    if (rate > 0){
      ros::Rate wait = 1 / rate;
      wait.sleep();
    }

    
  }
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

void initInst(){
  ros::NodeHandle nh("~");
  string kb = "rosplan_knowledge_base";
  nh.getParam("knowledge_base", kb);

  // fetch action params
  std::stringstream ss;

  ss << "/" << kb << "/domain/types";
  ros::service::waitForService(ss.str(), ros::Duration(20));
  ros::ServiceClient type_client = nh.serviceClient<rosplan_knowledge_msgs::GetDomainTypeService>(ss.str());
  rosplan_knowledge_msgs::GetDomainTypeService srv_temp;
  std::vector<string> typeNames;
  if (type_client.call(srv_temp)){
    typeNames = srv_temp.response.types;
  }
  else{
    ROS_ERROR("KCL: (ActionInterface) could not call Knowledge Base for types");
    return;
  }

  ss.str("");
  ss << "/" << kb << "/state/instances";
  ros::service::waitForService(ss.str(), ros::Duration(20));
  ros::ServiceClient inst_client = nh.serviceClient<rosplan_knowledge_msgs::GetInstanceService>(ss.str());
  rosplan_knowledge_msgs::GetInstanceService inst_temp;
  for(int i = 0 ;i < typeNames.size(); i++){
    if(typeNames[i] == "route") continue;
    inst_temp.request.type_name = typeNames[i];
    if (inst_client.call(inst_temp)){
      vector<string> temp_vec;
      temp_vec.clear();
      temp_vec = inst_temp.response.instances;
      for(int j = 0; j < temp_vec.size(); j++){
        InstName.push_back(temp_vec[j]);
        struct inst temp;
        if(typeNames[i] == "firecar"){ temp.shape = 'f';}
        else if(typeNames[i] == "firest"){ temp.shape = 'F';}
        else if(typeNames[i] == "resque"){ temp.shape = 'r';}
        else if(typeNames[i] == "hosp"){ temp.shape = 'H';}
        else if(typeNames[i] == "accident"){ temp.shape = 'A';}
        Instances.insert( pair<string, struct inst>( temp_vec[j], temp));
      }
    }
    else{
      ROS_ERROR("KCL: (ActionInterface) could not call Knowledge Base for instances");
      return;
    }
  }

  ss.str("");
  ss << "/agent_manager/Get_Instance_Matrix";
  ros::service::waitForService(ss.str(), ros::Duration(20));
  ros::ServiceClient get_instance_matrix_client = nh.serviceClient<new_Interface::GetInstanceMatrixService>(ss.str());
  new_Interface::GetInstanceMatrixService get_srv_temp;
  for (int i = 0; i < InstName.size(); i++){
    cout<<InstName[i]<<endl;
    get_srv_temp.request.instance_name = InstName[i];
    if (get_instance_matrix_client.call(get_srv_temp)){
      Instances[InstName[i]].x = get_srv_temp.response.point.x;
      Instances[InstName[i]].y = get_srv_temp.response.point.y;
      Instances[InstName[i]].state = false;
      // if()
      // Instances.insert( pair<string, struct inst>( InstName[i], temp));
    }
    else{
      ROS_ERROR("KCL: (ActionInterface) could not call Agent Manager Get Instance");
      return;
    }
  }
}

void make_node_name(string& name){
  int point = name.find("/", 10);   //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
  name = name.substr(point + 2);
}

void display(){
  //system("clear");
  //cout << "\x1B[2J\x1B[H";
  
  string screen = "";
  for(int i = 0 ; i < 38; i++){
    for(int j = 0 ; j < 100 ;j++){
      screen += " ";
    }
    screen += "\n";
  }

  for( map<string, struct inst>::iterator it = Instances.begin();
      it != Instances.end(); it++){
        string shape;
        if(it->second.state==false)
         screen[ it->second.y*101 + it->second.x]= it->second.shape;
        // cout<<"\033["<<(int)it->second.y<<"d\033["<<(int)it->second.x<<"G";
        // cout<<"F";
      }
//  cout<<'\033[3J';
  //cout<<"\033c";
  cout<<screen;
  //cout<<"\033[0"<<"d\033[0"<<"G";
}