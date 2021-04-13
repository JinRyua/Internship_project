; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-srv)


;//! \htmlinclude GenerateProblemService-request.msg.html

(cl:defclass <GenerateProblemService-request> (roslisp-msg-protocol:ros-message)
  ((problem_path
    :reader problem_path
    :initarg :problem_path
    :type cl:string
    :initform "")
   (contingent
    :reader contingent
    :initarg :contingent
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass GenerateProblemService-request (<GenerateProblemService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GenerateProblemService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GenerateProblemService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GenerateProblemService-request> is deprecated: use rosplan_knowledge_msgs-srv:GenerateProblemService-request instead.")))

(cl:ensure-generic-function 'problem_path-val :lambda-list '(m))
(cl:defmethod problem_path-val ((m <GenerateProblemService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:problem_path-val is deprecated.  Use rosplan_knowledge_msgs-srv:problem_path instead.")
  (problem_path m))

(cl:ensure-generic-function 'contingent-val :lambda-list '(m))
(cl:defmethod contingent-val ((m <GenerateProblemService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:contingent-val is deprecated.  Use rosplan_knowledge_msgs-srv:contingent instead.")
  (contingent m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GenerateProblemService-request>) ostream)
  "Serializes a message object of type '<GenerateProblemService-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'problem_path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'problem_path))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'contingent) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GenerateProblemService-request>) istream)
  "Deserializes a message object of type '<GenerateProblemService-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'problem_path) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'problem_path) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'contingent) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GenerateProblemService-request>)))
  "Returns string type for a service object of type '<GenerateProblemService-request>"
  "rosplan_knowledge_msgs/GenerateProblemServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GenerateProblemService-request)))
  "Returns string type for a service object of type 'GenerateProblemService-request"
  "rosplan_knowledge_msgs/GenerateProblemServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GenerateProblemService-request>)))
  "Returns md5sum for a message object of type '<GenerateProblemService-request>"
  "691992df67730037ceca53e2831f2e82")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GenerateProblemService-request)))
  "Returns md5sum for a message object of type 'GenerateProblemService-request"
  "691992df67730037ceca53e2831f2e82")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GenerateProblemService-request>)))
  "Returns full string definition for message of type '<GenerateProblemService-request>"
  (cl:format cl:nil "# simple service for generating a PDDL problem with goals from the KMS~%string problem_path~%bool contingent~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GenerateProblemService-request)))
  "Returns full string definition for message of type 'GenerateProblemService-request"
  (cl:format cl:nil "# simple service for generating a PDDL problem with goals from the KMS~%string problem_path~%bool contingent~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GenerateProblemService-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'problem_path))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GenerateProblemService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GenerateProblemService-request
    (cl:cons ':problem_path (problem_path msg))
    (cl:cons ':contingent (contingent msg))
))
;//! \htmlinclude GenerateProblemService-response.msg.html

(cl:defclass <GenerateProblemService-response> (roslisp-msg-protocol:ros-message)
  ((message
    :reader message
    :initarg :message
    :type cl:string
    :initform ""))
)

(cl:defclass GenerateProblemService-response (<GenerateProblemService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GenerateProblemService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GenerateProblemService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GenerateProblemService-response> is deprecated: use rosplan_knowledge_msgs-srv:GenerateProblemService-response instead.")))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <GenerateProblemService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:message-val is deprecated.  Use rosplan_knowledge_msgs-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GenerateProblemService-response>) ostream)
  "Serializes a message object of type '<GenerateProblemService-response>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GenerateProblemService-response>) istream)
  "Deserializes a message object of type '<GenerateProblemService-response>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GenerateProblemService-response>)))
  "Returns string type for a service object of type '<GenerateProblemService-response>"
  "rosplan_knowledge_msgs/GenerateProblemServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GenerateProblemService-response)))
  "Returns string type for a service object of type 'GenerateProblemService-response"
  "rosplan_knowledge_msgs/GenerateProblemServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GenerateProblemService-response>)))
  "Returns md5sum for a message object of type '<GenerateProblemService-response>"
  "691992df67730037ceca53e2831f2e82")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GenerateProblemService-response)))
  "Returns md5sum for a message object of type 'GenerateProblemService-response"
  "691992df67730037ceca53e2831f2e82")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GenerateProblemService-response>)))
  "Returns full string definition for message of type '<GenerateProblemService-response>"
  (cl:format cl:nil "string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GenerateProblemService-response)))
  "Returns full string definition for message of type 'GenerateProblemService-response"
  (cl:format cl:nil "string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GenerateProblemService-response>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GenerateProblemService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GenerateProblemService-response
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GenerateProblemService)))
  'GenerateProblemService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GenerateProblemService)))
  'GenerateProblemService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GenerateProblemService)))
  "Returns string type for a service object of type '<GenerateProblemService>"
  "rosplan_knowledge_msgs/GenerateProblemService")