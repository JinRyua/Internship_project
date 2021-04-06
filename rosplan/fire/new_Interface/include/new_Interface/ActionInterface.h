#include <ros/ros.h>
#include <vector>
#include <iostream>
#include <boost/tokenizer.hpp>

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
#include "new_Interface/order_msg.h"
#include "new_Interface/order_feedback.h"

#ifndef action_interface
#define action_interface

/**
 * This file defines the ActionInterface header.
 * This header defines a standard action interface for ROSPlan.
 * This interface will link a PDDL action to some implementation, most
 * commonly as an actionlib client.
 */

struct oper_info{
	std::map<std::string, rosplan_knowledge_msgs::DomainFormula> predicates;
	std::map<std::string, rosplan_knowledge_msgs::DomainFormula> sensed_predicates;

		/* PDDL info and publisher */
	rosplan_knowledge_msgs::DomainFormula params;
	rosplan_knowledge_msgs::DomainOperator op;
};

namespace KCL_rosplan {

	class ActionInterface
	{
	
	protected:
		
		std::map<std::string, rosplan_knowledge_msgs::DomainFormula> predicates;
		std::map<std::string, rosplan_knowledge_msgs::DomainFormula> sensed_predicates;

		/* PDDL info and publisher */
		rosplan_knowledge_msgs::DomainFormula params;
		rosplan_knowledge_msgs::DomainOperator op;

		std::vector<rosplan_knowledge_msgs::DomainFormula> opNames;
		std::map<std::string, struct oper_info> operator_info;

		ros::Publisher pddl_action_parameters_pub;

		/* action feedback to planning system */
		ros::Publisher order_feedback_pub;

		/* service handle to PDDL knowledge base */
		ros::ServiceClient update_knowledge_client;

		/* action status */
		bool action_success;
		bool action_cancelled;

	public:

		/* main loop for action interface */
		void runActionInterface();

		/* listen to and process action_dispatch topic */
		void dispatchCallback(const new_Interface::order_msg::ConstPtr& msg);
		
		/* perform or call real action implementation */
		virtual bool concreteCallback(const new_Interface::order_msg::ConstPtr& msg) =0;
	};
}
#endif
