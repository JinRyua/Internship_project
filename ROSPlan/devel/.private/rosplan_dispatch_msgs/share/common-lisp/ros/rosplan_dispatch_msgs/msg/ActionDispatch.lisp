; Auto-generated. Do not edit!


(cl:in-package rosplan_dispatch_msgs-msg)


;//! \htmlinclude ActionDispatch.msg.html

(cl:defclass <ActionDispatch> (roslisp-msg-protocol:ros-message)
  ((action_id
    :reader action_id
    :initarg :action_id
    :type cl:integer
    :initform 0)
   (name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (parameters
    :reader parameters
    :initarg :parameters
    :type (cl:vector diagnostic_msgs-msg:KeyValue)
   :initform (cl:make-array 0 :element-type 'diagnostic_msgs-msg:KeyValue :initial-element (cl:make-instance 'diagnostic_msgs-msg:KeyValue)))
   (duration
    :reader duration
    :initarg :duration
    :type cl:float
    :initform 0.0)
   (dispatch_time
    :reader dispatch_time
    :initarg :dispatch_time
    :type cl:float
    :initform 0.0))
)

(cl:defclass ActionDispatch (<ActionDispatch>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ActionDispatch>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ActionDispatch)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_dispatch_msgs-msg:<ActionDispatch> is deprecated: use rosplan_dispatch_msgs-msg:ActionDispatch instead.")))

(cl:ensure-generic-function 'action_id-val :lambda-list '(m))
(cl:defmethod action_id-val ((m <ActionDispatch>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:action_id-val is deprecated.  Use rosplan_dispatch_msgs-msg:action_id instead.")
  (action_id m))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <ActionDispatch>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:name-val is deprecated.  Use rosplan_dispatch_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'parameters-val :lambda-list '(m))
(cl:defmethod parameters-val ((m <ActionDispatch>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:parameters-val is deprecated.  Use rosplan_dispatch_msgs-msg:parameters instead.")
  (parameters m))

(cl:ensure-generic-function 'duration-val :lambda-list '(m))
(cl:defmethod duration-val ((m <ActionDispatch>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:duration-val is deprecated.  Use rosplan_dispatch_msgs-msg:duration instead.")
  (duration m))

(cl:ensure-generic-function 'dispatch_time-val :lambda-list '(m))
(cl:defmethod dispatch_time-val ((m <ActionDispatch>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:dispatch_time-val is deprecated.  Use rosplan_dispatch_msgs-msg:dispatch_time instead.")
  (dispatch_time m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ActionDispatch>) ostream)
  "Serializes a message object of type '<ActionDispatch>"
  (cl:let* ((signed (cl:slot-value msg 'action_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
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
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'parameters))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'parameters))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'duration))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dispatch_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ActionDispatch>) istream)
  "Deserializes a message object of type '<ActionDispatch>"
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
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'parameters) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'parameters)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'diagnostic_msgs-msg:KeyValue))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'duration) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dispatch_time) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ActionDispatch>)))
  "Returns string type for a message object of type '<ActionDispatch>"
  "rosplan_dispatch_msgs/ActionDispatch")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ActionDispatch)))
  "Returns string type for a message object of type 'ActionDispatch"
  "rosplan_dispatch_msgs/ActionDispatch")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ActionDispatch>)))
  "Returns md5sum for a message object of type '<ActionDispatch>"
  "80f1ebdf8c68451c7e598f98e7f12dba")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ActionDispatch)))
  "Returns md5sum for a message object of type 'ActionDispatch"
  "80f1ebdf8c68451c7e598f98e7f12dba")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ActionDispatch>)))
  "Returns full string definition for message of type '<ActionDispatch>"
  (cl:format cl:nil "#actionDispatch message~%int32 action_id~%string name~%diagnostic_msgs/KeyValue[] parameters~%float32 duration~%float32 dispatch_time~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ActionDispatch)))
  "Returns full string definition for message of type 'ActionDispatch"
  (cl:format cl:nil "#actionDispatch message~%int32 action_id~%string name~%diagnostic_msgs/KeyValue[] parameters~%float32 duration~%float32 dispatch_time~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ActionDispatch>))
  (cl:+ 0
     4
     4 (cl:length (cl:slot-value msg 'name))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'parameters) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ActionDispatch>))
  "Converts a ROS message object to a list"
  (cl:list 'ActionDispatch
    (cl:cons ':action_id (action_id msg))
    (cl:cons ':name (name msg))
    (cl:cons ':parameters (parameters msg))
    (cl:cons ':duration (duration msg))
    (cl:cons ':dispatch_time (dispatch_time msg))
))
