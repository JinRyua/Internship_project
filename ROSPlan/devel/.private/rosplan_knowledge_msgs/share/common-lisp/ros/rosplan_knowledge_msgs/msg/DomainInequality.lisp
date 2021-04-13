; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-msg)


;//! \htmlinclude DomainInequality.msg.html

(cl:defclass <DomainInequality> (roslisp-msg-protocol:ros-message)
  ((comparison_type
    :reader comparison_type
    :initarg :comparison_type
    :type cl:fixnum
    :initform 0)
   (LHS
    :reader LHS
    :initarg :LHS
    :type rosplan_knowledge_msgs-msg:ExprComposite
    :initform (cl:make-instance 'rosplan_knowledge_msgs-msg:ExprComposite))
   (RHS
    :reader RHS
    :initarg :RHS
    :type rosplan_knowledge_msgs-msg:ExprComposite
    :initform (cl:make-instance 'rosplan_knowledge_msgs-msg:ExprComposite))
   (grounded
    :reader grounded
    :initarg :grounded
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass DomainInequality (<DomainInequality>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DomainInequality>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DomainInequality)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-msg:<DomainInequality> is deprecated: use rosplan_knowledge_msgs-msg:DomainInequality instead.")))

(cl:ensure-generic-function 'comparison_type-val :lambda-list '(m))
(cl:defmethod comparison_type-val ((m <DomainInequality>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:comparison_type-val is deprecated.  Use rosplan_knowledge_msgs-msg:comparison_type instead.")
  (comparison_type m))

(cl:ensure-generic-function 'LHS-val :lambda-list '(m))
(cl:defmethod LHS-val ((m <DomainInequality>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:LHS-val is deprecated.  Use rosplan_knowledge_msgs-msg:LHS instead.")
  (LHS m))

(cl:ensure-generic-function 'RHS-val :lambda-list '(m))
(cl:defmethod RHS-val ((m <DomainInequality>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:RHS-val is deprecated.  Use rosplan_knowledge_msgs-msg:RHS instead.")
  (RHS m))

(cl:ensure-generic-function 'grounded-val :lambda-list '(m))
(cl:defmethod grounded-val ((m <DomainInequality>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:grounded-val is deprecated.  Use rosplan_knowledge_msgs-msg:grounded instead.")
  (grounded m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<DomainInequality>)))
    "Constants for message type '<DomainInequality>"
  '((:GREATER . 0)
    (:GREATEREQ . 1)
    (:LESS . 2)
    (:LESSEQ . 3)
    (:EQUALS . 4))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'DomainInequality)))
    "Constants for message type 'DomainInequality"
  '((:GREATER . 0)
    (:GREATEREQ . 1)
    (:LESS . 2)
    (:LESSEQ . 3)
    (:EQUALS . 4))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DomainInequality>) ostream)
  "Serializes a message object of type '<DomainInequality>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'comparison_type)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'LHS) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'RHS) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'grounded) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DomainInequality>) istream)
  "Deserializes a message object of type '<DomainInequality>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'comparison_type)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'LHS) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'RHS) istream)
    (cl:setf (cl:slot-value msg 'grounded) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DomainInequality>)))
  "Returns string type for a message object of type '<DomainInequality>"
  "rosplan_knowledge_msgs/DomainInequality")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DomainInequality)))
  "Returns string type for a message object of type 'DomainInequality"
  "rosplan_knowledge_msgs/DomainInequality")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DomainInequality>)))
  "Returns md5sum for a message object of type '<DomainInequality>"
  "f37701458d82c14a53dcc25df39cacaa")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DomainInequality)))
  "Returns md5sum for a message object of type 'DomainInequality"
  "f37701458d82c14a53dcc25df39cacaa")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DomainInequality>)))
  "Returns full string definition for message of type '<DomainInequality>"
  (cl:format cl:nil "# A message used to store the numeric effects of an action~%# Can be grounded or ungrounded~%~%uint8 GREATER   = 0~%uint8 GREATEREQ = 1~%uint8 LESS      = 2~%uint8 LESSEQ    = 3~%uint8 EQUALS    = 4~%~%uint8 comparison_type~%~%rosplan_knowledge_msgs/ExprComposite LHS~%rosplan_knowledge_msgs/ExprComposite RHS~%~%bool grounded~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprComposite~%# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DomainInequality)))
  "Returns full string definition for message of type 'DomainInequality"
  (cl:format cl:nil "# A message used to store the numeric effects of an action~%# Can be grounded or ungrounded~%~%uint8 GREATER   = 0~%uint8 GREATEREQ = 1~%uint8 LESS      = 2~%uint8 LESSEQ    = 3~%uint8 EQUALS    = 4~%~%uint8 comparison_type~%~%rosplan_knowledge_msgs/ExprComposite LHS~%rosplan_knowledge_msgs/ExprComposite RHS~%~%bool grounded~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprComposite~%# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DomainInequality>))
  (cl:+ 0
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'LHS))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'RHS))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DomainInequality>))
  "Converts a ROS message object to a list"
  (cl:list 'DomainInequality
    (cl:cons ':comparison_type (comparison_type msg))
    (cl:cons ':LHS (LHS msg))
    (cl:cons ':RHS (RHS msg))
    (cl:cons ':grounded (grounded msg))
))
