; Auto-generated. Do not edit!


(cl:in-package rosplan_dispatch_msgs-msg)


;//! \htmlinclude EsterelPlanEdge.msg.html

(cl:defclass <EsterelPlanEdge> (roslisp-msg-protocol:ros-message)
  ((edge_id
    :reader edge_id
    :initarg :edge_id
    :type cl:integer
    :initform 0)
   (edge_name
    :reader edge_name
    :initarg :edge_name
    :type cl:string
    :initform "")
   (signal_type
    :reader signal_type
    :initarg :signal_type
    :type cl:integer
    :initform 0)
   (source_ids
    :reader source_ids
    :initarg :source_ids
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (sink_ids
    :reader sink_ids
    :initarg :sink_ids
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (duration_lower_bound
    :reader duration_lower_bound
    :initarg :duration_lower_bound
    :type cl:float
    :initform 0.0)
   (duration_upper_bound
    :reader duration_upper_bound
    :initarg :duration_upper_bound
    :type cl:float
    :initform 0.0))
)

(cl:defclass EsterelPlanEdge (<EsterelPlanEdge>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EsterelPlanEdge>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EsterelPlanEdge)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_dispatch_msgs-msg:<EsterelPlanEdge> is deprecated: use rosplan_dispatch_msgs-msg:EsterelPlanEdge instead.")))

(cl:ensure-generic-function 'edge_id-val :lambda-list '(m))
(cl:defmethod edge_id-val ((m <EsterelPlanEdge>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:edge_id-val is deprecated.  Use rosplan_dispatch_msgs-msg:edge_id instead.")
  (edge_id m))

(cl:ensure-generic-function 'edge_name-val :lambda-list '(m))
(cl:defmethod edge_name-val ((m <EsterelPlanEdge>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:edge_name-val is deprecated.  Use rosplan_dispatch_msgs-msg:edge_name instead.")
  (edge_name m))

(cl:ensure-generic-function 'signal_type-val :lambda-list '(m))
(cl:defmethod signal_type-val ((m <EsterelPlanEdge>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:signal_type-val is deprecated.  Use rosplan_dispatch_msgs-msg:signal_type instead.")
  (signal_type m))

(cl:ensure-generic-function 'source_ids-val :lambda-list '(m))
(cl:defmethod source_ids-val ((m <EsterelPlanEdge>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:source_ids-val is deprecated.  Use rosplan_dispatch_msgs-msg:source_ids instead.")
  (source_ids m))

(cl:ensure-generic-function 'sink_ids-val :lambda-list '(m))
(cl:defmethod sink_ids-val ((m <EsterelPlanEdge>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:sink_ids-val is deprecated.  Use rosplan_dispatch_msgs-msg:sink_ids instead.")
  (sink_ids m))

(cl:ensure-generic-function 'duration_lower_bound-val :lambda-list '(m))
(cl:defmethod duration_lower_bound-val ((m <EsterelPlanEdge>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:duration_lower_bound-val is deprecated.  Use rosplan_dispatch_msgs-msg:duration_lower_bound instead.")
  (duration_lower_bound m))

(cl:ensure-generic-function 'duration_upper_bound-val :lambda-list '(m))
(cl:defmethod duration_upper_bound-val ((m <EsterelPlanEdge>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:duration_upper_bound-val is deprecated.  Use rosplan_dispatch_msgs-msg:duration_upper_bound instead.")
  (duration_upper_bound m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EsterelPlanEdge>) ostream)
  "Serializes a message object of type '<EsterelPlanEdge>"
  (cl:let* ((signed (cl:slot-value msg 'edge_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'edge_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'edge_name))
  (cl:let* ((signed (cl:slot-value msg 'signal_type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'source_ids))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    ))
   (cl:slot-value msg 'source_ids))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'sink_ids))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    ))
   (cl:slot-value msg 'sink_ids))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'duration_lower_bound))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'duration_upper_bound))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EsterelPlanEdge>) istream)
  "Deserializes a message object of type '<EsterelPlanEdge>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'edge_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'edge_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'edge_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'signal_type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'source_ids) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'source_ids)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'sink_ids) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'sink_ids)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'duration_lower_bound) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'duration_upper_bound) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EsterelPlanEdge>)))
  "Returns string type for a message object of type '<EsterelPlanEdge>"
  "rosplan_dispatch_msgs/EsterelPlanEdge")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EsterelPlanEdge)))
  "Returns string type for a message object of type 'EsterelPlanEdge"
  "rosplan_dispatch_msgs/EsterelPlanEdge")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EsterelPlanEdge>)))
  "Returns md5sum for a message object of type '<EsterelPlanEdge>"
  "dbbf05c7357969fc7b48ff26fa7775db")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EsterelPlanEdge)))
  "Returns md5sum for a message object of type 'EsterelPlanEdge"
  "dbbf05c7357969fc7b48ff26fa7775db")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EsterelPlanEdge>)))
  "Returns full string definition for message of type '<EsterelPlanEdge>"
  (cl:format cl:nil "#EsterelPlanEdge message~%int32 edge_id~%string edge_name~%int32 signal_type~%int32[] source_ids~%int32[] sink_ids~%float64 duration_lower_bound~%float64 duration_upper_bound~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EsterelPlanEdge)))
  "Returns full string definition for message of type 'EsterelPlanEdge"
  (cl:format cl:nil "#EsterelPlanEdge message~%int32 edge_id~%string edge_name~%int32 signal_type~%int32[] source_ids~%int32[] sink_ids~%float64 duration_lower_bound~%float64 duration_upper_bound~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EsterelPlanEdge>))
  (cl:+ 0
     4
     4 (cl:length (cl:slot-value msg 'edge_name))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'source_ids) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'sink_ids) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EsterelPlanEdge>))
  "Converts a ROS message object to a list"
  (cl:list 'EsterelPlanEdge
    (cl:cons ':edge_id (edge_id msg))
    (cl:cons ':edge_name (edge_name msg))
    (cl:cons ':signal_type (signal_type msg))
    (cl:cons ':source_ids (source_ids msg))
    (cl:cons ':sink_ids (sink_ids msg))
    (cl:cons ':duration_lower_bound (duration_lower_bound msg))
    (cl:cons ':duration_upper_bound (duration_upper_bound msg))
))
