; Auto-generated. Do not edit!


(cl:in-package rosplan_dispatch_msgs-msg)


;//! \htmlinclude EsterelPlanNode.msg.html

(cl:defclass <EsterelPlanNode> (roslisp-msg-protocol:ros-message)
  ((node_type
    :reader node_type
    :initarg :node_type
    :type cl:integer
    :initform 0)
   (node_id
    :reader node_id
    :initarg :node_id
    :type cl:integer
    :initform 0)
   (name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (action
    :reader action
    :initarg :action
    :type rosplan_dispatch_msgs-msg:ActionDispatch
    :initform (cl:make-instance 'rosplan_dispatch_msgs-msg:ActionDispatch))
   (edges_out
    :reader edges_out
    :initarg :edges_out
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (edges_in
    :reader edges_in
    :initarg :edges_in
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass EsterelPlanNode (<EsterelPlanNode>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EsterelPlanNode>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EsterelPlanNode)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_dispatch_msgs-msg:<EsterelPlanNode> is deprecated: use rosplan_dispatch_msgs-msg:EsterelPlanNode instead.")))

(cl:ensure-generic-function 'node_type-val :lambda-list '(m))
(cl:defmethod node_type-val ((m <EsterelPlanNode>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:node_type-val is deprecated.  Use rosplan_dispatch_msgs-msg:node_type instead.")
  (node_type m))

(cl:ensure-generic-function 'node_id-val :lambda-list '(m))
(cl:defmethod node_id-val ((m <EsterelPlanNode>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:node_id-val is deprecated.  Use rosplan_dispatch_msgs-msg:node_id instead.")
  (node_id m))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <EsterelPlanNode>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:name-val is deprecated.  Use rosplan_dispatch_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'action-val :lambda-list '(m))
(cl:defmethod action-val ((m <EsterelPlanNode>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:action-val is deprecated.  Use rosplan_dispatch_msgs-msg:action instead.")
  (action m))

(cl:ensure-generic-function 'edges_out-val :lambda-list '(m))
(cl:defmethod edges_out-val ((m <EsterelPlanNode>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:edges_out-val is deprecated.  Use rosplan_dispatch_msgs-msg:edges_out instead.")
  (edges_out m))

(cl:ensure-generic-function 'edges_in-val :lambda-list '(m))
(cl:defmethod edges_in-val ((m <EsterelPlanNode>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:edges_in-val is deprecated.  Use rosplan_dispatch_msgs-msg:edges_in instead.")
  (edges_in m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<EsterelPlanNode>)))
    "Constants for message type '<EsterelPlanNode>"
  '((:ACTION_START . 0)
    (:ACTION_END . 1)
    (:PLAN_START . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'EsterelPlanNode)))
    "Constants for message type 'EsterelPlanNode"
  '((:ACTION_START . 0)
    (:ACTION_END . 1)
    (:PLAN_START . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EsterelPlanNode>) ostream)
  "Serializes a message object of type '<EsterelPlanNode>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'node_type)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'node_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'action) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'edges_out))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    ))
   (cl:slot-value msg 'edges_out))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'edges_in))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    ))
   (cl:slot-value msg 'edges_in))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EsterelPlanNode>) istream)
  "Deserializes a message object of type '<EsterelPlanNode>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'node_type)) (cl:read-byte istream))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'node_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'action) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'edges_out) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'edges_out)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'edges_in) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'edges_in)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EsterelPlanNode>)))
  "Returns string type for a message object of type '<EsterelPlanNode>"
  "rosplan_dispatch_msgs/EsterelPlanNode")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EsterelPlanNode)))
  "Returns string type for a message object of type 'EsterelPlanNode"
  "rosplan_dispatch_msgs/EsterelPlanNode")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EsterelPlanNode>)))
  "Returns md5sum for a message object of type '<EsterelPlanNode>"
  "da4ec1de4a3a375abc1d2472c95de8b7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EsterelPlanNode)))
  "Returns md5sum for a message object of type 'EsterelPlanNode"
  "da4ec1de4a3a375abc1d2472c95de8b7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EsterelPlanNode>)))
  "Returns full string definition for message of type '<EsterelPlanNode>"
  (cl:format cl:nil "#EsterelPlanNode message~%~%byte ACTION_START = 0~%byte ACTION_END   = 1~%byte PLAN_START   = 2~%~%byte node_type~%int32 node_id~%string name~%rosplan_dispatch_msgs/ActionDispatch action~%~%int32[] edges_out~%int32[] edges_in~%~%================================================================================~%MSG: rosplan_dispatch_msgs/ActionDispatch~%#actionDispatch message~%int32 action_id~%string name~%diagnostic_msgs/KeyValue[] parameters~%float32 duration~%float32 dispatch_time~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EsterelPlanNode)))
  "Returns full string definition for message of type 'EsterelPlanNode"
  (cl:format cl:nil "#EsterelPlanNode message~%~%byte ACTION_START = 0~%byte ACTION_END   = 1~%byte PLAN_START   = 2~%~%byte node_type~%int32 node_id~%string name~%rosplan_dispatch_msgs/ActionDispatch action~%~%int32[] edges_out~%int32[] edges_in~%~%================================================================================~%MSG: rosplan_dispatch_msgs/ActionDispatch~%#actionDispatch message~%int32 action_id~%string name~%diagnostic_msgs/KeyValue[] parameters~%float32 duration~%float32 dispatch_time~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EsterelPlanNode>))
  (cl:+ 0
     1
     4
     4 (cl:length (cl:slot-value msg 'name))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'action))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'edges_out) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'edges_in) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EsterelPlanNode>))
  "Converts a ROS message object to a list"
  (cl:list 'EsterelPlanNode
    (cl:cons ':node_type (node_type msg))
    (cl:cons ':node_id (node_id msg))
    (cl:cons ':name (name msg))
    (cl:cons ':action (action msg))
    (cl:cons ':edges_out (edges_out msg))
    (cl:cons ':edges_in (edges_in msg))
))
