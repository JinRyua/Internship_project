; Auto-generated. Do not edit!


(cl:in-package rosplan_dispatch_msgs-srv)


;//! \htmlinclude ProblemService-request.msg.html

(cl:defclass <ProblemService-request> (roslisp-msg-protocol:ros-message)
  ((problem_path
    :reader problem_path
    :initarg :problem_path
    :type cl:string
    :initform "")
   (problem_string_response
    :reader problem_string_response
    :initarg :problem_string_response
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ProblemService-request (<ProblemService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ProblemService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ProblemService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_dispatch_msgs-srv:<ProblemService-request> is deprecated: use rosplan_dispatch_msgs-srv:ProblemService-request instead.")))

(cl:ensure-generic-function 'problem_path-val :lambda-list '(m))
(cl:defmethod problem_path-val ((m <ProblemService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-srv:problem_path-val is deprecated.  Use rosplan_dispatch_msgs-srv:problem_path instead.")
  (problem_path m))

(cl:ensure-generic-function 'problem_string_response-val :lambda-list '(m))
(cl:defmethod problem_string_response-val ((m <ProblemService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-srv:problem_string_response-val is deprecated.  Use rosplan_dispatch_msgs-srv:problem_string_response instead.")
  (problem_string_response m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ProblemService-request>) ostream)
  "Serializes a message object of type '<ProblemService-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'problem_path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'problem_path))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'problem_string_response) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ProblemService-request>) istream)
  "Deserializes a message object of type '<ProblemService-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'problem_path) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'problem_path) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'problem_string_response) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ProblemService-request>)))
  "Returns string type for a service object of type '<ProblemService-request>"
  "rosplan_dispatch_msgs/ProblemServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ProblemService-request)))
  "Returns string type for a service object of type 'ProblemService-request"
  "rosplan_dispatch_msgs/ProblemServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ProblemService-request>)))
  "Returns md5sum for a message object of type '<ProblemService-request>"
  "61fb3e0dd88c35b2c75cf0b688f40ee8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ProblemService-request)))
  "Returns md5sum for a message object of type 'ProblemService-request"
  "61fb3e0dd88c35b2c75cf0b688f40ee8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ProblemService-request>)))
  "Returns full string definition for message of type '<ProblemService-request>"
  (cl:format cl:nil "# request a problem to be generated in the problem_path~%string problem_path~%bool problem_string_response~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ProblemService-request)))
  "Returns full string definition for message of type 'ProblemService-request"
  (cl:format cl:nil "# request a problem to be generated in the problem_path~%string problem_path~%bool problem_string_response~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ProblemService-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'problem_path))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ProblemService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ProblemService-request
    (cl:cons ':problem_path (problem_path msg))
    (cl:cons ':problem_string_response (problem_string_response msg))
))
;//! \htmlinclude ProblemService-response.msg.html

(cl:defclass <ProblemService-response> (roslisp-msg-protocol:ros-message)
  ((problem_generated
    :reader problem_generated
    :initarg :problem_generated
    :type cl:boolean
    :initform cl:nil)
   (problem_string
    :reader problem_string
    :initarg :problem_string
    :type cl:string
    :initform ""))
)

(cl:defclass ProblemService-response (<ProblemService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ProblemService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ProblemService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_dispatch_msgs-srv:<ProblemService-response> is deprecated: use rosplan_dispatch_msgs-srv:ProblemService-response instead.")))

(cl:ensure-generic-function 'problem_generated-val :lambda-list '(m))
(cl:defmethod problem_generated-val ((m <ProblemService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-srv:problem_generated-val is deprecated.  Use rosplan_dispatch_msgs-srv:problem_generated instead.")
  (problem_generated m))

(cl:ensure-generic-function 'problem_string-val :lambda-list '(m))
(cl:defmethod problem_string-val ((m <ProblemService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-srv:problem_string-val is deprecated.  Use rosplan_dispatch_msgs-srv:problem_string instead.")
  (problem_string m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ProblemService-response>) ostream)
  "Serializes a message object of type '<ProblemService-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'problem_generated) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'problem_string))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'problem_string))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ProblemService-response>) istream)
  "Deserializes a message object of type '<ProblemService-response>"
    (cl:setf (cl:slot-value msg 'problem_generated) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'problem_string) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'problem_string) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ProblemService-response>)))
  "Returns string type for a service object of type '<ProblemService-response>"
  "rosplan_dispatch_msgs/ProblemServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ProblemService-response)))
  "Returns string type for a service object of type 'ProblemService-response"
  "rosplan_dispatch_msgs/ProblemServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ProblemService-response>)))
  "Returns md5sum for a message object of type '<ProblemService-response>"
  "61fb3e0dd88c35b2c75cf0b688f40ee8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ProblemService-response)))
  "Returns md5sum for a message object of type 'ProblemService-response"
  "61fb3e0dd88c35b2c75cf0b688f40ee8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ProblemService-response>)))
  "Returns full string definition for message of type '<ProblemService-response>"
  (cl:format cl:nil "bool problem_generated~%string problem_string~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ProblemService-response)))
  "Returns full string definition for message of type 'ProblemService-response"
  (cl:format cl:nil "bool problem_generated~%string problem_string~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ProblemService-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'problem_string))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ProblemService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ProblemService-response
    (cl:cons ':problem_generated (problem_generated msg))
    (cl:cons ':problem_string (problem_string msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ProblemService)))
  'ProblemService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ProblemService)))
  'ProblemService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ProblemService)))
  "Returns string type for a service object of type '<ProblemService>"
  "rosplan_dispatch_msgs/ProblemService")