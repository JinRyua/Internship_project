#include "ros/ros.h"
#include "std_msgs/Empty.h"

//msg include

#include <sstream>
#include <iostream>
#include <fstream>
#include <string>
#include <stdlib.h>

using namespace std;

vector<string> split(string str, char delimiter); //문자열을 vector로 나누기 위한 함수

#include "rosplan_knowledge_msgs/GetInstanceService.h"
#include "rosplan_dispatch_msgs/ActionDispatch.h"
#include "rosplan_dispatch_msgs/ActionFeedback.h"
#include "new_Interface/action_feedback.h"
#include "new_Interface/order_msg.h"

map<string, ros::Publisher> agent_pub;
int matrix[7][7]={{0, 1, 1, 3, 2, 4, 5},
              {1, 0, 1, 2, 4, 4, 3},
              {1, 1, 0, 2, 3, 2, 5},
              {3, 2, 2, 0, 2, 3, 2},
              {2, 4, 3, 2, 0, 2, 1},
              {4, 4, 2, 3, 2, 0, 1},
              {5, 3, 5, 2, 1, 1, 0}};
map<string, int> key_place;

void write_launch(vector<string>& f, vector<string>& r);

void action_feedback_Callback(const new_Interface::action_feedback& msg){

}

void Dispatch_Callback(const rosplan_dispatch_msgs::ActionDispatch& msg){
  
  vector<diagnostic_msgs::KeyValue> temp = msg.parameters;
  vector<diagnostic_msgs::KeyValue>::iterator it;
  string node_name;
  for( it = temp.begin(); it != temp.end(); it++){
    if(it->key == "x" || it->key == "c"){
      node_name = it->value;
      cout<<node_name<<endl;
      break;
    }
  }

  agent_pub[node_name].publish(msg);
  
}

int main(int argc, char **argv){
  ros::init(argc, argv, "agent_manager");
  ros::NodeHandle n; //node handler

  std::string kb; //= "knowledge_base";
	n.getParam("knowledge_base", kb);

		std::stringstream ss;
		ss << "/rosplan_knowledge_base/state/instances";
		ros::service::waitForService(ss.str(),ros::Duration(20));
		ros::ServiceClient client = n.serviceClient<rosplan_knowledge_msgs::GetInstanceService>(ss.str());
		rosplan_knowledge_msgs::GetInstanceService srv;
		srv.request.type_name = "firecar";
		std::vector<std::string> firecarIns;
		if(client.call(srv)) {
			firecarIns = srv.response.instances;
		} else {
			ROS_ERROR("KCL: (RPActionInterface) could not call Knowledge Base for instances, firecar");
			return 0;
		}

		std::vector<std::string> resqueIns;
    srv.request.type_name = "resque";
    if(client.call(srv)) {
			resqueIns = srv.response.instances;
		} else {
			ROS_ERROR("KCL: (RPActionInterface) could not call Knowledge Base for instances, resque");
			return 0;
		}

    write_launch(firecarIns, resqueIns);
    //system("roslaunch /home/jylee/ROSPlan/node.launch");
    
    //server에 관한 publisher
  ros::Publisher dispatch_feedback = n.advertise<rosplan_dispatch_msgs::ActionFeedback>("/rosplan_plan_dispatcher/action_feedback", 1000);                  

  ros::Subscriber dispatch_action = n.subscribe("/rosplan_plan_dispatcher/action_dispatch", 1000, Dispatch_Callback); //get_input/to_node_id 키보드 입력을 받는 sub
  
  ros::Subscriber feedback_order = n.subscribe("/agent_manager/feedback_order",1000, Dispatch_Callback);
  
  firecarIns.insert( firecarIns.end(), resqueIns.begin(), resqueIns.end() );

 
  for(int i=0; i<firecarIns.size(); i++){
    ros::Publisher temp_pub = n.advertise<rosplan_dispatch_msgs::ActionDispatch>("/agent_manager/order/to_"+firecarIns[i], 1000);
    cout<<"/agent_manager/order/to_"<<firecarIns[i]<<endl;
    agent_pub.insert( pair<string, ros::Publisher>{ firecarIns[i], temp_pub} );
  }

  key_place.insert( pair< string, int >{"fst1", 0});
  key_place.insert( pair< string, int >{"hos1", 1});
  key_place.insert( pair< string, int >{"acc1", 2});
  key_place.insert( pair< string, int >{"acc2", 3});
  key_place.insert( pair< string, int >{"acc3", 4});
  key_place.insert( pair< string, int >{"fst2", 5});
  key_place.insert( pair< string, int >{"hos2", 6});

  ROS_INFO("%d",agent_pub.size());
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

void write_launch(vector<string>& f, vector<string>& r){
  ofstream wf;
  wf.open("/home/jylee/ROSPlan/node.launch");
  if(wf.is_open()){
    wf<<"<?xml version=\"1.0\"?>"<<endl<<"<launch>"<<endl;

    for(int i=0;i<f.size();i++){

      wf<<"<node name=\""<<f[i]<<"\" pkg=\"new_Interface\" type=\"car_interface\" respawn=\"false\" output=\"screen\">"<<endl;
      wf<<"</node>"<<endl;
    }
    for(int i=0;i<r.size();i++){

      wf<<"<node name=\""<<r[i]<<"\" pkg=\"new_Interface\" type=\"car_interface\" respawn=\"false\" output=\"screen\">"<<endl;
      wf<<"</node>"<<endl;
    }

    wf<<"</launch>"; 
    wf.close();
  }

    
}