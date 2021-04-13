; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-srv)


;//! \htmlinclude GetDomainAttributeService-request.msg.html

(cl:defclass <GetDomainAttributeService-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass GetDomainAttributeService-request (<GetDomainAttributeService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetDomainAttributeService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetDomainAttributeService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetDomainAttributeService-request> is deprecated: use rosplan_knowledge_msgs-srv:GetDomainAttributeService-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetDomainAttributeService-request>) ostream)
  "Serializes a message object of type '<GetDomainAttributeService-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetDomainAttributeService-request>) istream)
  "Deserializes a message object of type '<GetDomainAttributeService-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetDomainAttributeService-request>)))
  "Returns string type for a service object of type '<GetDomainAttributeService-request>"
  "rosplan_knowledge_msgs/GetDomainAttributeServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainAttributeService-request)))
  "Returns string type for a service object of type 'GetDomainAttributeService-request"
  "rosplan_knowledge_msgs/GetDomainAttributeServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetDomainAttributeService-request>)))
  "Returns md5sum for a message object of type '<GetDomainAttributeService-request>"
  "900aa034059a0ceeaa146f6ab4b7e066")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetDomainAttributeService-request)))
  "Returns md5sum for a message object of type 'GetDomainAttributeService-request"
  "900aa034059a0ceeaa146f6ab4b7e066")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetDomainAttributeService-request>)))
  "Returns full string definition for message of type '<GetDomainAttributeService-request>"
  (cl:format cl:nil "# Fetching the Domain (3/3):~%# Get all predicates or functions in the domain.~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetDomainAttributeService-request)))
  "Returns full string definition for message of type 'GetDomainAttributeService-request"
  (cl:format cl:nil "# Fetching the Domain (3/3):~%# Get all predicates or functions in the domain.~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetDomainAttributeService-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetDomainAttributeService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetDomainAttributeService-request
))
;//! \htmlinclude GetDomainAttributeService-response.msg.html

(cl:defclass <GetDomainAttributeService-response> (roslisp-msg-protocol:ros-message)
  ((items
    :reader items
    :initarg :items
    :type (cl:vector rosplan_knowledge_msgs-msg:DomainFormula)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:DomainFormula :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula))))
)

(cl:defclass GetDomainAttributeService-response (<GetDomainAttributeService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetDomainAttributeService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetDomainAttributeService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetDomainAttributeService-response> is deprecated: use rosplan_knowledge_msgs-srv:GetDomainAttributeService-response instead.")))

(cl:ensure-generic-function 'items-val :lambda-list '(m))
(cl:defmethod items-val ((m <GetDomainAttributeService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:items-val is deprecated.  Use rosplan_knowledge_msgs-srv:items instead.")
  (items m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetDomainAttributeService-response>) ostream)
  "Serializes a message object of type '<GetDomainAttributeService-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'items))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'items))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetDomainAttributeService-response>) istream)
  "Deserializes a message object of type '<GetDomainAttributeService-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'items) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'items)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetDomainAttributeService-response>)))
  "Returns string type for a service object of type '<GetDomainAttributeService-response>"
  "rosplan_knowledge_msgs/GetDomainAttributeServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainAttributeService-response)))
  "Returns string type for a service object of type 'GetDomainAttributeService-response"
  "rosplan_knowledge_msgs/GetDomainAttributeServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetDomainAttributeService-response>)))
  "Returns md5sum for a message object of type '<GetDomainAttributeService-response>"
  "900aa034059a0ceeaa146f6ab4b7e066")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetDomainAttributeService-response)))
  "Returns md5sum for a message object of type 'GetDomainAttributeService-response"
  "900aa034059a0ceeaa146f6ab4b7e066")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetDomainAttributeService-response>)))
  "Returns full string definition for message of type '<GetDomainAttributeService-response>"
  (cl:format cl:nil "rosplan_knowledge_msgs/DomainFormula[] items~%~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetDomainAttributeService-response)))
  "Returns full string definition for message of type 'GetDomainAttributeService-response"
  (cl:format cl:nil "rosplan_knowledge_msgs/DomainFormula[] items~%~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetDomainAttributeService-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'items) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetDomainAttributeService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetDomainAttributeService-response
    (cl:cons ':items (items msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetDomainAttributeService)))
  'GetDomainAttributeService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetDomainAttributeService)))
  'GetDomainAttributeService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainAttributeService)))
  "Returns string type for a service object of type '<GetDomainAttributeService>"
  "rosplan_knowledge_msgs/GetDomainAttributeService")