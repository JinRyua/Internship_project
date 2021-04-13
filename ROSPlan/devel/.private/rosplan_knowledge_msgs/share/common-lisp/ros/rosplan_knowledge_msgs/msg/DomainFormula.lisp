; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-msg)


;//! \htmlinclude DomainFormula.msg.html

(cl:defclass <DomainFormula> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (typed_parameters
    :reader typed_parameters
    :initarg :typed_parameters
    :type (cl:vector diagnostic_msgs-msg:KeyValue)
   :initform (cl:make-array 0 :element-type 'diagnostic_msgs-msg:KeyValue :initial-element (cl:make-instance 'diagnostic_msgs-msg:KeyValue))))
)

(cl:defclass DomainFormula (<DomainFormula>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DomainFormula>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DomainFormula)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-msg:<DomainFormula> is deprecated: use rosplan_knowledge_msgs-msg:DomainFormula instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <DomainFormula>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:name-val is deprecated.  Use rosplan_knowledge_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'typed_parameters-val :lambda-list '(m))
(cl:defmethod typed_parameters-val ((m <DomainFormula>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:typed_parameters-val is deprecated.  Use rosplan_knowledge_msgs-msg:typed_parameters instead.")
  (typed_parameters m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DomainFormula>) ostream)
  "Serializes a message object of type '<DomainFormula>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'typed_parameters))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'typed_parameters))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DomainFormula>) istream)
  "Deserializes a message object of type '<DomainFormula>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'typed_parameters) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'typed_parameters)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'diagnostic_msgs-msg:KeyValue))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DomainFormula>)))
  "Returns string type for a message object of type '<DomainFormula>"
  "rosplan_knowledge_msgs/DomainFormula")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DomainFormula)))
  "Returns string type for a message object of type 'DomainFormula"
  "rosplan_knowledge_msgs/DomainFormula")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DomainFormula>)))
  "Returns md5sum for a message object of type '<DomainFormula>"
  "b9c7cfc3aa64764d3a82f96d3671bab1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DomainFormula)))
  "Returns md5sum for a message object of type 'DomainFormula"
  "b9c7cfc3aa64764d3a82f96d3671bab1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DomainFormula>)))
  "Returns full string definition for message of type '<DomainFormula>"
  (cl:format cl:nil "# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DomainFormula)))
  "Returns full string definition for message of type 'DomainFormula"
  (cl:format cl:nil "# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DomainFormula>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'typed_parameters) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DomainFormula>))
  "Converts a ROS message object to a list"
  (cl:list 'DomainFormula
    (cl:cons ':name (name msg))
    (cl:cons ':typed_parameters (typed_parameters msg))
))
