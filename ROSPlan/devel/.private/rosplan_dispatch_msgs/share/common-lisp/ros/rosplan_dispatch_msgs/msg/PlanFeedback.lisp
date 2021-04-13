; Auto-generated. Do not edit!


(cl:in-package rosplan_dispatch_msgs-msg)


;//! \htmlinclude PlanFeedback.msg.html

(cl:defclass <PlanFeedback> (roslisp-msg-protocol:ros-message)
  ((current_phase
    :reader current_phase
    :initarg :current_phase
    :type cl:string
    :initform "")
   (current_status
    :reader current_status
    :initarg :current_status
    :type cl:string
    :initform "")
   (percent_completed
    :reader percent_completed
    :initarg :percent_completed
    :type cl:integer
    :initform 0))
)

(cl:defclass PlanFeedback (<PlanFeedback>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PlanFeedback>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PlanFeedback)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_dispatch_msgs-msg:<PlanFeedback> is deprecated: use rosplan_dispatch_msgs-msg:PlanFeedback instead.")))

(cl:ensure-generic-function 'current_phase-val :lambda-list '(m))
(cl:defmethod current_phase-val ((m <PlanFeedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:current_phase-val is deprecated.  Use rosplan_dispatch_msgs-msg:current_phase instead.")
  (current_phase m))

(cl:ensure-generic-function 'current_status-val :lambda-list '(m))
(cl:defmethod current_status-val ((m <PlanFeedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:current_status-val is deprecated.  Use rosplan_dispatch_msgs-msg:current_status instead.")
  (current_status m))

(cl:ensure-generic-function 'percent_completed-val :lambda-list '(m))
(cl:defmethod percent_completed-val ((m <PlanFeedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:percent_completed-val is deprecated.  Use rosplan_dispatch_msgs-msg:percent_completed instead.")
  (percent_completed m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PlanFeedback>) ostream)
  "Serializes a message object of type '<PlanFeedback>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'current_phase))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'current_phase))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'current_status))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'current_status))
  (cl:let* ((signed (cl:slot-value msg 'percent_completed)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PlanFeedback>) istream)
  "Deserializes a message object of type '<PlanFeedback>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'current_phase) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'current_phase) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'current_status) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'current_status) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'percent_completed) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PlanFeedback>)))
  "Returns string type for a message object of type '<PlanFeedback>"
  "rosplan_dispatch_msgs/PlanFeedback")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PlanFeedback)))
  "Returns string type for a message object of type 'PlanFeedback"
  "rosplan_dispatch_msgs/PlanFeedback")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PlanFeedback>)))
  "Returns md5sum for a message object of type '<PlanFeedback>"
  "791f3441963c8bf65c82e3e2bc873576")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PlanFeedback)))
  "Returns md5sum for a message object of type 'PlanFeedback"
  "791f3441963c8bf65c82e3e2bc873576")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PlanFeedback>)))
  "Returns full string definition for message of type '<PlanFeedback>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%# feedback definition~%string current_phase~%string current_status~%int32 percent_completed~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PlanFeedback)))
  "Returns full string definition for message of type 'PlanFeedback"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%# feedback definition~%string current_phase~%string current_status~%int32 percent_completed~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PlanFeedback>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'current_phase))
     4 (cl:length (cl:slot-value msg 'current_status))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PlanFeedback>))
  "Converts a ROS message object to a list"
  (cl:list 'PlanFeedback
    (cl:cons ':current_phase (current_phase msg))
    (cl:cons ':current_status (current_status msg))
    (cl:cons ':percent_completed (percent_completed msg))
))
