; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-msg)


;//! \htmlinclude ExprBase.msg.html

(cl:defclass <ExprBase> (roslisp-msg-protocol:ros-message)
  ((expr_type
    :reader expr_type
    :initarg :expr_type
    :type cl:fixnum
    :initform 0)
   (constant
    :reader constant
    :initarg :constant
    :type cl:float
    :initform 0.0)
   (function
    :reader function
    :initarg :function
    :type rosplan_knowledge_msgs-msg:DomainFormula
    :initform (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula))
   (op
    :reader op
    :initarg :op
    :type cl:fixnum
    :initform 0)
   (special_type
    :reader special_type
    :initarg :special_type
    :type cl:fixnum
    :initform 0))
)

(cl:defclass ExprBase (<ExprBase>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ExprBase>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ExprBase)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-msg:<ExprBase> is deprecated: use rosplan_knowledge_msgs-msg:ExprBase instead.")))

(cl:ensure-generic-function 'expr_type-val :lambda-list '(m))
(cl:defmethod expr_type-val ((m <ExprBase>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:expr_type-val is deprecated.  Use rosplan_knowledge_msgs-msg:expr_type instead.")
  (expr_type m))

(cl:ensure-generic-function 'constant-val :lambda-list '(m))
(cl:defmethod constant-val ((m <ExprBase>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:constant-val is deprecated.  Use rosplan_knowledge_msgs-msg:constant instead.")
  (constant m))

(cl:ensure-generic-function 'function-val :lambda-list '(m))
(cl:defmethod function-val ((m <ExprBase>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:function-val is deprecated.  Use rosplan_knowledge_msgs-msg:function instead.")
  (function m))

(cl:ensure-generic-function 'op-val :lambda-list '(m))
(cl:defmethod op-val ((m <ExprBase>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:op-val is deprecated.  Use rosplan_knowledge_msgs-msg:op instead.")
  (op m))

(cl:ensure-generic-function 'special_type-val :lambda-list '(m))
(cl:defmethod special_type-val ((m <ExprBase>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:special_type-val is deprecated.  Use rosplan_knowledge_msgs-msg:special_type instead.")
  (special_type m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<ExprBase>)))
    "Constants for message type '<ExprBase>"
  '((:CONSTANT . 0)
    (:FUNCTION . 1)
    (:OPERATOR . 2)
    (:SPECIAL . 3)
    (:ADD . 0)
    (:SUB . 1)
    (:MUL . 2)
    (:DIV . 3)
    (:UMINUS . 4)
    (:HASHT . 0)
    (:TOTAL_TIME . 1)
    (:DURATION . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'ExprBase)))
    "Constants for message type 'ExprBase"
  '((:CONSTANT . 0)
    (:FUNCTION . 1)
    (:OPERATOR . 2)
    (:SPECIAL . 3)
    (:ADD . 0)
    (:SUB . 1)
    (:MUL . 2)
    (:DIV . 3)
    (:UMINUS . 4)
    (:HASHT . 0)
    (:TOTAL_TIME . 1)
    (:DURATION . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ExprBase>) ostream)
  "Serializes a message object of type '<ExprBase>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'expr_type)) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'constant))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'function) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'op)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'special_type)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ExprBase>) istream)
  "Deserializes a message object of type '<ExprBase>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'expr_type)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'constant) (roslisp-utils:decode-double-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'function) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'op)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'special_type)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ExprBase>)))
  "Returns string type for a message object of type '<ExprBase>"
  "rosplan_knowledge_msgs/ExprBase")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ExprBase)))
  "Returns string type for a message object of type 'ExprBase"
  "rosplan_knowledge_msgs/ExprBase")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ExprBase>)))
  "Returns md5sum for a message object of type '<ExprBase>"
  "5d33d1b51272864ef936be512369146f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ExprBase)))
  "Returns md5sum for a message object of type 'ExprBase"
  "5d33d1b51272864ef936be512369146f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ExprBase>)))
  "Returns full string definition for message of type '<ExprBase>"
  (cl:format cl:nil "# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ExprBase)))
  "Returns full string definition for message of type 'ExprBase"
  (cl:format cl:nil "# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ExprBase>))
  (cl:+ 0
     1
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'function))
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ExprBase>))
  "Converts a ROS message object to a list"
  (cl:list 'ExprBase
    (cl:cons ':expr_type (expr_type msg))
    (cl:cons ':constant (constant msg))
    (cl:cons ':function (function msg))
    (cl:cons ':op (op msg))
    (cl:cons ':special_type (special_type msg))
))
