; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-srv)


;//! \htmlinclude CreatePRM-request.msg.html

(cl:defclass <CreatePRM-request> (roslisp-msg-protocol:ros-message)
  ((nr_waypoints
    :reader nr_waypoints
    :initarg :nr_waypoints
    :type cl:integer
    :initform 0)
   (min_distance
    :reader min_distance
    :initarg :min_distance
    :type cl:float
    :initform 0.0)
   (casting_distance
    :reader casting_distance
    :initarg :casting_distance
    :type cl:float
    :initform 0.0)
   (connecting_distance
    :reader connecting_distance
    :initarg :connecting_distance
    :type cl:float
    :initform 0.0)
   (occupancy_threshold
    :reader occupancy_threshold
    :initarg :occupancy_threshold
    :type cl:fixnum
    :initform 0)
   (total_attempts
    :reader total_attempts
    :initarg :total_attempts
    :type cl:integer
    :initform 0))
)

(cl:defclass CreatePRM-request (<CreatePRM-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CreatePRM-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CreatePRM-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<CreatePRM-request> is deprecated: use rosplan_knowledge_msgs-srv:CreatePRM-request instead.")))

(cl:ensure-generic-function 'nr_waypoints-val :lambda-list '(m))
(cl:defmethod nr_waypoints-val ((m <CreatePRM-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:nr_waypoints-val is deprecated.  Use rosplan_knowledge_msgs-srv:nr_waypoints instead.")
  (nr_waypoints m))

(cl:ensure-generic-function 'min_distance-val :lambda-list '(m))
(cl:defmethod min_distance-val ((m <CreatePRM-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:min_distance-val is deprecated.  Use rosplan_knowledge_msgs-srv:min_distance instead.")
  (min_distance m))

(cl:ensure-generic-function 'casting_distance-val :lambda-list '(m))
(cl:defmethod casting_distance-val ((m <CreatePRM-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:casting_distance-val is deprecated.  Use rosplan_knowledge_msgs-srv:casting_distance instead.")
  (casting_distance m))

(cl:ensure-generic-function 'connecting_distance-val :lambda-list '(m))
(cl:defmethod connecting_distance-val ((m <CreatePRM-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:connecting_distance-val is deprecated.  Use rosplan_knowledge_msgs-srv:connecting_distance instead.")
  (connecting_distance m))

(cl:ensure-generic-function 'occupancy_threshold-val :lambda-list '(m))
(cl:defmethod occupancy_threshold-val ((m <CreatePRM-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:occupancy_threshold-val is deprecated.  Use rosplan_knowledge_msgs-srv:occupancy_threshold instead.")
  (occupancy_threshold m))

(cl:ensure-generic-function 'total_attempts-val :lambda-list '(m))
(cl:defmethod total_attempts-val ((m <CreatePRM-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:total_attempts-val is deprecated.  Use rosplan_knowledge_msgs-srv:total_attempts instead.")
  (total_attempts m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CreatePRM-request>) ostream)
  "Serializes a message object of type '<CreatePRM-request>"
  (cl:let* ((signed (cl:slot-value msg 'nr_waypoints)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'min_distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'casting_distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'connecting_distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'occupancy_threshold)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'total_attempts)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CreatePRM-request>) istream)
  "Deserializes a message object of type '<CreatePRM-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'nr_waypoints) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'min_distance) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'casting_distance) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'connecting_distance) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'occupancy_threshold) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'total_attempts) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CreatePRM-request>)))
  "Returns string type for a service object of type '<CreatePRM-request>"
  "rosplan_knowledge_msgs/CreatePRMRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CreatePRM-request)))
  "Returns string type for a service object of type 'CreatePRM-request"
  "rosplan_knowledge_msgs/CreatePRMRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CreatePRM-request>)))
  "Returns md5sum for a message object of type '<CreatePRM-request>"
  "e2d990767484410646d05d82e9a4545b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CreatePRM-request)))
  "Returns md5sum for a message object of type 'CreatePRM-request"
  "e2d990767484410646d05d82e9a4545b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CreatePRM-request>)))
  "Returns full string definition for message of type '<CreatePRM-request>"
  (cl:format cl:nil "int32 nr_waypoints~%float32 min_distance~%float32 casting_distance~%float32 connecting_distance~%int8 occupancy_threshold~%int32 total_attempts~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CreatePRM-request)))
  "Returns full string definition for message of type 'CreatePRM-request"
  (cl:format cl:nil "int32 nr_waypoints~%float32 min_distance~%float32 casting_distance~%float32 connecting_distance~%int8 occupancy_threshold~%int32 total_attempts~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CreatePRM-request>))
  (cl:+ 0
     4
     4
     4
     4
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CreatePRM-request>))
  "Converts a ROS message object to a list"
  (cl:list 'CreatePRM-request
    (cl:cons ':nr_waypoints (nr_waypoints msg))
    (cl:cons ':min_distance (min_distance msg))
    (cl:cons ':casting_distance (casting_distance msg))
    (cl:cons ':connecting_distance (connecting_distance msg))
    (cl:cons ':occupancy_threshold (occupancy_threshold msg))
    (cl:cons ':total_attempts (total_attempts msg))
))
;//! \htmlinclude CreatePRM-response.msg.html

(cl:defclass <CreatePRM-response> (roslisp-msg-protocol:ros-message)
  ((waypoints
    :reader waypoints
    :initarg :waypoints
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass CreatePRM-response (<CreatePRM-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CreatePRM-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CreatePRM-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<CreatePRM-response> is deprecated: use rosplan_knowledge_msgs-srv:CreatePRM-response instead.")))

(cl:ensure-generic-function 'waypoints-val :lambda-list '(m))
(cl:defmethod waypoints-val ((m <CreatePRM-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:waypoints-val is deprecated.  Use rosplan_knowledge_msgs-srv:waypoints instead.")
  (waypoints m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CreatePRM-response>) ostream)
  "Serializes a message object of type '<CreatePRM-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'waypoints))))
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
   (cl:slot-value msg 'waypoints))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CreatePRM-response>) istream)
  "Deserializes a message object of type '<CreatePRM-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'waypoints) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'waypoints)))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CreatePRM-response>)))
  "Returns string type for a service object of type '<CreatePRM-response>"
  "rosplan_knowledge_msgs/CreatePRMResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CreatePRM-response)))
  "Returns string type for a service object of type 'CreatePRM-response"
  "rosplan_knowledge_msgs/CreatePRMResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CreatePRM-response>)))
  "Returns md5sum for a message object of type '<CreatePRM-response>"
  "e2d990767484410646d05d82e9a4545b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CreatePRM-response)))
  "Returns md5sum for a message object of type 'CreatePRM-response"
  "e2d990767484410646d05d82e9a4545b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CreatePRM-response>)))
  "Returns full string definition for message of type '<CreatePRM-response>"
  (cl:format cl:nil "string[] waypoints~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CreatePRM-response)))
  "Returns full string definition for message of type 'CreatePRM-response"
  (cl:format cl:nil "string[] waypoints~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CreatePRM-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'waypoints) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CreatePRM-response>))
  "Converts a ROS message object to a list"
  (cl:list 'CreatePRM-response
    (cl:cons ':waypoints (waypoints msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'CreatePRM)))
  'CreatePRM-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'CreatePRM)))
  'CreatePRM-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CreatePRM)))
  "Returns string type for a service object of type '<CreatePRM>"
  "rosplan_knowledge_msgs/CreatePRM")