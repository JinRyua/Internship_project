# generated from catkin/cmake/template/pkg.context.pc.in
CATKIN_PACKAGE_PREFIX = ""
PROJECT_PKG_CONFIG_INCLUDE_DIRS = "${prefix}/include;/home/jylee/jylee/ROSPlan/devel/.private/rosplan_dispatch_msgs/include;/home/jylee/jylee/ROSPlan/devel/.private/rosplan_knowledge_msgs/include;/opt/ros/melodic/include;/opt/ros/melodic/share/xmlrpcpp/cmake/../../../include/xmlrpcpp;/usr/include".split(';') if "${prefix}/include;/home/jylee/jylee/ROSPlan/devel/.private/rosplan_dispatch_msgs/include;/home/jylee/jylee/ROSPlan/devel/.private/rosplan_knowledge_msgs/include;/opt/ros/melodic/include;/opt/ros/melodic/share/xmlrpcpp/cmake/../../../include/xmlrpcpp;/usr/include" != "" else []
PROJECT_CATKIN_DEPENDS = "roscpp;rospy;actionlib;std_msgs;std_srvs;diagnostic_msgs;rosplan_dispatch_msgs;rosplan_knowledge_msgs".replace(';', ' ')
PKG_CONFIG_LIBRARIES_WITH_PREFIX = "-lrosplan_planning_system;-lrosplan_action_interface".split(';') if "-lrosplan_planning_system;-lrosplan_action_interface" != "" else []
PROJECT_NAME = "rosplan_planning_system"
PROJECT_SPACE_DIR = "/home/jylee/jylee/ROSPlan/install"
PROJECT_VERSION = "0.0.0"
