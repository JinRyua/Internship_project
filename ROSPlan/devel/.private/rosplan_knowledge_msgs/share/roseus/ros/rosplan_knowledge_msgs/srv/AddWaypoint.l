;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::AddWaypoint)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'AddWaypoint (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::ADDWAYPOINT")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::ADDWAYPOINT"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::ADDWAYPOINTREQUEST")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::ADDWAYPOINTREQUEST"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::ADDWAYPOINTRESPONSE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::ADDWAYPOINTRESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))




(defclass rosplan_knowledge_msgs::AddWaypointRequest
  :super ros::object
  :slots (_id _waypoint _connecting_distance _occupancy_threshold ))

(defmethod rosplan_knowledge_msgs::AddWaypointRequest
  (:init
   (&key
    ((:id __id) "")
    ((:waypoint __waypoint) (instance geometry_msgs::PoseStamped :init))
    ((:connecting_distance __connecting_distance) 0.0)
    ((:occupancy_threshold __occupancy_threshold) 0)
    )
   (send-super :init)
   (setq _id (string __id))
   (setq _waypoint __waypoint)
   (setq _connecting_distance (float __connecting_distance))
   (setq _occupancy_threshold (round __occupancy_threshold))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:waypoint
   (&rest __waypoint)
   (if (keywordp (car __waypoint))
       (send* _waypoint __waypoint)
     (progn
       (if __waypoint (setq _waypoint (car __waypoint)))
       _waypoint)))
  (:connecting_distance
   (&optional __connecting_distance)
   (if __connecting_distance (setq _connecting_distance __connecting_distance)) _connecting_distance)
  (:occupancy_threshold
   (&optional __occupancy_threshold)
   (if __occupancy_threshold (setq _occupancy_threshold __occupancy_threshold)) _occupancy_threshold)
  (:serialization-length
   ()
   (+
    ;; string _id
    4 (length _id)
    ;; geometry_msgs/PoseStamped _waypoint
    (send _waypoint :serialization-length)
    ;; float32 _connecting_distance
    4
    ;; int8 _occupancy_threshold
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _id
       (write-long (length _id) s) (princ _id s)
     ;; geometry_msgs/PoseStamped _waypoint
       (send _waypoint :serialize s)
     ;; float32 _connecting_distance
       (sys::poke _connecting_distance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int8 _occupancy_threshold
       (write-byte _occupancy_threshold s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; geometry_msgs/PoseStamped _waypoint
     (send _waypoint :deserialize buf ptr-) (incf ptr- (send _waypoint :serialization-length))
   ;; float32 _connecting_distance
     (setq _connecting_distance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int8 _occupancy_threshold
     (setq _occupancy_threshold (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _occupancy_threshold 127) (setq _occupancy_threshold (- _occupancy_threshold 256)))
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::AddWaypointResponse
  :super ros::object
  :slots ())

(defmethod rosplan_knowledge_msgs::AddWaypointResponse
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::AddWaypoint
  :super ros::object
  :slots ())

(setf (get rosplan_knowledge_msgs::AddWaypoint :md5sum-) "fbea0e8b407ac37bdef7686a7516a2fd")
(setf (get rosplan_knowledge_msgs::AddWaypoint :datatype-) "rosplan_knowledge_msgs/AddWaypoint")
(setf (get rosplan_knowledge_msgs::AddWaypoint :request) rosplan_knowledge_msgs::AddWaypointRequest)
(setf (get rosplan_knowledge_msgs::AddWaypoint :response) rosplan_knowledge_msgs::AddWaypointResponse)

(defmethod rosplan_knowledge_msgs::AddWaypointRequest
  (:response () (instance rosplan_knowledge_msgs::AddWaypointResponse :init)))

(setf (get rosplan_knowledge_msgs::AddWaypointRequest :md5sum-) "fbea0e8b407ac37bdef7686a7516a2fd")
(setf (get rosplan_knowledge_msgs::AddWaypointRequest :datatype-) "rosplan_knowledge_msgs/AddWaypointRequest")
(setf (get rosplan_knowledge_msgs::AddWaypointRequest :definition-)
      "string id
geometry_msgs/PoseStamped waypoint
float32 connecting_distance
int8 occupancy_threshold

================================================================================
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
---


")

(setf (get rosplan_knowledge_msgs::AddWaypointResponse :md5sum-) "fbea0e8b407ac37bdef7686a7516a2fd")
(setf (get rosplan_knowledge_msgs::AddWaypointResponse :datatype-) "rosplan_knowledge_msgs/AddWaypointResponse")
(setf (get rosplan_knowledge_msgs::AddWaypointResponse :definition-)
      "string id
geometry_msgs/PoseStamped waypoint
float32 connecting_distance
int8 occupancy_threshold

================================================================================
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
---


")



(provide :rosplan_knowledge_msgs/AddWaypoint "fbea0e8b407ac37bdef7686a7516a2fd")


