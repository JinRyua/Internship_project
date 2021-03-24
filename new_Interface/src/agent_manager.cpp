#include "ros/ros.h"
#include "std_msgs/Empty.h"
#include "std_msgs/Int32.h"

//msg include

#include <sstream>
#include <iostream>
#include <fstream>
#include <string>
#include <stdlib.h>
#include <unistd.h>

using namespace std;


#include "rosplan_dispatch_msgs/ActionFeedback.h"
#include "rosplan_dispatch_msgs/ActionDispatch.h"
#include "rosplan_knowledge_msgs/DomainFormula.h"
#include "rosplan_knowledge_msgs/KnowledgeItem.h"
#include "rosplan_knowledge_msgs/KnowledgeUpdateService.h"
#include "rosplan_knowledge_msgs/KnowledgeUpdateServiceArray.h"
#include "rosplan_knowledge_msgs/GetDomainOperatorDetailsService.h"
#include "rosplan_knowledge_msgs/GetDomainOperatorService.h"
#include "rosplan_knowledge_msgs/GetDomainPredicateDetailsService.h"
#include "diagnostic_msgs/KeyValue.h"
#include "rosplan_knowledge_msgs/GetInstanceService.h"
#include "new_Interface/order_msg.h"
#include "new_Interface/order_feedback.h"

vector<string> split(string str, char delimiter); //문자열을 vector로 나누기 위한 함수

ros::Publisher dispatch_feedback;
ros::ServiceClient update_knowledge_client;

struct oper_info{
	std::map<std::string, rosplan_knowledge_msgs::DomainFormula> predicates;
	std::map<std::string, rosplan_knowledge_msgs::DomainFormula> sensed_predicates;

		/* PDDL info and publisher */
	rosplan_knowledge_msgs::DomainFormula params;
	rosplan_knowledge_msgs::DomainOperator op;
};

map<string, ros::Publisher> agent_pub;
map<string, rosplan_dispatch_msgs::ActionDispatch> agent_action;
std::map<std::string, struct oper_info> operator_info;

int matrix[7][7]={{0, 1, 1, 3, 2, 4, 5},
              {1, 0, 1, 2, 4, 4, 3},
              {1, 1, 0, 2, 3, 2, 5},
              {3, 2, 2, 0, 2, 3, 2},
              {2, 4, 3, 2, 0, 2, 1},
              {4, 4, 2, 3, 2, 0, 1},
              {5, 3, 5, 2, 1, 1, 0}};
map<string, int> key_place;

void write_launch(vector<string>& f);
void make_node_name(string&);  //publisher_name에서 node_id를 추출
void init_oper();
void update_start(string);
void update_end(string);





void order_feedback_Callback(const ros::MessageEvent<new_Interface::order_feedback>& msg){
  string node_id = msg.getPublisherName();    //subcribe를 받았을 때 event의 publisher를 가져옴
  make_node_name(node_id);    //publisher에서 node_id 추출

  new_Interface::order_feedback::ConstPtr data = msg.getConstMessage(); //login_msg 데이터 가져옴
  rosplan_dispatch_msgs::ActionFeedback temp;
  temp.action_id = agent_action[node_id].action_id;
  temp.status = data -> status;

  if(temp.status == "action achieved"){
    update_end(node_id);
    ROS_INFO("KCL: agent_manager update_knowledge at end");
    dispatch_feedback.publish(temp);
    ROS_INFO("KCL: agent_manager publish achieved");
  }
  else if(temp.status == "action enabled"){
    dispatch_feedback.publish(temp);
    ros::spinOnce();
    ROS_INFO("KCL: agent_manager publish enabled");
    update_start(node_id);
    ROS_INFO("KCL: agent_manager update_knowledge at start");
  }
}

void Dispatch_Callback(const rosplan_dispatch_msgs::ActionDispatch& msg){
  
  vector<diagnostic_msgs::KeyValue> temp = msg.parameters;
  vector<diagnostic_msgs::KeyValue>::iterator it;
  if(msg.name == "cancel_action") {
      return;
  }
  string node_name;
  for( it = temp.begin(); it != temp.end(); it++){
    if(it->key == "x" || it->key == "c"){
      node_name = it->value;
      cout<<node_name<<endl;
      break;
    }
  }
  agent_action[node_name] = msg;
  new_Interface::order_msg msg_temp;
  if(msg.name == "move"){
    string from, to;
    for( it = temp.begin(); it != temp.end(); it++){
      if(it->key == "from")
        from = it->value;
      if(it->key == "to")
        to = it->value;
    }
    msg_temp.duration = matrix[ key_place[from] ][ key_place[to] ];
  }
  else
    msg_temp.duration = msg.duration;
  cout<<node_name<<" published"<<endl;
  agent_pub[node_name].publish(msg_temp);

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

    
    //server에 관한 publisher
  dispatch_feedback = n.advertise<rosplan_dispatch_msgs::ActionFeedback>("/rosplan_plan_dispatcher/action_feedback", 1000);                  

  ros::Subscriber dispatch_action = n.subscribe("/rosplan_plan_dispatcher/action_dispatch", 1000, Dispatch_Callback); //get_input/to_node_id 키보드 입력을 받는 sub
  
  ros::Subscriber feedback_order = n.subscribe("/agent_manager/feedback_order",1000, order_feedback_Callback);
  
  firecarIns.insert( firecarIns.end(), resqueIns.begin(), resqueIns.end() );

 
  for(int i=0; i<firecarIns.size(); i++){
    ros::Publisher temp_pub = n.advertise<new_Interface::order_msg>("/agent_manager/order/to_"+firecarIns[i], 1000);
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

  init_oper();

  ROS_INFO("%d",agent_pub.size());

  write_launch(firecarIns);
  //execlp("roslaunch","roslaunch","/home/jylee/ROSPlan/node.launch",NULL);
  system("roslaunch /home/jylee/ROSPlan/node.launch &");
  //ShellExecute(NULL,"roslaunch","/home/jylee/ROSPlan/node.launch &");
  cout<<"hi"<<endl;

  ros::Rate loopRate(1);
	ros::AsyncSpinner spinner(4);
  spinner.start();
  ros::waitForShutdown();

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

void write_launch(vector<string>& f){
  ofstream wf;
  wf.open("/home/jylee/ROSPlan/node.launch");
  if(wf.is_open()){
    wf<<"<?xml version=\"1.0\"?>"<<endl<<"<launch>"<<endl;

    wf<<"<!-- arguments -->"<<endl;
    wf<<"<arg name=\"pddl_action_name\" />"<<endl
	    <<"<arg name=\"action_duration\"		default=\"-1.0\" />"<<endl
      <<"<arg name=\"action_duration_stddev\"		default=\"0.0\" />"<<endl
      <<"<arg name=\"action_probability\"	default=\"1.0\" />"<<endl
    	<<"<arg name=\"knowledge_base\"		default=\"rosplan_knowledge_base\" />"<<endl
	    <<"<arg name=\"action_dispatch_topic\"	default=\"/rosplan_plan_dispatcher/action_dispatch\" />"<<endl
	    <<"<arg name=\"order_feedback_topic\"	default=\"/rosplan_plan_dispatcher/order_feedback\" />"<<endl;
    for(int i=0;i<f.size();i++){

      wf<<"<node name=\""<<f[i]<<"\" pkg=\"new_Interface\" type=\"car_interface\" respawn=\"false\" output=\"screen\">"<<endl;
      wf<<"<param name=\"knowledge_base\"		 value=\"$(arg knowledge_base)\" />"<<endl
		    <<"<param name=\"action_duration\"		 value=\"$(arg action_duration)\" />"<<endl
		    <<"<param name=\"action_duration_stddev\" value=\"$(arg action_duration_stddev)\" />"<<endl
		    <<"<param name=\"action_probability\"	 value=\"$(arg action_probability)\" />"<<endl;
		    wf<<"</node>"<<endl;
    }
    
    wf<<"</launch>"; 
    wf.close();
  }
}

void init_oper(){
    ros::NodeHandle nh("~");
    std::string kb = "knowledge_base";
		nh.getParam("knowledge_base", kb);

		// fetch action params
		std::stringstream ss;


		ss << "/" << kb << "/domain/operators";
		ros::service::waitForService(ss.str(),ros::Duration(20));
		ros::ServiceClient oper_client = nh.serviceClient<rosplan_knowledge_msgs::GetDomainOperatorService>(ss.str());
		rosplan_knowledge_msgs::GetDomainOperatorService srv_temp;
    std::vector<rosplan_knowledge_msgs::DomainFormula> opNames;
		if(oper_client.call(srv_temp)) {
			opNames = srv_temp.response.operators;
		} else {
			ROS_ERROR("KCL: (ActionInterface) could not call Knowledge Base for operators");
			return;
		}
		
		for(int i = 0; i < opNames.size(); i++){
			//std::cout<<opNames[i].name<<std::endl;
			ss.str("");
			ss << "/" << kb << "/domain/operator_details";
			ros::service::waitForService(ss.str(),ros::Duration(20));
			ros::ServiceClient client = nh.serviceClient<rosplan_knowledge_msgs::GetDomainOperatorDetailsService>(ss.str());
			rosplan_knowledge_msgs::GetDomainOperatorDetailsService srv;
      rosplan_knowledge_msgs::DomainFormula params;
    	rosplan_knowledge_msgs::DomainOperator op;
			srv.request.name = opNames[i].name;
			if(client.call(srv)) {
				params = srv.response.op.formula;
				op = srv.response.op;
			} else {
				ROS_ERROR("KCL: (ActionInterface) could not call Knowledge Base for operator details, %s", opNames[i].name);
				return;
			}		

		// collect predicates from operator description
			std::vector<std::string> predicateNames;

		// effects
			std::vector<rosplan_knowledge_msgs::DomainFormula>::iterator pit = op.at_start_add_effects.begin();
			for(; pit!=op.at_start_add_effects.end(); pit++)
				predicateNames.push_back(pit->name);

			pit = op.at_start_del_effects.begin();
			for(; pit!=op.at_start_del_effects.end(); pit++)
			predicateNames.push_back(pit->name);

			pit = op.at_end_add_effects.begin();
			for(; pit!=op.at_end_add_effects.end(); pit++)
				predicateNames.push_back(pit->name);

			pit = op.at_end_del_effects.begin();
			for(; pit!=op.at_end_del_effects.end(); pit++)
				predicateNames.push_back(pit->name);		

		// simple conditions
			pit = op.at_start_simple_condition.begin();
			for(; pit!=op.at_start_simple_condition.end(); pit++)
				predicateNames.push_back(pit->name);

			pit = op.over_all_simple_condition.begin();
			for(; pit!=op.over_all_simple_condition.end(); pit++)
				predicateNames.push_back(pit->name);

			pit = op.at_end_simple_condition.begin();
			for(; pit!=op.at_end_simple_condition.end(); pit++)
				predicateNames.push_back(pit->name);

		// negative conditions
			pit = op.at_start_neg_condition.begin();
			for(; pit!=op.at_start_neg_condition.end(); pit++)
				predicateNames.push_back(pit->name);

			pit = op.over_all_neg_condition.begin();
			for(; pit!=op.over_all_neg_condition.end(); pit++)
				predicateNames.push_back(pit->name);

			pit = op.at_end_neg_condition.begin();
			for(; pit!=op.at_end_neg_condition.end(); pit++)
				predicateNames.push_back(pit->name);

		// fetch and store predicate details
			ss.str("");
			ss << "/" << kb << "/domain/predicate_details";
			ros::service::waitForService(ss.str(),ros::Duration(20));
			ros::ServiceClient predClient = nh.serviceClient<rosplan_knowledge_msgs::GetDomainPredicateDetailsService>(ss.str());
      std::map<std::string, rosplan_knowledge_msgs::DomainFormula> predicates;
		  std::map<std::string, rosplan_knowledge_msgs::DomainFormula> sensed_predicates;
			std::vector<std::string>::iterator nit = predicateNames.begin();
			for(; nit!=predicateNames.end(); nit++) {
				if (predicates.find(*nit) != predicates.end()) continue;
				if (*nit == "=" || *nit == ">" || *nit == "<" || *nit == ">=" || *nit == "<=") continue;
				rosplan_knowledge_msgs::GetDomainPredicateDetailsService predSrv;	
				predSrv.request.name = *nit;
				if(predClient.call(predSrv)) {
					if (predSrv.response.is_sensed){
						sensed_predicates.insert(std::pair<std::string, rosplan_knowledge_msgs::DomainFormula>(*nit, predSrv.response.predicate));	
					} else {
						predicates.insert(std::pair<std::string, rosplan_knowledge_msgs::DomainFormula>(*nit, predSrv.response.predicate));	
					}
				} else {
					ROS_ERROR("KCL: (ActionInterface) could not call Knowledge Base for predicate details, %s", params.name.c_str());
					return;
				}
			}
      
      ss.str("");
		  ss << "/" << kb << "/update_array";
		  update_knowledge_client = nh.serviceClient<rosplan_knowledge_msgs::KnowledgeUpdateServiceArray>(ss.str());

			struct oper_info temp;
			temp.predicates = predicates;
			temp.sensed_predicates = sensed_predicates;
			temp.params = params;
			temp.op = op;
			operator_info.insert( std::pair<std::string, struct oper_info>( opNames[i].name, temp ));
			predicates.clear();
			sensed_predicates.clear();
    }
}

void update_start(string node_id){
  std::string name = agent_action[node_id].name;
	std::map<std::string, rosplan_knowledge_msgs::DomainFormula> predicates = operator_info[name].predicates;
	std::map<std::string, rosplan_knowledge_msgs::DomainFormula> sensed_predicates = operator_info[name].sensed_predicates;

	rosplan_knowledge_msgs::DomainFormula params = operator_info[name].params;
	rosplan_knowledge_msgs::DomainOperator op = operator_info[name].op;

  std::vector<diagnostic_msgs::KeyValue> parameters = agent_action[node_id].parameters;

  std::vector<bool> found(params.typed_parameters.size(), false);
	std::map<std::string, std::string> boundParameters;
	for(size_t j=0; j<params.typed_parameters.size(); j++) {
		for(size_t i=0; i<parameters.size(); i++) {
			if(params.typed_parameters[j].key == parameters[i].key) {
				boundParameters[parameters[i].key] = parameters[i].value;
				found[j] = true;
				break;
			}
		}
		if(!found[j]) {
			ROS_INFO("KCL: (%s) aborting action dispatch; malformed parameters, missing %s", params.name.c_str(), params.typed_parameters[j].key.c_str());
			return;
		}
	}

  rosplan_knowledge_msgs::KnowledgeUpdateServiceArray updatePredSrv;

	// simple START del effects
  for(int i=0; i<op.at_start_del_effects.size(); i++) {

	  std::map<std::string, rosplan_knowledge_msgs::DomainFormula>::iterator it = sensed_predicates.find(op.at_start_del_effects[i].name);
	  if(it != sensed_predicates.end()) continue; // sensed predicate

	  rosplan_knowledge_msgs::KnowledgeItem item;
	  item.knowledge_type = rosplan_knowledge_msgs::KnowledgeItem::FACT;
	  item.attribute_name = op.at_start_del_effects[i].name;
	  item.values.clear();
	  diagnostic_msgs::KeyValue pair;
	  for(size_t j=0; j<op.at_start_del_effects[i].typed_parameters.size(); j++) {
		  pair.key = predicates[op.at_start_del_effects[i].name].typed_parameters[j].key;
		  pair.value = boundParameters[op.at_start_del_effects[i].typed_parameters[j].key];
		  item.values.push_back(pair);
	  }
	  updatePredSrv.request.knowledge.push_back(item);
	  updatePredSrv.request.update_type.push_back(rosplan_knowledge_msgs::KnowledgeUpdateService::Request::REMOVE_KNOWLEDGE);
  }

			// simple START add effects
  for(int i=0; i<op.at_start_add_effects.size(); i++) {

		std::map<std::string, rosplan_knowledge_msgs::DomainFormula>::iterator it = sensed_predicates.find(op.at_start_add_effects[i].name);
		if(it != sensed_predicates.end()) continue; // sensed predicate

		rosplan_knowledge_msgs::KnowledgeItem item;
		item.knowledge_type = rosplan_knowledge_msgs::KnowledgeItem::FACT;
		item.attribute_name = op.at_start_add_effects[i].name;
		item.values.clear();
		diagnostic_msgs::KeyValue pair;
		for(size_t j=0; j<op.at_start_add_effects[i].typed_parameters.size(); j++) {
			pair.key = predicates[op.at_start_add_effects[i].name].typed_parameters[j].key;
			pair.value = boundParameters[op.at_start_add_effects[i].typed_parameters[j].key];
			item.values.push_back(pair);
		}
		updatePredSrv.request.knowledge.push_back(item);
		updatePredSrv.request.update_type.push_back(rosplan_knowledge_msgs::KnowledgeUpdateService::Request::ADD_KNOWLEDGE);
	}

	if(updatePredSrv.request.knowledge.size()>0 && !update_knowledge_client.call(updatePredSrv))
		ROS_INFO("KCL: (%s) failed to update PDDL model in knowledge base", params.name.c_str());
}


void update_end(string node_id){
  std::string name = agent_action[node_id].name;
	std::map<std::string, rosplan_knowledge_msgs::DomainFormula> predicates = operator_info[name].predicates;
	std::map<std::string, rosplan_knowledge_msgs::DomainFormula> sensed_predicates = operator_info[name].sensed_predicates;

	rosplan_knowledge_msgs::DomainFormula params = operator_info[name].params;
	rosplan_knowledge_msgs::DomainOperator op = operator_info[name].op;

  std::vector<diagnostic_msgs::KeyValue> parameters = agent_action[node_id].parameters;

  std::vector<bool> found(params.typed_parameters.size(), false);
	std::map<std::string, std::string> boundParameters;
	for(size_t j=0; j<params.typed_parameters.size(); j++) {
		for(size_t i=0; i<parameters.size(); i++) {
			if(params.typed_parameters[j].key == parameters[i].key) {
				boundParameters[parameters[i].key] = parameters[i].value;
				found[j] = true;
				break;
			}
		}
		if(!found[j]) {
			ROS_INFO("KCL: (%s) aborting action dispatch; malformed parameters, missing %s", params.name.c_str(), params.typed_parameters[j].key.c_str());
			return;
		}
	}

			// update knowledge base
	rosplan_knowledge_msgs::KnowledgeUpdateServiceArray updatePredSrv;

			// simple END del effects
	for(int i=0; i<op.at_end_del_effects.size(); i++) {

		std::map<std::string, rosplan_knowledge_msgs::DomainFormula>::iterator it = sensed_predicates.find(op.at_end_del_effects[i].name);
		if(it != sensed_predicates.end()) continue; // sensed predicate

		rosplan_knowledge_msgs::KnowledgeItem item;
		item.knowledge_type = rosplan_knowledge_msgs::KnowledgeItem::FACT;
		item.attribute_name = op.at_end_del_effects[i].name;
		item.values.clear();
		diagnostic_msgs::KeyValue pair;
		for(size_t j=0; j<op.at_end_del_effects[i].typed_parameters.size(); j++) {
			pair.key = predicates[op.at_end_del_effects[i].name].typed_parameters[j].key;
			pair.value = boundParameters[op.at_end_del_effects[i].typed_parameters[j].key];
			item.values.push_back(pair);
		}
		updatePredSrv.request.knowledge.push_back(item);
		updatePredSrv.request.update_type.push_back(rosplan_knowledge_msgs::KnowledgeUpdateService::Request::REMOVE_KNOWLEDGE);
	}

			// simple END add effects
	for(int i=0; i<op.at_end_add_effects.size(); i++) {

		std::map<std::string, rosplan_knowledge_msgs::DomainFormula>::iterator it = sensed_predicates.find(op.at_end_add_effects[i].name);
		if(it != sensed_predicates.end()) continue; // sensed predicate

		rosplan_knowledge_msgs::KnowledgeItem item;
		item.knowledge_type = rosplan_knowledge_msgs::KnowledgeItem::FACT;
		item.attribute_name = op.at_end_add_effects[i].name;
		item.values.clear();
		diagnostic_msgs::KeyValue pair;
		for(size_t j=0; j<op.at_end_add_effects[i].typed_parameters.size(); j++) {
			pair.key = predicates[op.at_end_add_effects[i].name].typed_parameters[j].key;
			pair.value = boundParameters[op.at_end_add_effects[i].typed_parameters[j].key];
			item.values.push_back(pair);
		}
		updatePredSrv.request.knowledge.push_back(item);
		updatePredSrv.request.update_type.push_back(rosplan_knowledge_msgs::KnowledgeUpdateService::Request::ADD_KNOWLEDGE);
	}

	if(updatePredSrv.request.knowledge.size()>0 && !update_knowledge_client.call(updatePredSrv))
		ROS_INFO("KCL: (%s) failed to update PDDL model in knowledge base", params.name.c_str());
}

void make_node_name(string& name){
  int point = name.find("/", 10);   //패키지명 등을 제외하고 노드 이름의 필요한 부분만 찾아 뽑아냄
  name = name.substr(point + 2);
  
}