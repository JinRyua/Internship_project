; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-srv)


;//! \htmlinclude RemoveWaypoint-request.msg.html

(cl:defclass <RemoveWaypoint-request> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:string
    :initform ""))
)

(cl:defclass RemoveWaypoint-request (<RemoveWaypoint-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RemoveWaypoint-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RemoveWaypoint-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<RemoveWaypoint-request> is deprecated: use rosplan_knowledge_msgs-srv:RemoveWaypoint-request instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <RemoveWaypoint-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-srv:id-val is deprecated.  Use rosplan_knowledge_msgs-srv:id instead.")
  (id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RemoveWaypoint-request>) ostream)
  "Serializes a message object of type '<RemoveWaypoint-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'id))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RemoveWaypoint-request>) istream)
  "Deserializes a message object of type '<RemoveWaypoint-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'id) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RemoveWaypoint-request>)))
  "Returns string type for a service object of type '<RemoveWaypoint-request>"
  "rosplan_knowledge_msgs/RemoveWaypointRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RemoveWaypoint-request)))
  "Returns string type for a service object of type 'RemoveWaypoint-request"
  "rosplan_knowledge_msgs/RemoveWaypointRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RemoveWaypoint-request>)))
  "Returns md5sum for a message object of type '<RemoveWaypoint-request>"
  "bbfcda76036ebbe3d36caf7af80b260c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RemoveWaypoint-request)))
  "Returns md5sum for a message object of type 'RemoveWaypoint-request"
  "bbfcda76036ebbe3d36caf7af80b260c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RemoveWaypoint-request>)))
  "Returns full string definition for message of type '<RemoveWaypoint-request>"
  (cl:format cl:nil "string id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RemoveWaypoint-request)))
  "Returns full string definition for message of type 'RemoveWaypoint-request"
  (cl:format cl:nil "string id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RemoveWaypoint-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'id))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RemoveWaypoint-request>))
  "Converts a ROS message object to a list"
  (cl:list 'RemoveWaypoint-request
    (cl:cons ':id (id msg))
))
;//! \htmlinclude RemoveWaypoint-response.msg.html

(cl:defclass <RemoveWaypoint-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass RemoveWaypoint-response (<RemoveWaypoint-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RemoveWaypoint-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RemoveWaypoint-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-srv:<RemoveWaypoint-response> is deprecated: use rosplan_knowledge_msgs-srv:RemoveWaypoint-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RemoveWaypoint-response>) ostream)
  "Serializes a message object of type '<RemoveWaypoint-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RemoveWaypoint-response>) istream)
  "Deserializes a message object of type '<RemoveWaypoint-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RemoveWaypoint-response>)))
  "Returns string type for a service object of type '<RemoveWaypoint-response>"
  "rosplan_knowledge_msgs/RemoveWaypointResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RemoveWaypoint-response)))
  "Returns string type for a service object of type 'RemoveWaypoint-response"
  "rosplan_knowledge_msgs/RemoveWaypointResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RemoveWaypoint-response>)))
  "Returns md5sum for a message object of type '<RemoveWaypoint-response>"
  "bbfcda76036ebbe3d36caf7af80b260c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RemoveWaypoint-response)))
  "Returns md5sum for a message object of type 'RemoveWaypoint-response"
  "bbfcda76036ebbe3d36caf7af80b260c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RemoveWaypoint-response>)))
  "Returns full string definition for message of type '<RemoveWaypoint-response>"
  (cl:format cl:nil "~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RemoveWaypoint-response)))
  "Returns full string definition for message of type 'RemoveWaypoint-response"
  (cl:format cl:nil "~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RemoveWaypoint-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RemoveWaypoint-response>))
  "Converts a ROS message object to a list"
  (cl:list 'RemoveWaypoint-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'RemoveWaypoint)))
  'RemoveWaypoint-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'RemoveWaypoint)))
  'RemoveWaypoint-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RemoveWaypoint)))
  "Returns string type for a service object of type '<RemoveWaypoint>"
  "rosplan_knowledge_msgs/RemoveWaypoint")