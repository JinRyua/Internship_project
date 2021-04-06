#include <ros/ros.h>
#include <vector>
#include <random>

#include "new_Interface/ActionInterface.h"

#ifndef simulatedaction
#define simulatedaction

/**
 * This file defines the RPSimulatedActionInterface class.
 * RPSimulatedActionInterface is used to simulate synthetic actions (non physics based simulator)
 * 
 */
namespace KCL_rosplan {

	class SimulatedActionInterface: public ActionInterface
	{

	private:

		double action_duration;
		double action_duration_stddev;
		double action_probability;

	public:

		/* constructor */
		SimulatedActionInterface(ros::NodeHandle &nh);

		/* listen to and process action_dispatch topic */
		bool concreteCallback(const new_Interface::order_msg::ConstPtr& msg);
	};
}
#endif
