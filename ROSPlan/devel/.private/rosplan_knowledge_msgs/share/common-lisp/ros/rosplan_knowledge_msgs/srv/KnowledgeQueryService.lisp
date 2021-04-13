; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-srv)


;//! \htmlinclude KnowledgeQueryService-request.msg.html

(cl:defclass <KnowledgeQueryService-request> (roslisp-msg-protocol:ros-message)
  ((knowledge
    :reader knowledge
    :initarg :knowledge
    :type (cl:vector rosplan_knowledge_msgs-msg:KnowledgeItem)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:KnowledgeItem :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:KnowledgeItem))))
)

(cl:defclass KnowledgeQueryService-request (<KnowledgeQueryService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <KnowledgeQueryService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'KnowledgeQueryService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<KnowledgeQueryService-request> is deprecated: use rosplan_knowledge_msgs-srv:KnowledgeQueryService-request instead.")))

(cl:ensure-generic-function 'knowledge-val :lambda-list '(m))
(cl:defmethod knowledge-val ((m <KnowledgeQueryService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:knowledge-val is deprecated.  Use rosplan_knowledge_msgs-srv:knowledge instead.")
  (knowledge m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <KnowledgeQueryService-request>) ostream)
  "Serializes a message object of type '<KnowledgeQueryService-request>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'knowledge))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'knowledge))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <KnowledgeQueryService-request>) istream)
  "Deserializes a message object of type '<KnowledgeQueryService-request>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'knowledge) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'knowledge)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:KnowledgeItem))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<KnowledgeQueryService-request>)))
  "Returns string type for a service object of type '<KnowledgeQueryService-request>"
  "rosplan_knowledge_msgs/KnowledgeQueryServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'KnowledgeQueryService-request)))
  "Returns string type for a service object of type 'KnowledgeQueryService-request"
  "rosplan_knowledge_msgs/KnowledgeQueryServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<KnowledgeQueryService-request>)))
  "Returns md5sum for a message object of type '<KnowledgeQueryService-request>"
  "e5cd9298f5a545040e7835836f3210cb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'KnowledgeQueryService-request)))
  "Returns md5sum for a message object of type 'KnowledgeQueryService-request"
  "e5cd9298f5a545040e7835836f3210cb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<KnowledgeQueryService-request>)))
  "Returns full string definition for message of type '<KnowledgeQueryService-request>"
  (cl:format cl:nil "rosplan_knowledge_msgs/KnowledgeItem[] knowledge~%~%================================================================================~%MSG: rosplan_knowledge_msgs/KnowledgeItem~%# A knowledge item used to represent a piece of the state in ROSPlan~%~%uint8 INSTANCE = 0~%uint8 FACT = 1~%uint8 FUNCTION = 2~%uint8 EXPRESSION = 3~%uint8 INEQUALITY = 4~%~%uint8 knowledge_type~%~%# time at which this knowledge becomes true~%time initial_time~%~%# knowledge is explicitly false~%bool is_negative~%~%#---------~%# INSTANCE~%#---------~%~%# instance knowledge_type~%string instance_type~%string instance_name~%~%#----------------------~%# PREDICATE OR FUNCTION~%#----------------------~%~%# attribute knowledge_type~%string attribute_name~%diagnostic_msgs/KeyValue[] values~%~%#---------~%# FUNCTION~%#---------~%~%# function value~%float64 function_value~%~%#-----------~%# EXPRESSION~%#-----------~%~%string optimization~%rosplan_knowledge_msgs/ExprComposite expr~%~%#-----------~%# INEQUALITY~%#-----------~%~%rosplan_knowledge_msgs/DomainInequality ineq~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprComposite~%# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainInequality~%# A message used to store the numeric effects of an action~%# Can be grounded or ungrounded~%~%uint8 GREATER   = 0~%uint8 GREATEREQ = 1~%uint8 LESS      = 2~%uint8 LESSEQ    = 3~%uint8 EQUALS    = 4~%~%uint8 comparison_type~%~%rosplan_knowledge_msgs/ExprComposite LHS~%rosplan_knowledge_msgs/ExprComposite RHS~%~%bool grounded~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'KnowledgeQueryService-request)))
  "Returns full string definition for message of type 'KnowledgeQueryService-request"
  (cl:format cl:nil "rosplan_knowledge_msgs/KnowledgeItem[] knowledge~%~%================================================================================~%MSG: rosplan_knowledge_msgs/KnowledgeItem~%# A knowledge item used to represent a piece of the state in ROSPlan~%~%uint8 INSTANCE = 0~%uint8 FACT = 1~%uint8 FUNCTION = 2~%uint8 EXPRESSION = 3~%uint8 INEQUALITY = 4~%~%uint8 knowledge_type~%~%# time at which this knowledge becomes true~%time initial_time~%~%# knowledge is explicitly false~%bool is_negative~%~%#---------~%# INSTANCE~%#---------~%~%# instance knowledge_type~%string instance_type~%string instance_name~%~%#----------------------~%# PREDICATE OR FUNCTION~%#----------------------~%~%# attribute knowledge_type~%string attribute_name~%diagnostic_msgs/KeyValue[] values~%~%#---------~%# FUNCTION~%#---------~%~%# function value~%float64 function_value~%~%#-----------~%# EXPRESSION~%#-----------~%~%string optimization~%rosplan_knowledge_msgs/ExprComposite expr~%~%#-----------~%# INEQUALITY~%#-----------~%~%rosplan_knowledge_msgs/DomainInequality ineq~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprComposite~%# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainInequality~%# A message used to store the numeric effects of an action~%# Can be grounded or ungrounded~%~%uint8 GREATER   = 0~%uint8 GREATEREQ = 1~%uint8 LESS      = 2~%uint8 LESSEQ    = 3~%uint8 EQUALS    = 4~%~%uint8 comparison_type~%~%rosplan_knowledge_msgs/ExprComposite LHS~%rosplan_knowledge_msgs/ExprComposite RHS~%~%bool grounded~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <KnowledgeQueryService-request>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'knowledge) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <KnowledgeQueryService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'KnowledgeQueryService-request
    (cl:cons ':knowledge (knowledge msg))
))
;//! \htmlinclude KnowledgeQueryService-response.msg.html

(cl:defclass <KnowledgeQueryService-response> (roslisp-msg-protocol:ros-message)
  ((all_true
    :reader all_true
    :initarg :all_true
    :type cl:boolean
    :initform cl:nil)
   (results
    :reader results
    :initarg :results
    :type (cl:vector cl:boolean)
   :initform (cl:make-array 0 :element-type 'cl:boolean :initial-element cl:nil))
   (false_knowledge
    :reader false_knowledge
    :initarg :false_knowledge
    :type (cl:vector rosplan_knowledge_msgs-msg:KnowledgeItem)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:KnowledgeItem :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:KnowledgeItem))))
)

(cl:defclass KnowledgeQueryService-response (<KnowledgeQueryService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <KnowledgeQueryService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'KnowledgeQueryService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<KnowledgeQueryService-response> is deprecated: use rosplan_knowledge_msgs-srv:KnowledgeQueryService-response instead.")))

(cl:ensure-generic-function 'all_true-val :lambda-list '(m))
(cl:defmethod all_true-val ((m <KnowledgeQueryService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:all_true-val is deprecated.  Use rosplan_knowledge_msgs-srv:all_true instead.")
  (all_true m))

(cl:ensure-generic-function 'results-val :lambda-list '(m))
(cl:defmethod results-val ((m <KnowledgeQueryService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:results-val is deprecated.  Use rosplan_knowledge_msgs-srv:results instead.")
  (results m))

(cl:ensure-generic-function 'false_knowledge-val :lambda-list '(m))
(cl:defmethod false_knowledge-val ((m <KnowledgeQueryService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:false_knowledge-val is deprecated.  Use rosplan_knowledge_msgs-srv:false_knowledge instead.")
  (false_knowledge m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <KnowledgeQueryService-response>) ostream)
  "Serializes a message object of type '<KnowledgeQueryService-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'all_true) 1 0)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'results))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if ele 1 0)) ostream))
   (cl:slot-value msg 'results))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'false_knowledge))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'false_knowledge))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <KnowledgeQueryService-response>) istream)
  "Deserializes a message object of type '<KnowledgeQueryService-response>"
    (cl:setf (cl:slot-value msg 'all_true) (cl:not (cl:zerop (cl:read-byte istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'results) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'results)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:not (cl:zerop (cl:read-byte istream)))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'false_knowledge) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'false_knowledge)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:KnowledgeItem))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<KnowledgeQueryService-response>)))
  "Returns string type for a service object of type '<KnowledgeQueryService-response>"
  "rosplan_knowledge_msgs/KnowledgeQueryServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'KnowledgeQueryService-response)))
  "Returns string type for a service object of type 'KnowledgeQueryService-response"
  "rosplan_knowledge_msgs/KnowledgeQueryServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<KnowledgeQueryService-response>)))
  "Returns md5sum for a message object of type '<KnowledgeQueryService-response>"
  "e5cd9298f5a545040e7835836f3210cb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'KnowledgeQueryService-response)))
  "Returns md5sum for a message object of type 'KnowledgeQueryService-response"
  "e5cd9298f5a545040e7835836f3210cb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<KnowledgeQueryService-response>)))
  "Returns full string definition for message of type '<KnowledgeQueryService-response>"
  (cl:format cl:nil "bool all_true~%bool[] results~%rosplan_knowledge_msgs/KnowledgeItem[] false_knowledge~%~%~%================================================================================~%MSG: rosplan_knowledge_msgs/KnowledgeItem~%# A knowledge item used to represent a piece of the state in ROSPlan~%~%uint8 INSTANCE = 0~%uint8 FACT = 1~%uint8 FUNCTION = 2~%uint8 EXPRESSION = 3~%uint8 INEQUALITY = 4~%~%uint8 knowledge_type~%~%# time at which this knowledge becomes true~%time initial_time~%~%# knowledge is explicitly false~%bool is_negative~%~%#---------~%# INSTANCE~%#---------~%~%# instance knowledge_type~%string instance_type~%string instance_name~%~%#----------------------~%# PREDICATE OR FUNCTION~%#----------------------~%~%# attribute knowledge_type~%string attribute_name~%diagnostic_msgs/KeyValue[] values~%~%#---------~%# FUNCTION~%#---------~%~%# function value~%float64 function_value~%~%#-----------~%# EXPRESSION~%#-----------~%~%string optimization~%rosplan_knowledge_msgs/ExprComposite expr~%~%#-----------~%# INEQUALITY~%#-----------~%~%rosplan_knowledge_msgs/DomainInequality ineq~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprComposite~%# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainInequality~%# A message used to store the numeric effects of an action~%# Can be grounded or ungrounded~%~%uint8 GREATER   = 0~%uint8 GREATEREQ = 1~%uint8 LESS      = 2~%uint8 LESSEQ    = 3~%uint8 EQUALS    = 4~%~%uint8 comparison_type~%~%rosplan_knowledge_msgs/ExprComposite LHS~%rosplan_knowledge_msgs/ExprComposite RHS~%~%bool grounded~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'KnowledgeQueryService-response)))
  "Returns full string definition for message of type 'KnowledgeQueryService-response"
  (cl:format cl:nil "bool all_true~%bool[] results~%rosplan_knowledge_msgs/KnowledgeItem[] false_knowledge~%~%~%================================================================================~%MSG: rosplan_knowledge_msgs/KnowledgeItem~%# A knowledge item used to represent a piece of the state in ROSPlan~%~%uint8 INSTANCE = 0~%uint8 FACT = 1~%uint8 FUNCTION = 2~%uint8 EXPRESSION = 3~%uint8 INEQUALITY = 4~%~%uint8 knowledge_type~%~%# time at which this knowledge becomes true~%time initial_time~%~%# knowledge is explicitly false~%bool is_negative~%~%#---------~%# INSTANCE~%#---------~%~%# instance knowledge_type~%string instance_type~%string instance_name~%~%#----------------------~%# PREDICATE OR FUNCTION~%#----------------------~%~%# attribute knowledge_type~%string attribute_name~%diagnostic_msgs/KeyValue[] values~%~%#---------~%# FUNCTION~%#---------~%~%# function value~%float64 function_value~%~%#-----------~%# EXPRESSION~%#-----------~%~%string optimization~%rosplan_knowledge_msgs/ExprComposite expr~%~%#-----------~%# INEQUALITY~%#-----------~%~%rosplan_knowledge_msgs/DomainInequality ineq~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprComposite~%# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainInequality~%# A message used to store the numeric effects of an action~%# Can be grounded or ungrounded~%~%uint8 GREATER   = 0~%uint8 GREATEREQ = 1~%uint8 LESS      = 2~%uint8 LESSEQ    = 3~%uint8 EQUALS    = 4~%~%uint8 comparison_type~%~%rosplan_knowledge_msgs/ExprComposite LHS~%rosplan_knowledge_msgs/ExprComposite RHS~%~%bool grounded~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <KnowledgeQueryService-response>))
  (cl:+ 0
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'results) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'false_knowledge) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <KnowledgeQueryService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'KnowledgeQueryService-response
    (cl:cons ':all_true (all_true msg))
    (cl:cons ':results (results msg))
    (cl:cons ':false_knowledge (false_knowledge msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'KnowledgeQueryService)))
  'KnowledgeQueryService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'KnowledgeQueryService)))
  'KnowledgeQueryService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'KnowledgeQueryService)))
  "Returns string type for a service object of type '<KnowledgeQueryService>"
  "rosplan_knowledge_msgs/KnowledgeQueryService")