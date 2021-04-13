; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-srv)


;//! \htmlinclude GetDomainOperatorService-request.msg.html

(cl:defclass <GetDomainOperatorService-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass GetDomainOperatorService-request (<GetDomainOperatorService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetDomainOperatorService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetDomainOperatorService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetDomainOperatorService-request> is deprecated: use rosplan_knowledge_msgs-srv:GetDomainOperatorService-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetDomainOperatorService-request>) ostream)
  "Serializes a message object of type '<GetDomainOperatorService-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetDomainOperatorService-request>) istream)
  "Deserializes a message object of type '<GetDomainOperatorService-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetDomainOperatorService-request>)))
  "Returns string type for a service object of type '<GetDomainOperatorService-request>"
  "rosplan_knowledge_msgs/GetDomainOperatorServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainOperatorService-request)))
  "Returns string type for a service object of type 'GetDomainOperatorService-request"
  "rosplan_knowledge_msgs/GetDomainOperatorServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetDomainOperatorService-request>)))
  "Returns md5sum for a message object of type '<GetDomainOperatorService-request>"
  "01315931b687093b9f4ca53107f02d57")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetDomainOperatorService-request)))
  "Returns md5sum for a message object of type 'GetDomainOperatorService-request"
  "01315931b687093b9f4ca53107f02d57")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetDomainOperatorService-request>)))
  "Returns full string definition for message of type '<GetDomainOperatorService-request>"
  (cl:format cl:nil "# Fetching the Domain (2/3):~%# Get all operators in the domain.~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetDomainOperatorService-request)))
  "Returns full string definition for message of type 'GetDomainOperatorService-request"
  (cl:format cl:nil "# Fetching the Domain (2/3):~%# Get all operators in the domain.~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetDomainOperatorService-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetDomainOperatorService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetDomainOperatorService-request
))
;//! \htmlinclude GetDomainOperatorService-response.msg.html

(cl:defclass <GetDomainOperatorService-response> (roslisp-msg-protocol:ros-message)
  ((operators
    :reader operators
    :initarg :operators
    :type (cl:vector rosplan_knowledge_msgs-msg:DomainFormula)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:DomainFormula :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula))))
)

(cl:defclass GetDomainOperatorService-response (<GetDomainOperatorService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetDomainOperatorService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetDomainOperatorService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetDomainOperatorService-response> is deprecated: use rosplan_knowledge_msgs-srv:GetDomainOperatorService-response instead.")))

(cl:ensure-generic-function 'operators-val :lambda-list '(m))
(cl:defmethod operators-val ((m <GetDomainOperatorService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:operators-val is deprecated.  Use rosplan_knowledge_msgs-srv:operators instead.")
  (operators m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetDomainOperatorService-response>) ostream)
  "Serializes a message object of type '<GetDomainOperatorService-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'operators))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'operators))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetDomainOperatorService-response>) istream)
  "Deserializes a message object of type '<GetDomainOperatorService-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'operators) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'operators)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetDomainOperatorService-response>)))
  "Returns string type for a service object of type '<GetDomainOperatorService-response>"
  "rosplan_knowledge_msgs/GetDomainOperatorServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainOperatorService-response)))
  "Returns string type for a service object of type 'GetDomainOperatorService-response"
  "rosplan_knowledge_msgs/GetDomainOperatorServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetDomainOperatorService-response>)))
  "Returns md5sum for a message object of type '<GetDomainOperatorService-response>"
  "01315931b687093b9f4ca53107f02d57")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetDomainOperatorService-response)))
  "Returns md5sum for a message object of type 'GetDomainOperatorService-response"
  "01315931b687093b9f4ca53107f02d57")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetDomainOperatorService-response>)))
  "Returns full string definition for message of type '<GetDomainOperatorService-response>"
  (cl:format cl:nil "rosplan_knowledge_msgs/DomainFormula[] operators~%~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetDomainOperatorService-response)))
  "Returns full string definition for message of type 'GetDomainOperatorService-response"
  (cl:format cl:nil "rosplan_knowledge_msgs/DomainFormula[] operators~%~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetDomainOperatorService-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'operators) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetDomainOperatorService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetDomainOperatorService-response
    (cl:cons ':operators (operators msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetDomainOperatorService)))
  'GetDomainOperatorService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetDomainOperatorService)))
  'GetDomainOperatorService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainOperatorService)))
  "Returns string type for a service object of type '<GetDomainOperatorService>"
  "rosplan_knowledge_msgs/GetDomainOperatorService")