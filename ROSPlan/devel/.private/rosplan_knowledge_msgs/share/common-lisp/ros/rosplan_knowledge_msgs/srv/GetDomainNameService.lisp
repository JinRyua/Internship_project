; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-srv)


;//! \htmlinclude GetDomainNameService-request.msg.html

(cl:defclass <GetDomainNameService-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass GetDomainNameService-request (<GetDomainNameService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetDomainNameService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetDomainNameService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetDomainNameService-request> is deprecated: use rosplan_knowledge_msgs-srv:GetDomainNameService-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetDomainNameService-request>) ostream)
  "Serializes a message object of type '<GetDomainNameService-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetDomainNameService-request>) istream)
  "Deserializes a message object of type '<GetDomainNameService-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetDomainNameService-request>)))
  "Returns string type for a service object of type '<GetDomainNameService-request>"
  "rosplan_knowledge_msgs/GetDomainNameServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainNameService-request)))
  "Returns string type for a service object of type 'GetDomainNameService-request"
  "rosplan_knowledge_msgs/GetDomainNameServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetDomainNameService-request>)))
  "Returns md5sum for a message object of type '<GetDomainNameService-request>"
  "60174b39a7780212f0384c8d050df5a0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetDomainNameService-request)))
  "Returns md5sum for a message object of type 'GetDomainNameService-request"
  "60174b39a7780212f0384c8d050df5a0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetDomainNameService-request>)))
  "Returns full string definition for message of type '<GetDomainNameService-request>"
  (cl:format cl:nil "# Fetching the Domain (0/3):~%# Get the domain name.~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetDomainNameService-request)))
  "Returns full string definition for message of type 'GetDomainNameService-request"
  (cl:format cl:nil "# Fetching the Domain (0/3):~%# Get the domain name.~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetDomainNameService-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetDomainNameService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetDomainNameService-request
))
;//! \htmlinclude GetDomainNameService-response.msg.html

(cl:defclass <GetDomainNameService-response> (roslisp-msg-protocol:ros-message)
  ((domain_name
    :reader domain_name
    :initarg :domain_name
    :type cl:string
    :initform ""))
)

(cl:defclass GetDomainNameService-response (<GetDomainNameService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetDomainNameService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetDomainNameService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetDomainNameService-response> is deprecated: use rosplan_knowledge_msgs-srv:GetDomainNameService-response instead.")))

(cl:ensure-generic-function 'domain_name-val :lambda-list '(m))
(cl:defmethod domain_name-val ((m <GetDomainNameService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:domain_name-val is deprecated.  Use rosplan_knowledge_msgs-srv:domain_name instead.")
  (domain_name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetDomainNameService-response>) ostream)
  "Serializes a message object of type '<GetDomainNameService-response>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'domain_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'domain_name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetDomainNameService-response>) istream)
  "Deserializes a message object of type '<GetDomainNameService-response>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'domain_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'domain_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetDomainNameService-response>)))
  "Returns string type for a service object of type '<GetDomainNameService-response>"
  "rosplan_knowledge_msgs/GetDomainNameServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainNameService-response)))
  "Returns string type for a service object of type 'GetDomainNameService-response"
  "rosplan_knowledge_msgs/GetDomainNameServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetDomainNameService-response>)))
  "Returns md5sum for a message object of type '<GetDomainNameService-response>"
  "60174b39a7780212f0384c8d050df5a0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetDomainNameService-response)))
  "Returns md5sum for a message object of type 'GetDomainNameService-response"
  "60174b39a7780212f0384c8d050df5a0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetDomainNameService-response>)))
  "Returns full string definition for message of type '<GetDomainNameService-response>"
  (cl:format cl:nil "string domain_name~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetDomainNameService-response)))
  "Returns full string definition for message of type 'GetDomainNameService-response"
  (cl:format cl:nil "string domain_name~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetDomainNameService-response>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'domain_name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetDomainNameService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetDomainNameService-response
    (cl:cons ':domain_name (domain_name msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetDomainNameService)))
  'GetDomainNameService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetDomainNameService)))
  'GetDomainNameService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainNameService)))
  "Returns string type for a service object of type '<GetDomainNameService>"
  "rosplan_knowledge_msgs/GetDomainNameService")