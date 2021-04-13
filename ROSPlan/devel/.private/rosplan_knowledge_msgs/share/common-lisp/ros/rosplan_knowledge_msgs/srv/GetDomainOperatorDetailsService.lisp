; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-srv)


;//! \htmlinclude GetDomainOperatorDetailsService-request.msg.html

(cl:defclass <GetDomainOperatorDetailsService-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform ""))
)

(cl:defclass GetDomainOperatorDetailsService-request (<GetDomainOperatorDetailsService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetDomainOperatorDetailsService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetDomainOperatorDetailsService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetDomainOperatorDetailsService-request> is deprecated: use rosplan_knowledge_msgs-srv:GetDomainOperatorDetailsService-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <GetDomainOperatorDetailsService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:name-val is deprecated.  Use rosplan_knowledge_msgs-srv:name instead.")
  (name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetDomainOperatorDetailsService-request>) ostream)
  "Serializes a message object of type '<GetDomainOperatorDetailsService-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetDomainOperatorDetailsService-request>) istream)
  "Deserializes a message object of type '<GetDomainOperatorDetailsService-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetDomainOperatorDetailsService-request>)))
  "Returns string type for a service object of type '<GetDomainOperatorDetailsService-request>"
  "rosplan_knowledge_msgs/GetDomainOperatorDetailsServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainOperatorDetailsService-request)))
  "Returns string type for a service object of type 'GetDomainOperatorDetailsService-request"
  "rosplan_knowledge_msgs/GetDomainOperatorDetailsServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetDomainOperatorDetailsService-request>)))
  "Returns md5sum for a message object of type '<GetDomainOperatorDetailsService-request>"
  "d1ca18637f3dfc6b50d99a8c3a27f01d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetDomainOperatorDetailsService-request)))
  "Returns md5sum for a message object of type 'GetDomainOperatorDetailsService-request"
  "d1ca18637f3dfc6b50d99a8c3a27f01d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetDomainOperatorDetailsService-request>)))
  "Returns full string definition for message of type '<GetDomainOperatorDetailsService-request>"
  (cl:format cl:nil "# Fetching the Domain (2.5/3):~%# Get all details of a specific operator in the domain.~%string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetDomainOperatorDetailsService-request)))
  "Returns full string definition for message of type 'GetDomainOperatorDetailsService-request"
  (cl:format cl:nil "# Fetching the Domain (2.5/3):~%# Get all details of a specific operator in the domain.~%string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetDomainOperatorDetailsService-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetDomainOperatorDetailsService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetDomainOperatorDetailsService-request
    (cl:cons ':name (name msg))
))
;//! \htmlinclude GetDomainOperatorDetailsService-response.msg.html

(cl:defclass <GetDomainOperatorDetailsService-response> (roslisp-msg-protocol:ros-message)
  ((op
    :reader op
    :initarg :op
    :type rosplan_knowledge_msgs-msg:DomainOperator
    :initform (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainOperator)))
)

(cl:defclass GetDomainOperatorDetailsService-response (<GetDomainOperatorDetailsService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetDomainOperatorDetailsService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetDomainOperatorDetailsService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetDomainOperatorDetailsService-response> is deprecated: use rosplan_knowledge_msgs-srv:GetDomainOperatorDetailsService-response instead.")))

(cl:ensure-generic-function 'op-val :lambda-list '(m))
(cl:defmethod op-val ((m <GetDomainOperatorDetailsService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:op-val is deprecated.  Use rosplan_knowledge_msgs-srv:op instead.")
  (op m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetDomainOperatorDetailsService-response>) ostream)
  "Serializes a message object of type '<GetDomainOperatorDetailsService-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'op) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetDomainOperatorDetailsService-response>) istream)
  "Deserializes a message object of type '<GetDomainOperatorDetailsService-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'op) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetDomainOperatorDetailsService-response>)))
  "Returns string type for a service object of type '<GetDomainOperatorDetailsService-response>"
  "rosplan_knowledge_msgs/GetDomainOperatorDetailsServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainOperatorDetailsService-response)))
  "Returns string type for a service object of type 'GetDomainOperatorDetailsService-response"
  "rosplan_knowledge_msgs/GetDomainOperatorDetailsServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetDomainOperatorDetailsService-response>)))
  "Returns md5sum for a message object of type '<GetDomainOperatorDetailsService-response>"
  "d1ca18637f3dfc6b50d99a8c3a27f01d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetDomainOperatorDetailsService-response)))
  "Returns md5sum for a message object of type 'GetDomainOperatorDetailsService-response"
  "d1ca18637f3dfc6b50d99a8c3a27f01d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetDomainOperatorDetailsService-response>)))
  "Returns full string definition for message of type '<GetDomainOperatorDetailsService-response>"
  (cl:format cl:nil "rosplan_knowledge_msgs/DomainOperator op~%~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainOperator~%# A message used to represent an ungrounded operator in the domain.~%~%# (1) name and parameters~%rosplan_knowledge_msgs/DomainFormula formula~%~%# (2) duration constraint~%~%~%# (3) effect lists~%rosplan_knowledge_msgs/DomainFormula[] at_start_add_effects~%rosplan_knowledge_msgs/DomainFormula[] at_start_del_effects~%rosplan_knowledge_msgs/DomainFormula[] at_end_add_effects~%rosplan_knowledge_msgs/DomainFormula[] at_end_del_effects~%rosplan_knowledge_msgs/DomainAssignment[] at_start_assign_effects~%rosplan_knowledge_msgs/DomainAssignment[] at_end_assign_effects~%~%# (4) conditions~%rosplan_knowledge_msgs/DomainFormula[] at_start_simple_condition~%rosplan_knowledge_msgs/DomainFormula[] over_all_simple_condition~%rosplan_knowledge_msgs/DomainFormula[] at_end_simple_condition~%rosplan_knowledge_msgs/DomainFormula[] at_start_neg_condition~%rosplan_knowledge_msgs/DomainFormula[] over_all_neg_condition~%rosplan_knowledge_msgs/DomainFormula[] at_end_neg_condition~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainAssignment~%# A message used to store the numeric effects of an action~%# Can be grounded or ungrounded~%~%uint8 ASSIGN   = 0~%uint8 INCREASE  = 1~%uint8 DECREASE = 2~%uint8 SCALE_UP = 3~%uint8 SCALE_DOWN = 4~%uint8 ASSIGN_CTS = 5~%~%uint8 assign_type~%~%rosplan_knowledge_msgs/DomainFormula LHS~%rosplan_knowledge_msgs/ExprComposite RHS~%~%bool grounded~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprComposite~%# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetDomainOperatorDetailsService-response)))
  "Returns full string definition for message of type 'GetDomainOperatorDetailsService-response"
  (cl:format cl:nil "rosplan_knowledge_msgs/DomainOperator op~%~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainOperator~%# A message used to represent an ungrounded operator in the domain.~%~%# (1) name and parameters~%rosplan_knowledge_msgs/DomainFormula formula~%~%# (2) duration constraint~%~%~%# (3) effect lists~%rosplan_knowledge_msgs/DomainFormula[] at_start_add_effects~%rosplan_knowledge_msgs/DomainFormula[] at_start_del_effects~%rosplan_knowledge_msgs/DomainFormula[] at_end_add_effects~%rosplan_knowledge_msgs/DomainFormula[] at_end_del_effects~%rosplan_knowledge_msgs/DomainAssignment[] at_start_assign_effects~%rosplan_knowledge_msgs/DomainAssignment[] at_end_assign_effects~%~%# (4) conditions~%rosplan_knowledge_msgs/DomainFormula[] at_start_simple_condition~%rosplan_knowledge_msgs/DomainFormula[] over_all_simple_condition~%rosplan_knowledge_msgs/DomainFormula[] at_end_simple_condition~%rosplan_knowledge_msgs/DomainFormula[] at_start_neg_condition~%rosplan_knowledge_msgs/DomainFormula[] over_all_neg_condition~%rosplan_knowledge_msgs/DomainFormula[] at_end_neg_condition~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainAssignment~%# A message used to store the numeric effects of an action~%# Can be grounded or ungrounded~%~%uint8 ASSIGN   = 0~%uint8 INCREASE  = 1~%uint8 DECREASE = 2~%uint8 SCALE_UP = 3~%uint8 SCALE_DOWN = 4~%uint8 ASSIGN_CTS = 5~%~%uint8 assign_type~%~%rosplan_knowledge_msgs/DomainFormula LHS~%rosplan_knowledge_msgs/ExprComposite RHS~%~%bool grounded~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprComposite~%# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetDomainOperatorDetailsService-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'op))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetDomainOperatorDetailsService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetDomainOperatorDetailsService-response
    (cl:cons ':op (op msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetDomainOperatorDetailsService)))
  'GetDomainOperatorDetailsService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetDomainOperatorDetailsService)))
  'GetDomainOperatorDetailsService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainOperatorDetailsService)))
  "Returns string type for a service object of type '<GetDomainOperatorDetailsService>"
  "rosplan_knowledge_msgs/GetDomainOperatorDetailsService")