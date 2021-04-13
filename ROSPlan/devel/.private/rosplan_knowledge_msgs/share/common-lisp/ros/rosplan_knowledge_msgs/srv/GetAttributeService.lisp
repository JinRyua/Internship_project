; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-srv)


;//! \htmlinclude GetAttributeService-request.msg.html

(cl:defclass <GetAttributeService-request> (roslisp-msg-protocol:ros-message)
  ((predicate_name
    :reader predicate_name
    :initarg :predicate_name
    :type cl:string
    :initform ""))
)

(cl:defclass GetAttributeService-request (<GetAttributeService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetAttributeService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetAttributeService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetAttributeService-request> is deprecated: use rosplan_knowledge_msgs-srv:GetAttributeService-request instead.")))

(cl:ensure-generic-function 'predicate_name-val :lambda-list '(m))
(cl:defmethod predicate_name-val ((m <GetAttributeService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:predicate_name-val is deprecated.  Use rosplan_knowledge_msgs-srv:predicate_name instead.")
  (predicate_name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetAttributeService-request>) ostream)
  "Serializes a message object of type '<GetAttributeService-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'predicate_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'predicate_name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetAttributeService-request>) istream)
  "Deserializes a message object of type '<GetAttributeService-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'predicate_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'predicate_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetAttributeService-request>)))
  "Returns string type for a service object of type '<GetAttributeService-request>"
  "rosplan_knowledge_msgs/GetAttributeServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetAttributeService-request)))
  "Returns string type for a service object of type 'GetAttributeService-request"
  "rosplan_knowledge_msgs/GetAttributeServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetAttributeService-request>)))
  "Returns md5sum for a message object of type '<GetAttributeService-request>"
  "fe78089058f9089ebe2902711c474ad4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetAttributeService-request)))
  "Returns md5sum for a message object of type 'GetAttributeService-request"
  "fe78089058f9089ebe2902711c474ad4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetAttributeService-request>)))
  "Returns full string definition for message of type '<GetAttributeService-request>"
  (cl:format cl:nil "# PDDL problem generation; service(2/3):~%# Get all facts (or functions) by predicate name (or function name).~%# The results are passed as an array of KnowledgeItems~%# The array of initial_time is used for TILs and TIFs not yet active~%string predicate_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetAttributeService-request)))
  "Returns full string definition for message of type 'GetAttributeService-request"
  (cl:format cl:nil "# PDDL problem generation; service(2/3):~%# Get all facts (or functions) by predicate name (or function name).~%# The results are passed as an array of KnowledgeItems~%# The array of initial_time is used for TILs and TIFs not yet active~%string predicate_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetAttributeService-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'predicate_name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetAttributeService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetAttributeService-request
    (cl:cons ':predicate_name (predicate_name msg))
))
;//! \htmlinclude GetAttributeService-response.msg.html

(cl:defclass <GetAttributeService-response> (roslisp-msg-protocol:ros-message)
  ((attributes
    :reader attributes
    :initarg :attributes
    :type (cl:vector rosplan_knowledge_msgs-msg:KnowledgeItem)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:KnowledgeItem :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:KnowledgeItem))))
)

(cl:defclass GetAttributeService-response (<GetAttributeService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetAttributeService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetAttributeService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetAttributeService-response> is deprecated: use rosplan_knowledge_msgs-srv:GetAttributeService-response instead.")))

(cl:ensure-generic-function 'attributes-val :lambda-list '(m))
(cl:defmethod attributes-val ((m <GetAttributeService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:attributes-val is deprecated.  Use rosplan_knowledge_msgs-srv:attributes instead.")
  (attributes m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetAttributeService-response>) ostream)
  "Serializes a message object of type '<GetAttributeService-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'attributes))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'attributes))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetAttributeService-response>) istream)
  "Deserializes a message object of type '<GetAttributeService-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'attributes) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'attributes)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:KnowledgeItem))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetAttributeService-response>)))
  "Returns string type for a service object of type '<GetAttributeService-response>"
  "rosplan_knowledge_msgs/GetAttributeServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetAttributeService-response)))
  "Returns string type for a service object of type 'GetAttributeService-response"
  "rosplan_knowledge_msgs/GetAttributeServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetAttributeService-response>)))
  "Returns md5sum for a message object of type '<GetAttributeService-response>"
  "fe78089058f9089ebe2902711c474ad4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetAttributeService-response)))
  "Returns md5sum for a message object of type 'GetAttributeService-response"
  "fe78089058f9089ebe2902711c474ad4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetAttributeService-response>)))
  "Returns full string definition for message of type '<GetAttributeService-response>"
  (cl:format cl:nil "rosplan_knowledge_msgs/KnowledgeItem[] attributes~%~%~%================================================================================~%MSG: rosplan_knowledge_msgs/KnowledgeItem~%# A knowledge item used to represent a piece of the state in ROSPlan~%~%uint8 INSTANCE = 0~%uint8 FACT = 1~%uint8 FUNCTION = 2~%uint8 EXPRESSION = 3~%uint8 INEQUALITY = 4~%~%uint8 knowledge_type~%~%# time at which this knowledge becomes true~%time initial_time~%~%# knowledge is explicitly false~%bool is_negative~%~%#---------~%# INSTANCE~%#---------~%~%# instance knowledge_type~%string instance_type~%string instance_name~%~%#----------------------~%# PREDICATE OR FUNCTION~%#----------------------~%~%# attribute knowledge_type~%string attribute_name~%diagnostic_msgs/KeyValue[] values~%~%#---------~%# FUNCTION~%#---------~%~%# function value~%float64 function_value~%~%#-----------~%# EXPRESSION~%#-----------~%~%string optimization~%rosplan_knowledge_msgs/ExprComposite expr~%~%#-----------~%# INEQUALITY~%#-----------~%~%rosplan_knowledge_msgs/DomainInequality ineq~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprComposite~%# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainInequality~%# A message used to store the numeric effects of an action~%# Can be grounded or ungrounded~%~%uint8 GREATER   = 0~%uint8 GREATEREQ = 1~%uint8 LESS      = 2~%uint8 LESSEQ    = 3~%uint8 EQUALS    = 4~%~%uint8 comparison_type~%~%rosplan_knowledge_msgs/ExprComposite LHS~%rosplan_knowledge_msgs/ExprComposite RHS~%~%bool grounded~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetAttributeService-response)))
  "Returns full string definition for message of type 'GetAttributeService-response"
  (cl:format cl:nil "rosplan_knowledge_msgs/KnowledgeItem[] attributes~%~%~%================================================================================~%MSG: rosplan_knowledge_msgs/KnowledgeItem~%# A knowledge item used to represent a piece of the state in ROSPlan~%~%uint8 INSTANCE = 0~%uint8 FACT = 1~%uint8 FUNCTION = 2~%uint8 EXPRESSION = 3~%uint8 INEQUALITY = 4~%~%uint8 knowledge_type~%~%# time at which this knowledge becomes true~%time initial_time~%~%# knowledge is explicitly false~%bool is_negative~%~%#---------~%# INSTANCE~%#---------~%~%# instance knowledge_type~%string instance_type~%string instance_name~%~%#----------------------~%# PREDICATE OR FUNCTION~%#----------------------~%~%# attribute knowledge_type~%string attribute_name~%diagnostic_msgs/KeyValue[] values~%~%#---------~%# FUNCTION~%#---------~%~%# function value~%float64 function_value~%~%#-----------~%# EXPRESSION~%#-----------~%~%string optimization~%rosplan_knowledge_msgs/ExprComposite expr~%~%#-----------~%# INEQUALITY~%#-----------~%~%rosplan_knowledge_msgs/DomainInequality ineq~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprComposite~%# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainInequality~%# A message used to store the numeric effects of an action~%# Can be grounded or ungrounded~%~%uint8 GREATER   = 0~%uint8 GREATEREQ = 1~%uint8 LESS      = 2~%uint8 LESSEQ    = 3~%uint8 EQUALS    = 4~%~%uint8 comparison_type~%~%rosplan_knowledge_msgs/ExprComposite LHS~%rosplan_knowledge_msgs/ExprComposite RHS~%~%bool grounded~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetAttributeService-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'attributes) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetAttributeService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetAttributeService-response
    (cl:cons ':attributes (attributes msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetAttributeService)))
  'GetAttributeService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetAttributeService)))
  'GetAttributeService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetAttributeService)))
  "Returns string type for a service object of type '<GetAttributeService>"
  "rosplan_knowledge_msgs/GetAttributeService")