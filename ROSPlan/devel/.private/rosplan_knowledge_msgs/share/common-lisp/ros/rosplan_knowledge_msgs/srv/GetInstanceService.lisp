; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-srv)


;//! \htmlinclude GetInstanceService-request.msg.html

(cl:defclass <GetInstanceService-request> (roslisp-msg-protocol:ros-message)
  ((type_name
    :reader type_name
    :initarg :type_name
    :type cl:string
    :initform ""))
)

(cl:defclass GetInstanceService-request (<GetInstanceService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetInstanceService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetInstanceService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetInstanceService-request> is deprecated: use rosplan_knowledge_msgs-srv:GetInstanceService-request instead.")))

(cl:ensure-generic-function 'type_name-val :lambda-list '(m))
(cl:defmethod type_name-val ((m <GetInstanceService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:type_name-val is deprecated.  Use rosplan_knowledge_msgs-srv:type_name instead.")
  (type_name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetInstanceService-request>) ostream)
  "Serializes a message object of type '<GetInstanceService-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'type_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'type_name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetInstanceService-request>) istream)
  "Deserializes a message object of type '<GetInstanceService-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'type_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetInstanceService-request>)))
  "Returns string type for a service object of type '<GetInstanceService-request>"
  "rosplan_knowledge_msgs/GetInstanceServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetInstanceService-request)))
  "Returns string type for a service object of type 'GetInstanceService-request"
  "rosplan_knowledge_msgs/GetInstanceServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetInstanceService-request>)))
  "Returns md5sum for a message object of type '<GetInstanceService-request>"
  "84f5db7fe63a450c9972cb84ba4b3454")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetInstanceService-request)))
  "Returns md5sum for a message object of type 'GetInstanceService-request"
  "84f5db7fe63a450c9972cb84ba4b3454")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetInstanceService-request>)))
  "Returns full string definition for message of type '<GetInstanceService-request>"
  (cl:format cl:nil "# PDDL problem generation; service(1/2):~%# Get all instances of the type with the name 'typeName'.~%string type_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetInstanceService-request)))
  "Returns full string definition for message of type 'GetInstanceService-request"
  (cl:format cl:nil "# PDDL problem generation; service(1/2):~%# Get all instances of the type with the name 'typeName'.~%string type_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetInstanceService-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'type_name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetInstanceService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetInstanceService-request
    (cl:cons ':type_name (type_name msg))
))
;//! \htmlinclude GetInstanceService-response.msg.html

(cl:defclass <GetInstanceService-response> (roslisp-msg-protocol:ros-message)
  ((instances
    :reader instances
    :initarg :instances
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass GetInstanceService-response (<GetInstanceService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetInstanceService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetInstanceService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetInstanceService-response> is deprecated: use rosplan_knowledge_msgs-srv:GetInstanceService-response instead.")))

(cl:ensure-generic-function 'instances-val :lambda-list '(m))
(cl:defmethod instances-val ((m <GetInstanceService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:instances-val is deprecated.  Use rosplan_knowledge_msgs-srv:instances instead.")
  (instances m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetInstanceService-response>) ostream)
  "Serializes a message object of type '<GetInstanceService-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'instances))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'instances))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetInstanceService-response>) istream)
  "Deserializes a message object of type '<GetInstanceService-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'instances) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'instances)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetInstanceService-response>)))
  "Returns string type for a service object of type '<GetInstanceService-response>"
  "rosplan_knowledge_msgs/GetInstanceServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetInstanceService-response)))
  "Returns string type for a service object of type 'GetInstanceService-response"
  "rosplan_knowledge_msgs/GetInstanceServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetInstanceService-response>)))
  "Returns md5sum for a message object of type '<GetInstanceService-response>"
  "84f5db7fe63a450c9972cb84ba4b3454")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetInstanceService-response)))
  "Returns md5sum for a message object of type 'GetInstanceService-response"
  "84f5db7fe63a450c9972cb84ba4b3454")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetInstanceService-response>)))
  "Returns full string definition for message of type '<GetInstanceService-response>"
  (cl:format cl:nil "string[] instances~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetInstanceService-response)))
  "Returns full string definition for message of type 'GetInstanceService-response"
  (cl:format cl:nil "string[] instances~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetInstanceService-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'instances) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetInstanceService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetInstanceService-response
    (cl:cons ':instances (instances msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetInstanceService)))
  'GetInstanceService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetInstanceService)))
  'GetInstanceService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetInstanceService)))
  "Returns string type for a service object of type '<GetInstanceService>"
  "rosplan_knowledge_msgs/GetInstanceService")