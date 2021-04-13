; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-srv)


;//! \htmlinclude GetDomainPredicateDetailsService-request.msg.html

(cl:defclass <GetDomainPredicateDetailsService-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform ""))
)

(cl:defclass GetDomainPredicateDetailsService-request (<GetDomainPredicateDetailsService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetDomainPredicateDetailsService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetDomainPredicateDetailsService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetDomainPredicateDetailsService-request> is deprecated: use rosplan_knowledge_msgs-srv:GetDomainPredicateDetailsService-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <GetDomainPredicateDetailsService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:name-val is deprecated.  Use rosplan_knowledge_msgs-srv:name instead.")
  (name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetDomainPredicateDetailsService-request>) ostream)
  "Serializes a message object of type '<GetDomainPredicateDetailsService-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetDomainPredicateDetailsService-request>) istream)
  "Deserializes a message object of type '<GetDomainPredicateDetailsService-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetDomainPredicateDetailsService-request>)))
  "Returns string type for a service object of type '<GetDomainPredicateDetailsService-request>"
  "rosplan_knowledge_msgs/GetDomainPredicateDetailsServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainPredicateDetailsService-request)))
  "Returns string type for a service object of type 'GetDomainPredicateDetailsService-request"
  "rosplan_knowledge_msgs/GetDomainPredicateDetailsServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetDomainPredicateDetailsService-request>)))
  "Returns md5sum for a message object of type '<GetDomainPredicateDetailsService-request>"
  "a2d0df3018ceb22168c64e3d02f01b80")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetDomainPredicateDetailsService-request)))
  "Returns md5sum for a message object of type 'GetDomainPredicateDetailsService-request"
  "a2d0df3018ceb22168c64e3d02f01b80")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetDomainPredicateDetailsService-request>)))
  "Returns full string definition for message of type '<GetDomainPredicateDetailsService-request>"
  (cl:format cl:nil "# Fetching the Domain (1.5/3):~%# Get all details of a specific predicate in the domain.~%string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetDomainPredicateDetailsService-request)))
  "Returns full string definition for message of type 'GetDomainPredicateDetailsService-request"
  (cl:format cl:nil "# Fetching the Domain (1.5/3):~%# Get all details of a specific predicate in the domain.~%string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetDomainPredicateDetailsService-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetDomainPredicateDetailsService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetDomainPredicateDetailsService-request
    (cl:cons ':name (name msg))
))
;//! \htmlinclude GetDomainPredicateDetailsService-response.msg.html

(cl:defclass <GetDomainPredicateDetailsService-response> (roslisp-msg-protocol:ros-message)
  ((predicate
    :reader predicate
    :initarg :predicate
    :type rosplan_knowledge_msgs-msg:DomainFormula
    :initform (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula)))
)

(cl:defclass GetDomainPredicateDetailsService-response (<GetDomainPredicateDetailsService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetDomainPredicateDetailsService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetDomainPredicateDetailsService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetDomainPredicateDetailsService-response> is deprecated: use rosplan_knowledge_msgs-srv:GetDomainPredicateDetailsService-response instead.")))

(cl:ensure-generic-function 'predicate-val :lambda-list '(m))
(cl:defmethod predicate-val ((m <GetDomainPredicateDetailsService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:predicate-val is deprecated.  Use rosplan_knowledge_msgs-srv:predicate instead.")
  (predicate m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetDomainPredicateDetailsService-response>) ostream)
  "Serializes a message object of type '<GetDomainPredicateDetailsService-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'predicate) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetDomainPredicateDetailsService-response>) istream)
  "Deserializes a message object of type '<GetDomainPredicateDetailsService-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'predicate) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetDomainPredicateDetailsService-response>)))
  "Returns string type for a service object of type '<GetDomainPredicateDetailsService-response>"
  "rosplan_knowledge_msgs/GetDomainPredicateDetailsServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainPredicateDetailsService-response)))
  "Returns string type for a service object of type 'GetDomainPredicateDetailsService-response"
  "rosplan_knowledge_msgs/GetDomainPredicateDetailsServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetDomainPredicateDetailsService-response>)))
  "Returns md5sum for a message object of type '<GetDomainPredicateDetailsService-response>"
  "a2d0df3018ceb22168c64e3d02f01b80")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetDomainPredicateDetailsService-response)))
  "Returns md5sum for a message object of type 'GetDomainPredicateDetailsService-response"
  "a2d0df3018ceb22168c64e3d02f01b80")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetDomainPredicateDetailsService-response>)))
  "Returns full string definition for message of type '<GetDomainPredicateDetailsService-response>"
  (cl:format cl:nil "rosplan_knowledge_msgs/DomainFormula predicate~%~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetDomainPredicateDetailsService-response)))
  "Returns full string definition for message of type 'GetDomainPredicateDetailsService-response"
  (cl:format cl:nil "rosplan_knowledge_msgs/DomainFormula predicate~%~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetDomainPredicateDetailsService-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'predicate))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetDomainPredicateDetailsService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetDomainPredicateDetailsService-response
    (cl:cons ':predicate (predicate msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetDomainPredicateDetailsService)))
  'GetDomainPredicateDetailsService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetDomainPredicateDetailsService)))
  'GetDomainPredicateDetailsService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainPredicateDetailsService)))
  "Returns string type for a service object of type '<GetDomainPredicateDetailsService>"
  "rosplan_knowledge_msgs/GetDomainPredicateDetailsService")