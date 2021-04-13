; Auto-generated. Do not edit!


(cl:in-package rosplan_dispatch_msgs-msg)


;//! \htmlinclude CompletePlan.msg.html

(cl:defclass <CompletePlan> (roslisp-msg-protocol:ros-message)
  ((plan
    :reader plan
    :initarg :plan
    :type (cl:vector rosplan_dispatch_msgs-msg:ActionDispatch)
   :initform (cl:make-array 0 :element-type 'rosplan_dispatch_msgs-msg:ActionDispatch :initial-element (cl:make-instance 'rosplan_dispatch_msgs-msg:ActionDispatch))))
)

(cl:defclass CompletePlan (<CompletePlan>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CompletePlan>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CompletePlan)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_dispatch_msgs-msg:<CompletePlan> is deprecated: use rosplan_dispatch_msgs-msg:CompletePlan instead.")))

(cl:ensure-generic-function 'plan-val :lambda-list '(m))
(cl:defmethod plan-val ((m <CompletePlan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_dispatch_msgs-msg:plan-val is deprecated.  Use rosplan_dispatch_msgs-msg:plan instead.")
  (plan m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CompletePlan>) ostream)
  "Serializes a message object of type '<CompletePlan>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'plan))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'plan))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CompletePlan>) istream)
  "Deserializes a message object of type '<CompletePlan>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'plan) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'plan)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_dispatch_msgs-msg:ActionDispatch))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CompletePlan>)))
  "Returns string type for a message object of type '<CompletePlan>"
  "rosplan_dispatch_msgs/CompletePlan")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CompletePlan)))
  "Returns string type for a message object of type 'CompletePlan"
  "rosplan_dispatch_msgs/CompletePlan")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CompletePlan>)))
  "Returns md5sum for a message object of type '<CompletePlan>"
  "7e1d10b4d2f9481e13d9d30c7a8045ff")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CompletePlan)))
  "Returns md5sum for a message object of type 'CompletePlan"
  "7e1d10b4d2f9481e13d9d30c7a8045ff")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CompletePlan>)))
  "Returns full string definition for message of type '<CompletePlan>"
  (cl:format cl:nil "#completePlan message~%ActionDispatch[] plan~%~%================================================================================~%MSG: rosplan_dispatch_msgs/ActionDispatch~%#actionDispatch message~%int32 action_id~%string name~%diagnostic_msgs/KeyValue[] parameters~%float32 duration~%float32 dispatch_time~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CompletePlan)))
  "Returns full string definition for message of type 'CompletePlan"
  (cl:format cl:nil "#completePlan message~%ActionDispatch[] plan~%~%================================================================================~%MSG: rosplan_dispatch_msgs/ActionDispatch~%#actionDispatch message~%int32 action_id~%string name~%diagnostic_msgs/KeyValue[] parameters~%float32 duration~%float32 dispatch_time~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CompletePlan>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'plan) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CompletePlan>))
  "Converts a ROS message object to a list"
  (cl:list 'CompletePlan
    (cl:cons ':plan (plan msg))
))
