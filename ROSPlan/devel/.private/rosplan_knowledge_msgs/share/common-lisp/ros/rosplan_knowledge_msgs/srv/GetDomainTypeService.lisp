; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-srv)


;//! \htmlinclude GetDomainTypeService-request.msg.html

(cl:defclass <GetDomainTypeService-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass GetDomainTypeService-request (<GetDomainTypeService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetDomainTypeService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetDomainTypeService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetDomainTypeService-request> is deprecated: use rosplan_knowledge_msgs-srv:GetDomainTypeService-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetDomainTypeService-request>) ostream)
  "Serializes a message object of type '<GetDomainTypeService-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetDomainTypeService-request>) istream)
  "Deserializes a message object of type '<GetDomainTypeService-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetDomainTypeService-request>)))
  "Returns string type for a service object of type '<GetDomainTypeService-request>"
  "rosplan_knowledge_msgs/GetDomainTypeServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainTypeService-request)))
  "Returns string type for a service object of type 'GetDomainTypeService-request"
  "rosplan_knowledge_msgs/GetDomainTypeServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetDomainTypeService-request>)))
  "Returns md5sum for a message object of type '<GetDomainTypeService-request>"
  "8cb6e21c43cdf2ec143646b3aeb9fd3d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetDomainTypeService-request)))
  "Returns md5sum for a message object of type 'GetDomainTypeService-request"
  "8cb6e21c43cdf2ec143646b3aeb9fd3d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetDomainTypeService-request>)))
  "Returns full string definition for message of type '<GetDomainTypeService-request>"
  (cl:format cl:nil "# Fetching the Domain (1/3):~%# Get all types in the domain.~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetDomainTypeService-request)))
  "Returns full string definition for message of type 'GetDomainTypeService-request"
  (cl:format cl:nil "# Fetching the Domain (1/3):~%# Get all types in the domain.~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetDomainTypeService-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetDomainTypeService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetDomainTypeService-request
))
;//! \htmlinclude GetDomainTypeService-response.msg.html

(cl:defclass <GetDomainTypeService-response> (roslisp-msg-protocol:ros-message)
  ((types
    :reader types
    :initarg :types
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (super_types
    :reader super_types
    :initarg :super_types
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass GetDomainTypeService-response (<GetDomainTypeService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetDomainTypeService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetDomainTypeService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<GetDomainTypeService-response> is deprecated: use rosplan_knowledge_msgs-srv:GetDomainTypeService-response instead.")))

(cl:ensure-generic-function 'types-val :lambda-list '(m))
(cl:defmethod types-val ((m <GetDomainTypeService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:types-val is deprecated.  Use rosplan_knowledge_msgs-srv:types instead.")
  (types m))

(cl:ensure-generic-function 'super_types-val :lambda-list '(m))
(cl:defmethod super_types-val ((m <GetDomainTypeService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:super_types-val is deprecated.  Use rosplan_knowledge_msgs-srv:super_types instead.")
  (super_types m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetDomainTypeService-response>) ostream)
  "Serializes a message object of type '<GetDomainTypeService-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'types))))
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
   (cl:slot-value msg 'types))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'super_types))))
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
   (cl:slot-value msg 'super_types))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetDomainTypeService-response>) istream)
  "Deserializes a message object of type '<GetDomainTypeService-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'types) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'types)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'super_types) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'super_types)))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetDomainTypeService-response>)))
  "Returns string type for a service object of type '<GetDomainTypeService-response>"
  "rosplan_knowledge_msgs/GetDomainTypeServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainTypeService-response)))
  "Returns string type for a service object of type 'GetDomainTypeService-response"
  "rosplan_knowledge_msgs/GetDomainTypeServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetDomainTypeService-response>)))
  "Returns md5sum for a message object of type '<GetDomainTypeService-response>"
  "8cb6e21c43cdf2ec143646b3aeb9fd3d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetDomainTypeService-response)))
  "Returns md5sum for a message object of type 'GetDomainTypeService-response"
  "8cb6e21c43cdf2ec143646b3aeb9fd3d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetDomainTypeService-response>)))
  "Returns full string definition for message of type '<GetDomainTypeService-response>"
  (cl:format cl:nil "string[] types~%string[] super_types~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetDomainTypeService-response)))
  "Returns full string definition for message of type 'GetDomainTypeService-response"
  (cl:format cl:nil "string[] types~%string[] super_types~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetDomainTypeService-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'types) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'super_types) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetDomainTypeService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetDomainTypeService-response
    (cl:cons ':types (types msg))
    (cl:cons ':super_types (super_types msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetDomainTypeService)))
  'GetDomainTypeService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetDomainTypeService)))
  'GetDomainTypeService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetDomainTypeService)))
  "Returns string type for a service object of type '<GetDomainTypeService>"
  "rosplan_knowledge_msgs/GetDomainTypeService")