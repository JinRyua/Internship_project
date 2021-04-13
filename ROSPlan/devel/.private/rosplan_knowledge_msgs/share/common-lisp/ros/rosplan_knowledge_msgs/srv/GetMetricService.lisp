; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-srv)


;//! \htmlinclude GetMetricService-request.msg.html

(cl:defclass <GetMetricService-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass GetMetricService-request (<GetMetricService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetMetricService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetMetricService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetMetricService-request> is deprecated: use rosplan_knowledge_msgs-srv:GetMetricService-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetMetricService-request>) ostream)
  "Serializes a message object of type '<GetMetricService-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetMetricService-request>) istream)
  "Deserializes a message object of type '<GetMetricService-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetMetricService-request>)))
  "Returns string type for a service object of type '<GetMetricService-request>"
  "rosplan_knowledge_msgs/GetMetricServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetMetricService-request)))
  "Returns string type for a service object of type 'GetMetricService-request"
  "rosplan_knowledge_msgs/GetMetricServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetMetricService-request>)))
  "Returns md5sum for a message object of type '<GetMetricService-request>"
  "d8654505c165321f0d5dd974ec4ca392")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetMetricService-request)))
  "Returns md5sum for a message object of type 'GetMetricService-request"
  "d8654505c165321f0d5dd974ec4ca392")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetMetricService-request>)))
  "Returns full string definition for message of type '<GetMetricService-request>"
  (cl:format cl:nil "# PDDL problem generation; service(3/3):~%# Get the problem metric.~%# The result is passed as a KnowledgeItem, where the value needs to be parsed by the program.~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetMetricService-request)))
  "Returns full string definition for message of type 'GetMetricService-request"
  (cl:format cl:nil "# PDDL problem generation; service(3/3):~%# Get the problem metric.~%# The result is passed as a KnowledgeItem, where the value needs to be parsed by the program.~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetMetricService-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetMetricService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetMetricService-request
))
;//! \htmlinclude GetMetricService-response.msg.html

(cl:defclass <GetMetricService-response> (roslisp-msg-protocol:ros-message)
  ((metric
    :reader metric
    :initarg :metric
    :type rosplan_knowledge_msgs-msg:KnowledgeItem
    :initform (cl:make-instance 'rosplan_knowledge_msgs-msg:KnowledgeItem)))
)

(cl:defclass GetMetricService-response (<GetMetricService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetMetricService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetMetricService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetMetricService-response> is deprecated: use rosplan_knowledge_msgs-srv:GetMetricService-response instead.")))

(cl:ensure-generic-function 'metric-val :lambda-list '(m))
(cl:defmethod metric-val ((m <GetMetricService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:metric-val is deprecated.  Use rosplan_knowledge_msgs-srv:metric instead.")
  (metric m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetMetricService-response>) ostream)
  "Serializes a message object of type '<GetMetricService-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'metric) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetMetricService-response>) istream)
  "Deserializes a message object of type '<GetMetricService-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'metric) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetMetricService-response>)))
  "Returns string type for a service object of type '<GetMetricService-response>"
  "rosplan_knowledge_msgs/GetMetricServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetMetricService-response)))
  "Returns string type for a service object of type 'GetMetricService-response"
  "rosplan_knowledge_msgs/GetMetricServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetMetricService-response>)))
  "Returns md5sum for a message object of type '<GetMetricService-response>"
  "d8654505c165321f0d5dd974ec4ca392")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetMetricService-response)))
  "Returns md5sum for a message object of type 'GetMetricService-response"
  "d8654505c165321f0d5dd974ec4ca392")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetMetricService-response>)))
  "Returns full string definition for message of type '<GetMetricService-response>"
  (cl:format cl:nil "rosplan_knowledge_msgs/KnowledgeItem metric~%~%~%================================================================================~%MSG: rosplan_knowledge_msgs/KnowledgeItem~%# A knowledge item used to represent a piece of the state in ROSPlan~%~%uint8 INSTANCE = 0~%uint8 FACT = 1~%uint8 FUNCTION = 2~%uint8 EXPRESSION = 3~%uint8 INEQUALITY = 4~%~%uint8 knowledge_type~%~%# time at which this knowledge becomes true~%time initial_time~%~%# knowledge is explicitly false~%bool is_negative~%~%#---------~%# INSTANCE~%#---------~%~%# instance knowledge_type~%string instance_type~%string instance_name~%~%#----------------------~%# PREDICATE OR FUNCTION~%#----------------------~%~%# attribute knowledge_type~%string attribute_name~%diagnostic_msgs/KeyValue[] values~%~%#---------~%# FUNCTION~%#---------~%~%# function value~%float64 function_value~%~%#-----------~%# EXPRESSION~%#-----------~%~%string optimization~%rosplan_knowledge_msgs/ExprComposite expr~%~%#-----------~%# INEQUALITY~%#-----------~%~%rosplan_knowledge_msgs/DomainInequality ineq~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprComposite~%# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainInequality~%# A message used to store the numeric effects of an action~%# Can be grounded or ungrounded~%~%uint8 GREATER   = 0~%uint8 GREATEREQ = 1~%uint8 LESS      = 2~%uint8 LESSEQ    = 3~%uint8 EQUALS    = 4~%~%uint8 comparison_type~%~%rosplan_knowledge_msgs/ExprComposite LHS~%rosplan_knowledge_msgs/ExprComposite RHS~%~%bool grounded~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetMetricService-response)))
  "Returns full string definition for message of type 'GetMetricService-response"
  (cl:format cl:nil "rosplan_knowledge_msgs/KnowledgeItem metric~%~%~%================================================================================~%MSG: rosplan_knowledge_msgs/KnowledgeItem~%# A knowledge item used to represent a piece of the state in ROSPlan~%~%uint8 INSTANCE = 0~%uint8 FACT = 1~%uint8 FUNCTION = 2~%uint8 EXPRESSION = 3~%uint8 INEQUALITY = 4~%~%uint8 knowledge_type~%~%# time at which this knowledge becomes true~%time initial_time~%~%# knowledge is explicitly false~%bool is_negative~%~%#---------~%# INSTANCE~%#---------~%~%# instance knowledge_type~%string instance_type~%string instance_name~%~%#----------------------~%# PREDICATE OR FUNCTION~%#----------------------~%~%# attribute knowledge_type~%string attribute_name~%diagnostic_msgs/KeyValue[] values~%~%#---------~%# FUNCTION~%#---------~%~%# function value~%float64 function_value~%~%#-----------~%# EXPRESSION~%#-----------~%~%string optimization~%rosplan_knowledge_msgs/ExprComposite expr~%~%#-----------~%# INEQUALITY~%#-----------~%~%rosplan_knowledge_msgs/DomainInequality ineq~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprComposite~%# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainInequality~%# A message used to store the numeric effects of an action~%# Can be grounded or ungrounded~%~%uint8 GREATER   = 0~%uint8 GREATEREQ = 1~%uint8 LESS      = 2~%uint8 LESSEQ    = 3~%uint8 EQUALS    = 4~%~%uint8 comparison_type~%~%rosplan_knowledge_msgs/ExprComposite LHS~%rosplan_knowledge_msgs/ExprComposite RHS~%~%bool grounded~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetMetricService-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'metric))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetMetricService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetMetricService-response
    (cl:cons ':metric (metric msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetMetricService)))
  'GetMetricService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetMetricService)))
  'GetMetricService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetMetricService)))
  "Returns string type for a service object of type '<GetMetricService>"
  "rosplan_knowledge_msgs/GetMetricService")