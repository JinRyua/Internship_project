; Auto-generated. Do not edit!


(cl:in-package rosplan_dispatch_msgs-msg)


;//! \htmlinclude PlanGoal.msg.html

(cl:defclass <PlanGoal> (roslisp-msg-protocol:ros-message)
  ((domain_path
    :reader domain_path
    :initarg :domain_path
    :type cl:string
    :initform "")
   (problem_path
    :reader problem_path
    :initarg :problem_path
    :type cl:string
    :initform "")
   (data_path
    :reader data_path
    :initarg :data_path
    :type cl:string
    :initform "")
   (planner_command
    :reader planner_command
    :initarg :planner_command
    :type cl:string
    :initform "")
   (use_problem_topic
    :reader use_problem_topic
    :initarg :use_problem_topic
    :type cl:boolean
    :initform cl:nil)
   (start_action_id
    :reader start_action_id
    :initarg :start_action_id
    :type cl:integer
    :initform 0))
)

(cl:defclass PlanGoal (<PlanGoal>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PlanGoal>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PlanGoal)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_dispatch_msgs-msg:<PlanGoal> is deprecated: use rosplan_dispatch_msgs-msg:PlanGoal instead.")))

(cl:ensure-generic-function 'domain_path-val :lambda-list '(m))
(cl:defmethod domain_path-val ((m <PlanGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:domain_path-val is deprecated.  Use rosplan_dispatch_msgs-msg:domain_path instead.")
  (domain_path m))

(cl:ensure-generic-function 'problem_path-val :lambda-list '(m))
(cl:defmethod problem_path-val ((m <PlanGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:problem_path-val is deprecated.  Use rosplan_dispatch_msgs-msg:problem_path instead.")
  (problem_path m))

(cl:ensure-generic-function 'data_path-val :lambda-list '(m))
(cl:defmethod data_path-val ((m <PlanGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:data_path-val is deprecated.  Use rosplan_dispatch_msgs-msg:data_path instead.")
  (data_path m))

(cl:ensure-generic-function 'planner_command-val :lambda-list '(m))
(cl:defmethod planner_command-val ((m <PlanGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:planner_command-val is deprecated.  Use rosplan_dispatch_msgs-msg:planner_command instead.")
  (planner_command m))

(cl:ensure-generic-function 'use_problem_topic-val :lambda-list '(m))
(cl:defmethod use_problem_topic-val ((m <PlanGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:use_problem_topic-val is deprecated.  Use rosplan_dispatch_msgs-msg:use_problem_topic instead.")
  (use_problem_topic m))

(cl:ensure-generic-function 'start_action_id-val :lambda-list '(m))
(cl:defmethod start_action_id-val ((m <PlanGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:start_action_id-val is deprecated.  Use rosplan_dispatch_msgs-msg:start_action_id instead.")
  (start_action_id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PlanGoal>) ostream)
  "Serializes a message object of type '<PlanGoal>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'domain_path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'domain_path))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'problem_path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'problem_path))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'data_path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'data_path))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'planner_command))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'planner_command))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'use_problem_topic) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'start_action_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'start_action_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'start_action_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'start_action_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'start_action_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'start_action_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'start_action_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'start_action_id)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PlanGoal>) istream)
  "Deserializes a message object of type '<PlanGoal>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'domain_path) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'domain_path) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'problem_path) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'problem_path) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'data_path) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'data_path) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'planner_command) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'planner_command) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'use_problem_topic) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'start_action_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'start_action_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'start_action_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'start_action_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'start_action_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'start_action_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'start_action_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'start_action_id)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PlanGoal>)))
  "Returns string type for a message object of type '<PlanGoal>"
  "rosplan_dispatch_msgs/PlanGoal")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PlanGoal)))
  "Returns string type for a message object of type 'PlanGoal"
  "rosplan_dispatch_msgs/PlanGoal")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PlanGoal>)))
  "Returns md5sum for a message object of type '<PlanGoal>"
  "ec56e034bdab5d47c02286cf335fd906")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PlanGoal)))
  "Returns md5sum for a message object of type 'PlanGoal"
  "ec56e034bdab5d47c02286cf335fd906")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PlanGoal>)))
  "Returns full string definition for message of type '<PlanGoal>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%# Planning action definition~%# goal definition~%string domain_path~%string problem_path~%string data_path~%string planner_command~%bool use_problem_topic~%uint64 start_action_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PlanGoal)))
  "Returns full string definition for message of type 'PlanGoal"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%# Planning action definition~%# goal definition~%string domain_path~%string problem_path~%string data_path~%string planner_command~%bool use_problem_topic~%uint64 start_action_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PlanGoal>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'domain_path))
     4 (cl:length (cl:slot-value msg 'problem_path))
     4 (cl:length (cl:slot-value msg 'data_path))
     4 (cl:length (cl:slot-value msg 'planner_command))
     1
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PlanGoal>))
  "Converts a ROS message object to a list"
  (cl:list 'PlanGoal
    (cl:cons ':domain_path (domain_path msg))
    (cl:cons ':problem_path (problem_path msg))
    (cl:cons ':data_path (data_path msg))
    (cl:cons ':planner_command (planner_command msg))
    (cl:cons ':use_problem_topic (use_problem_topic msg))
    (cl:cons ':start_action_id (start_action_id msg))
))
