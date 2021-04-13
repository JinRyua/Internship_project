; Auto-generated. Do not edit!


(cl:in-package rosplan_dispatch_msgs-srv)


;//! \htmlinclude ParsingService-request.msg.html

(cl:defclass <ParsingService-request> (roslisp-msg-protocol:ros-message)
  ((plan_path
    :reader plan_path
    :initarg :plan_path
    :type cl:string
    :initform ""))
)

(cl:defclass ParsingService-request (<ParsingService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ParsingService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ParsingService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_dispatch_msgs-srv:<ParsingService-request> is deprecated: use rosplan_dispatch_msgs-srv:ParsingService-request instead.")))

(cl:ensure-generic-function 'plan_path-val :lambda-list '(m))
(cl:defmethod plan_path-val ((m <ParsingService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-srv:plan_path-val is deprecated.  Use rosplan_dispatch_msgs-srv:plan_path instead.")
  (plan_path m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ParsingService-request>) ostream)
  "Serializes a message object of type '<ParsingService-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'plan_path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'plan_path))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ParsingService-request>) istream)
  "Deserializes a message object of type '<ParsingService-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'plan_path) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'plan_path) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ParsingService-request>)))
  "Returns string type for a service object of type '<ParsingService-request>"
  "rosplan_dispatch_msgs/ParsingServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ParsingService-request)))
  "Returns string type for a service object of type 'ParsingService-request"
  "rosplan_dispatch_msgs/ParsingServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ParsingService-request>)))
  "Returns md5sum for a message object of type '<ParsingService-request>"
  "30a7fd003c9a74d70dc3c96bf0a9476f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ParsingService-request)))
  "Returns md5sum for a message object of type 'ParsingService-request"
  "30a7fd003c9a74d70dc3c96bf0a9476f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ParsingService-request>)))
  "Returns full string definition for message of type '<ParsingService-request>"
  (cl:format cl:nil "# parses a plan from a file~%string plan_path~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ParsingService-request)))
  "Returns full string definition for message of type 'ParsingService-request"
  (cl:format cl:nil "# parses a plan from a file~%string plan_path~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ParsingService-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'plan_path))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ParsingService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ParsingService-request
    (cl:cons ':plan_path (plan_path msg))
))
;//! \htmlinclude ParsingService-response.msg.html

(cl:defclass <ParsingService-response> (roslisp-msg-protocol:ros-message)
  ((plan_parsed
    :reader plan_parsed
    :initarg :plan_parsed
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ParsingService-response (<ParsingService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ParsingService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ParsingService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_dispatch_msgs-srv:<ParsingService-response> is deprecated: use rosplan_dispatch_msgs-srv:ParsingService-response instead.")))

(cl:ensure-generic-function 'plan_parsed-val :lambda-list '(m))
(cl:defmethod plan_parsed-val ((m <ParsingService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-srv:plan_parsed-val is deprecated.  Use rosplan_dispatch_msgs-srv:plan_parsed instead.")
  (plan_parsed m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ParsingService-response>) ostream)
  "Serializes a message object of type '<ParsingService-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'plan_parsed) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ParsingService-response>) istream)
  "Deserializes a message object of type '<ParsingService-response>"
    (cl:setf (cl:slot-value msg 'plan_parsed) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ParsingService-response>)))
  "Returns string type for a service object of type '<ParsingService-response>"
  "rosplan_dispatch_msgs/ParsingServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ParsingService-response)))
  "Returns string type for a service object of type 'ParsingService-response"
  "rosplan_dispatch_msgs/ParsingServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ParsingService-response>)))
  "Returns md5sum for a message object of type '<ParsingService-response>"
  "30a7fd003c9a74d70dc3c96bf0a9476f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ParsingService-response)))
  "Returns md5sum for a message object of type 'ParsingService-response"
  "30a7fd003c9a74d70dc3c96bf0a9476f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ParsingService-response>)))
  "Returns full string definition for message of type '<ParsingService-response>"
  (cl:format cl:nil "bool plan_parsed~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ParsingService-response)))
  "Returns full string definition for message of type 'ParsingService-response"
  (cl:format cl:nil "bool plan_parsed~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ParsingService-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ParsingService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ParsingService-response
    (cl:cons ':plan_parsed (plan_parsed msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ParsingService)))
  'ParsingService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ParsingService)))
  'ParsingService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ParsingService)))
  "Returns string type for a service object of type '<ParsingService>"
  "rosplan_dispatch_msgs/ParsingService")