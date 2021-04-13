; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-msg)


;//! \htmlinclude ExprComposite.msg.html

(cl:defclass <ExprComposite> (roslisp-msg-protocol:ros-message)
  ((tokens
    :reader tokens
    :initarg :tokens
    :type (cl:vector rosplan_knowledge_msgs-msg:ExprBase)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:ExprBase :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:ExprBase))))
)

(cl:defclass ExprComposite (<ExprComposite>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ExprComposite>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ExprComposite)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-msg:<ExprComposite> is deprecated: use rosplan_knowledge_msgs-msg:ExprComposite instead.")))

(cl:ensure-generic-function 'tokens-val :lambda-list '(m))
(cl:defmethod tokens-val ((m <ExprComposite>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:tokens-val is deprecated.  Use rosplan_knowledge_msgs-msg:tokens instead.")
  (tokens m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ExprComposite>) ostream)
  "Serializes a message object of type '<ExprComposite>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'tokens))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'tokens))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ExprComposite>) istream)
  "Deserializes a message object of type '<ExprComposite>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'tokens) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'tokens)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:ExprBase))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ExprComposite>)))
  "Returns string type for a message object of type '<ExprComposite>"
  "rosplan_knowledge_msgs/ExprComposite")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ExprComposite)))
  "Returns string type for a message object of type 'ExprComposite"
  "rosplan_knowledge_msgs/ExprComposite")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ExprComposite>)))
  "Returns md5sum for a message object of type '<ExprComposite>"
  "9633231342c31ed233d306d6bf5cb1d3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ExprComposite)))
  "Returns md5sum for a message object of type 'ExprComposite"
  "9633231342c31ed233d306d6bf5cb1d3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ExprComposite>)))
  "Returns full string definition for message of type '<ExprComposite>"
  (cl:format cl:nil "# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ExprComposite)))
  "Returns full string definition for message of type 'ExprComposite"
  (cl:format cl:nil "# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ExprComposite>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'tokens) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ExprComposite>))
  "Converts a ROS message object to a list"
  (cl:list 'ExprComposite
    (cl:cons ':tokens (tokens msg))
))
