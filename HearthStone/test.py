import rospy
from std_msgs.msg import String
from log_display.msg import log_msg

def talker():
	pub = rospy.Publisher('/log_display/log', log_msg, queue_size=10)
	rospy.init_node('talker')
	rate = rospy.Rate(10) # 10hz
	while not rospy.is_shutdown():
		hello_str = "hi %s" % rospy.get_time()
		rospy.loginfo(hello_str)
		pub.publish(hello_str)
		rate.sleep()
if __name__ == '__main__':
	try:
		talker()
	except rospy.ROSInterruptException:
		pass
