; Auto-generated. Do not edit!


(cl:in-package rosplan_dispatch_msgs-msg)


;//! \htmlinclude ActionFeedback.msg.html

(cl:defclass <ActionFeedback> (roslisp-msg-protocol:ros-message)
  ((action_id
    :reader action_id
    :initarg :action_id
    :type cl:integer
    :initform 0)
   (status
    :reader status
    :initarg :status
    :type cl:string
    :initform "")
   (information
    :reader information
    :initarg :information
    :type (cl:vector diagnostic_msgs-msg:KeyValue)
   :initform (cl:make-array 0 :element-type 'diagnostic_msgs-msg:KeyValue :initial-element (cl:make-instance 'diagnostic_msgs-msg:KeyValue))))
)

(cl:defclass ActionFeedback (<ActionFeedback>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ActionFeedback>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ActionFeedback)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_dispatch_msgs-msg:<ActionFeedback> is deprecated: use rosplan_dispatch_msgs-msg:ActionFeedback instead.")))

(cl:ensure-generic-function 'action_id-val :lambda-list '(m))
(cl:defmethod action_id-val ((m <ActionFeedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:action_id-val is deprecated.  Use rosplan_dispatch_msgs-msg:action_id instead.")
  (action_id m))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <ActionFeedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:status-val is deprecated.  Use rosplan_dispatch_msgs-msg:status instead.")
  (status m))

(cl:ensure-generic-function 'information-val :lambda-list '(m))
(cl:defmethod information-val ((m <ActionFeedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:information-val is deprecated.  Use rosplan_dispatch_msgs-msg:information instead.")
  (information m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ActionFeedback>) ostream)
  "Serializes a message object of type '<ActionFeedback>"
  (cl:let* ((signed (cl:slot-value msg 'action_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'status))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'status))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'information))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'information))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ActionFeedback>) istream)
  "Deserializes a message object of type '<ActionFeedback>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'action_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'status) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'status) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'information) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'information)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'diagnostic_msgs-msg:KeyValue))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ActionFeedback>)))
  "Returns string type for a message object of type '<ActionFeedback>"
  "rosplan_dispatch_msgs/ActionFeedback")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ActionFeedback)))
  "Returns string type for a message object of type 'ActionFeedback"
  "rosplan_dispatch_msgs/ActionFeedback")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ActionFeedback>)))
  "Returns md5sum for a message object of type '<ActionFeedback>"
  "e28991799802dd700e1390bf56614b89")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ActionFeedback)))
  "Returns md5sum for a message object of type 'ActionFeedback"
  "e28991799802dd700e1390bf56614b89")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ActionFeedback>)))
  "Returns full string definition for message of type '<ActionFeedback>"
  (cl:format cl:nil "#actionFeedback message~%int32 action_id~%string status~%diagnostic_msgs/KeyValue[] information~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ActionFeedback)))
  "Returns full string definition for message of type 'ActionFeedback"
  (cl:format cl:nil "#actionFeedback message~%int32 action_id~%string status~%diagnostic_msgs/KeyValue[] information~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ActionFeedback>))
  (cl:+ 0
     4
     4 (cl:length (cl:slot-value msg 'status))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'information) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ActionFeedback>))
  "Converts a ROS message object to a list"
  (cl:list 'ActionFeedback
    (cl:cons ':action_id (action_id msg))
    (cl:cons ':status (status msg))
    (cl:cons ':information (information msg))
))
