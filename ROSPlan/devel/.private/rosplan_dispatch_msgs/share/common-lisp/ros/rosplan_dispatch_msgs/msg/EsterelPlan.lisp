; Auto-generated. Do not edit!


(cl:in-package rosplan_dispatch_msgs-msg)


;//! \htmlinclude EsterelPlan.msg.html

(cl:defclass <EsterelPlan> (roslisp-msg-protocol:ros-message)
  ((nodes
    :reader nodes
    :initarg :nodes
    :type (cl:vector rosplan_dispatch_msgs-msg:EsterelPlanNode)
   :initform (cl:make-array 0 :element-type 'rosplan_dispatch_msgs-msg:EsterelPlanNode :initial-element (cl:make-instance 'rosplan_dispatch_msgs-msg:EsterelPlanNode)))
   (edges
    :reader edges
    :initarg :edges
    :type (cl:vector rosplan_dispatch_msgs-msg:EsterelPlanEdge)
   :initform (cl:make-array 0 :element-type 'rosplan_dispatch_msgs-msg:EsterelPlanEdge :initial-element (cl:make-instance 'rosplan_dispatch_msgs-msg:EsterelPlanEdge))))
)

(cl:defclass EsterelPlan (<EsterelPlan>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EsterelPlan>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EsterelPlan)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_dispatch_msgs-msg:<EsterelPlan> is deprecated: use rosplan_dispatch_msgs-msg:EsterelPlan instead.")))

(cl:ensure-generic-function 'nodes-val :lambda-list '(m))
(cl:defmethod nodes-val ((m <EsterelPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:nodes-val is deprecated.  Use rosplan_dispatch_msgs-msg:nodes instead.")
  (nodes m))

(cl:ensure-generic-function 'edges-val :lambda-list '(m))
(cl:defmethod edges-val ((m <EsterelPlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:edges-val is deprecated.  Use rosplan_dispatch_msgs-msg:edges instead.")
  (edges m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EsterelPlan>) ostream)
  "Serializes a message object of type '<EsterelPlan>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'nodes))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'nodes))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'edges))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'edges))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EsterelPlan>) istream)
  "Deserializes a message object of type '<EsterelPlan>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'nodes) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'nodes)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_dispatch_msgs-msg:EsterelPlanNode))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'edges) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'edges)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_dispatch_msgs-msg:EsterelPlanEdge))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EsterelPlan>)))
  "Returns string type for a message object of type '<EsterelPlan>"
  "rosplan_dispatch_msgs/EsterelPlan")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EsterelPlan)))
  "Returns string type for a message object of type 'EsterelPlan"
  "rosplan_dispatch_msgs/EsterelPlan")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EsterelPlan>)))
  "Returns md5sum for a message object of type '<EsterelPlan>"
  "e505c1d88305f080c9c58693879a1a79")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EsterelPlan)))
  "Returns md5sum for a message object of type 'EsterelPlan"
  "e505c1d88305f080c9c58693879a1a79")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EsterelPlan>)))
  "Returns full string definition for message of type '<EsterelPlan>"
  (cl:format cl:nil "#EsterelPlan message~%EsterelPlanNode[] nodes~%EsterelPlanEdge[] edges~%~%================================================================================~%MSG: rosplan_dispatch_msgs/EsterelPlanNode~%#EsterelPlanNode message~%~%byte ACTION_START = 0~%byte ACTION_END   = 1~%byte PLAN_START   = 2~%~%byte node_type~%int32 node_id~%string name~%rosplan_dispatch_msgs/ActionDispatch action~%~%int32[] edges_out~%int32[] edges_in~%~%================================================================================~%MSG: rosplan_dispatch_msgs/ActionDispatch~%#actionDispatch message~%int32 action_id~%string name~%diagnostic_msgs/KeyValue[] parameters~%float32 duration~%float32 dispatch_time~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%================================================================================~%MSG: rosplan_dispatch_msgs/EsterelPlanEdge~%#EsterelPlanEdge message~%int32 edge_id~%string edge_name~%int32 signal_type~%int32[] source_ids~%int32[] sink_ids~%float64 duration_lower_bound~%float64 duration_upper_bound~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EsterelPlan)))
  "Returns full string definition for message of type 'EsterelPlan"
  (cl:format cl:nil "#EsterelPlan message~%EsterelPlanNode[] nodes~%EsterelPlanEdge[] edges~%~%================================================================================~%MSG: rosplan_dispatch_msgs/EsterelPlanNode~%#EsterelPlanNode message~%~%byte ACTION_START = 0~%byte ACTION_END   = 1~%byte PLAN_START   = 2~%~%byte node_type~%int32 node_id~%string name~%rosplan_dispatch_msgs/ActionDispatch action~%~%int32[] edges_out~%int32[] edges_in~%~%================================================================================~%MSG: rosplan_dispatch_msgs/ActionDispatch~%#actionDispatch message~%int32 action_id~%string name~%diagnostic_msgs/KeyValue[] parameters~%float32 duration~%float32 dispatch_time~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%================================================================================~%MSG: rosplan_dispatch_msgs/EsterelPlanEdge~%#EsterelPlanEdge message~%int32 edge_id~%string edge_name~%int32 signal_type~%int32[] source_ids~%int32[] sink_ids~%float64 duration_lower_bound~%float64 duration_upper_bound~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EsterelPlan>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'nodes) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'edges) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EsterelPlan>))
  "Converts a ROS message object to a list"
  (cl:list 'EsterelPlan
    (cl:cons ':nodes (nodes msg))
    (cl:cons ':edges (edges msg))
))
