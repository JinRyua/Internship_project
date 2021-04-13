; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-srv)


;//! \htmlinclude KnowledgeUpdateService-request.msg.html

(cl:defclass <KnowledgeUpdateService-request> (roslisp-msg-protocol:ros-message)
  ((update_type
    :reader update_type
    :initarg :update_type
    :type cl:fixnum
    :initform 0)
   (knowledge
    :reader knowledge
    :initarg :knowledge
    :type rosplan_knowledge_msgs-msg:KnowledgeItem
    :initform (cl:make-instance 'rosplan_knowledge_msgs-msg:KnowledgeItem)))
)

(cl:defclass KnowledgeUpdateService-request (<KnowledgeUpdateService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <KnowledgeUpdateService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'KnowledgeUpdateService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<KnowledgeUpdateService-request> is deprecated: use rosplan_knowledge_msgs-srv:KnowledgeUpdateService-request instead.")))

(cl:ensure-generic-function 'update_type-val :lambda-list '(m))
(cl:defmethod update_type-val ((m <KnowledgeUpdateService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:update_type-val is deprecated.  Use rosplan_knowledge_msgs-srv:update_type instead.")
  (update_type m))

(cl:ensure-generic-function 'knowledge-val :lambda-list '(m))
(cl:defmethod knowledge-val ((m <KnowledgeUpdateService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:knowledge-val is deprecated.  Use rosplan_knowledge_msgs-srv:knowledge instead.")
  (knowledge m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<KnowledgeUpdateService-request>)))
    "Constants for message type '<KnowledgeUpdateService-request>"
  '((:ADD_KNOWLEDGE . 0)
    (:ADD_GOAL . 1)
    (:REMOVE_KNOWLEDGE . 2)
    (:REMOVE_GOAL . 3)
    (:ADD_METRIC . 4)
    (:REMOVE_METRIC . 5))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'KnowledgeUpdateService-request)))
    "Constants for message type 'KnowledgeUpdateService-request"
  '((:ADD_KNOWLEDGE . 0)
    (:ADD_GOAL . 1)
    (:REMOVE_KNOWLEDGE . 2)
    (:REMOVE_GOAL . 3)
    (:ADD_METRIC . 4)
    (:REMOVE_METRIC . 5))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <KnowledgeUpdateService-request>) ostream)
  "Serializes a message object of type '<KnowledgeUpdateService-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'update_type)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'knowledge) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <KnowledgeUpdateService-request>) istream)
  "Deserializes a message object of type '<KnowledgeUpdateService-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'update_type)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'knowledge) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<KnowledgeUpdateService-request>)))
  "Returns string type for a service object of type '<KnowledgeUpdateService-request>"
  "rosplan_knowledge_msgs/KnowledgeUpdateServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'KnowledgeUpdateService-request)))
  "Returns string type for a service object of type 'KnowledgeUpdateService-request"
  "rosplan_knowledge_msgs/KnowledgeUpdateServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<KnowledgeUpdateService-request>)))
  "Returns md5sum for a message object of type '<KnowledgeUpdateService-request>"
  "90de09cbbb5b3496e6f4f1a32e72c3a4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'KnowledgeUpdateService-request)))
  "Returns md5sum for a message object of type 'KnowledgeUpdateService-request"
  "90de09cbbb5b3496e6f4f1a32e72c3a4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<KnowledgeUpdateService-request>)))
  "Returns full string definition for message of type '<KnowledgeUpdateService-request>"
  (cl:format cl:nil "# Knowledge building; service(1/1):~%# Add or remove knowledge from the current state.~%~%uint8 ADD_KNOWLEDGE = 0~%uint8 ADD_GOAL = 1~%uint8 REMOVE_KNOWLEDGE = 2~%uint8 REMOVE_GOAL = 3~%uint8 ADD_METRIC = 4~%uint8 REMOVE_METRIC = 5~%~%uint8 update_type~%rosplan_knowledge_msgs/KnowledgeItem knowledge~%~%================================================================================~%MSG: rosplan_knowledge_msgs/KnowledgeItem~%# A knowledge item used to represent a piece of the state in ROSPlan~%~%uint8 INSTANCE = 0~%uint8 FACT = 1~%uint8 FUNCTION = 2~%uint8 EXPRESSION = 3~%uint8 INEQUALITY = 4~%~%uint8 knowledge_type~%~%# time at which this knowledge becomes true~%time initial_time~%~%# knowledge is explicitly false~%bool is_negative~%~%#---------~%# INSTANCE~%#---------~%~%# instance knowledge_type~%string instance_type~%string instance_name~%~%#----------------------~%# PREDICATE OR FUNCTION~%#----------------------~%~%# attribute knowledge_type~%string attribute_name~%diagnostic_msgs/KeyValue[] values~%~%#---------~%# FUNCTION~%#---------~%~%# function value~%float64 function_value~%~%#-----------~%# EXPRESSION~%#-----------~%~%string optimization~%rosplan_knowledge_msgs/ExprComposite expr~%~%#-----------~%# INEQUALITY~%#-----------~%~%rosplan_knowledge_msgs/DomainInequality ineq~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprComposite~%# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainInequality~%# A message used to store the numeric effects of an action~%# Can be grounded or ungrounded~%~%uint8 GREATER   = 0~%uint8 GREATEREQ = 1~%uint8 LESS      = 2~%uint8 LESSEQ    = 3~%uint8 EQUALS    = 4~%~%uint8 comparison_type~%~%rosplan_knowledge_msgs/ExprComposite LHS~%rosplan_knowledge_msgs/ExprComposite RHS~%~%bool grounded~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'KnowledgeUpdateService-request)))
  "Returns full string definition for message of type 'KnowledgeUpdateService-request"
  (cl:format cl:nil "# Knowledge building; service(1/1):~%# Add or remove knowledge from the current state.~%~%uint8 ADD_KNOWLEDGE = 0~%uint8 ADD_GOAL = 1~%uint8 REMOVE_KNOWLEDGE = 2~%uint8 REMOVE_GOAL = 3~%uint8 ADD_METRIC = 4~%uint8 REMOVE_METRIC = 5~%~%uint8 update_type~%rosplan_knowledge_msgs/KnowledgeItem knowledge~%~%================================================================================~%MSG: rosplan_knowledge_msgs/KnowledgeItem~%# A knowledge item used to represent a piece of the state in ROSPlan~%~%uint8 INSTANCE = 0~%uint8 FACT = 1~%uint8 FUNCTION = 2~%uint8 EXPRESSION = 3~%uint8 INEQUALITY = 4~%~%uint8 knowledge_type~%~%# time at which this knowledge becomes true~%time initial_time~%~%# knowledge is explicitly false~%bool is_negative~%~%#---------~%# INSTANCE~%#---------~%~%# instance knowledge_type~%string instance_type~%string instance_name~%~%#----------------------~%# PREDICATE OR FUNCTION~%#----------------------~%~%# attribute knowledge_type~%string attribute_name~%diagnostic_msgs/KeyValue[] values~%~%#---------~%# FUNCTION~%#---------~%~%# function value~%float64 function_value~%~%#-----------~%# EXPRESSION~%#-----------~%~%string optimization~%rosplan_knowledge_msgs/ExprComposite expr~%~%#-----------~%# INEQUALITY~%#-----------~%~%rosplan_knowledge_msgs/DomainInequality ineq~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprComposite~%# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainInequality~%# A message used to store the numeric effects of an action~%# Can be grounded or ungrounded~%~%uint8 GREATER   = 0~%uint8 GREATEREQ = 1~%uint8 LESS      = 2~%uint8 LESSEQ    = 3~%uint8 EQUALS    = 4~%~%uint8 comparison_type~%~%rosplan_knowledge_msgs/ExprComposite LHS~%rosplan_knowledge_msgs/ExprComposite RHS~%~%bool grounded~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <KnowledgeUpdateService-request>))
  (cl:+ 0
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'knowledge))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <KnowledgeUpdateService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'KnowledgeUpdateService-request
    (cl:cons ':update_type (update_type msg))
    (cl:cons ':knowledge (knowledge msg))
))
;//! \htmlinclude KnowledgeUpdateService-response.msg.html

(cl:defclass <KnowledgeUpdateService-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass KnowledgeUpdateService-response (<KnowledgeUpdateService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <KnowledgeUpdateService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'KnowledgeUpdateService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<KnowledgeUpdateService-response> is deprecated: use rosplan_knowledge_msgs-srv:KnowledgeUpdateService-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <KnowledgeUpdateService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:success-val is deprecated.  Use rosplan_knowledge_msgs-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <KnowledgeUpdateService-response>) ostream)
  "Serializes a message object of type '<KnowledgeUpdateService-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <KnowledgeUpdateService-response>) istream)
  "Deserializes a message object of type '<KnowledgeUpdateService-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<KnowledgeUpdateService-response>)))
  "Returns string type for a service object of type '<KnowledgeUpdateService-response>"
  "rosplan_knowledge_msgs/KnowledgeUpdateServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'KnowledgeUpdateService-response)))
  "Returns string type for a service object of type 'KnowledgeUpdateService-response"
  "rosplan_knowledge_msgs/KnowledgeUpdateServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<KnowledgeUpdateService-response>)))
  "Returns md5sum for a message object of type '<KnowledgeUpdateService-response>"
  "90de09cbbb5b3496e6f4f1a32e72c3a4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'KnowledgeUpdateService-response)))
  "Returns md5sum for a message object of type 'KnowledgeUpdateService-response"
  "90de09cbbb5b3496e6f4f1a32e72c3a4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<KnowledgeUpdateService-response>)))
  "Returns full string definition for message of type '<KnowledgeUpdateService-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'KnowledgeUpdateService-response)))
  "Returns full string definition for message of type 'KnowledgeUpdateService-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <KnowledgeUpdateService-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <KnowledgeUpdateService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'KnowledgeUpdateService-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'KnowledgeUpdateService)))
  'KnowledgeUpdateService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'KnowledgeUpdateService)))
  'KnowledgeUpdateService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'KnowledgeUpdateService)))
  "Returns string type for a service object of type '<KnowledgeUpdateService>"
  "rosplan_knowledge_msgs/KnowledgeUpdateService")