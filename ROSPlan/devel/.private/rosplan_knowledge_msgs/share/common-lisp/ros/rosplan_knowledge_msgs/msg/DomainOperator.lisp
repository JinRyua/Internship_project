; Auto-generated. Do not edit!


(cl:in-package rosplan_knowledge_msgs-msg)


;//! \htmlinclude DomainOperator.msg.html

(cl:defclass <DomainOperator> (roslisp-msg-protocol:ros-message)
  ((formula
    :reader formula
    :initarg :formula
    :type rosplan_knowledge_msgs-msg:DomainFormula
    :initform (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula))
   (at_start_add_effects
    :reader at_start_add_effects
    :initarg :at_start_add_effects
    :type (cl:vector rosplan_knowledge_msgs-msg:DomainFormula)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:DomainFormula :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula)))
   (at_start_del_effects
    :reader at_start_del_effects
    :initarg :at_start_del_effects
    :type (cl:vector rosplan_knowledge_msgs-msg:DomainFormula)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:DomainFormula :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula)))
   (at_end_add_effects
    :reader at_end_add_effects
    :initarg :at_end_add_effects
    :type (cl:vector rosplan_knowledge_msgs-msg:DomainFormula)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:DomainFormula :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula)))
   (at_end_del_effects
    :reader at_end_del_effects
    :initarg :at_end_del_effects
    :type (cl:vector rosplan_knowledge_msgs-msg:DomainFormula)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:DomainFormula :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula)))
   (at_start_assign_effects
    :reader at_start_assign_effects
    :initarg :at_start_assign_effects
    :type (cl:vector rosplan_knowledge_msgs-msg:DomainAssignment)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:DomainAssignment :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainAssignment)))
   (at_end_assign_effects
    :reader at_end_assign_effects
    :initarg :at_end_assign_effects
    :type (cl:vector rosplan_knowledge_msgs-msg:DomainAssignment)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:DomainAssignment :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainAssignment)))
   (at_start_simple_condition
    :reader at_start_simple_condition
    :initarg :at_start_simple_condition
    :type (cl:vector rosplan_knowledge_msgs-msg:DomainFormula)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:DomainFormula :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula)))
   (over_all_simple_condition
    :reader over_all_simple_condition
    :initarg :over_all_simple_condition
    :type (cl:vector rosplan_knowledge_msgs-msg:DomainFormula)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:DomainFormula :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula)))
   (at_end_simple_condition
    :reader at_end_simple_condition
    :initarg :at_end_simple_condition
    :type (cl:vector rosplan_knowledge_msgs-msg:DomainFormula)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:DomainFormula :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula)))
   (at_start_neg_condition
    :reader at_start_neg_condition
    :initarg :at_start_neg_condition
    :type (cl:vector rosplan_knowledge_msgs-msg:DomainFormula)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:DomainFormula :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula)))
   (over_all_neg_condition
    :reader over_all_neg_condition
    :initarg :over_all_neg_condition
    :type (cl:vector rosplan_knowledge_msgs-msg:DomainFormula)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:DomainFormula :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula)))
   (at_end_neg_condition
    :reader at_end_neg_condition
    :initarg :at_end_neg_condition
    :type (cl:vector rosplan_knowledge_msgs-msg:DomainFormula)
   :initform (cl:make-array 0 :element-type 'rosplan_knowledge_msgs-msg:DomainFormula :initial-element (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula))))
)

(cl:defclass DomainOperator (<DomainOperator>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DomainOperator>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DomainOperator)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rosplan_knowledge_msgs-msg:<DomainOperator> is deprecated: use rosplan_knowledge_msgs-msg:DomainOperator instead.")))

(cl:ensure-generic-function 'formula-val :lambda-list '(m))
(cl:defmethod formula-val ((m <DomainOperator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:formula-val is deprecated.  Use rosplan_knowledge_msgs-msg:formula instead.")
  (formula m))

(cl:ensure-generic-function 'at_start_add_effects-val :lambda-list '(m))
(cl:defmethod at_start_add_effects-val ((m <DomainOperator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:at_start_add_effects-val is deprecated.  Use rosplan_knowledge_msgs-msg:at_start_add_effects instead.")
  (at_start_add_effects m))

(cl:ensure-generic-function 'at_start_del_effects-val :lambda-list '(m))
(cl:defmethod at_start_del_effects-val ((m <DomainOperator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:at_start_del_effects-val is deprecated.  Use rosplan_knowledge_msgs-msg:at_start_del_effects instead.")
  (at_start_del_effects m))

(cl:ensure-generic-function 'at_end_add_effects-val :lambda-list '(m))
(cl:defmethod at_end_add_effects-val ((m <DomainOperator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:at_end_add_effects-val is deprecated.  Use rosplan_knowledge_msgs-msg:at_end_add_effects instead.")
  (at_end_add_effects m))

(cl:ensure-generic-function 'at_end_del_effects-val :lambda-list '(m))
(cl:defmethod at_end_del_effects-val ((m <DomainOperator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:at_end_del_effects-val is deprecated.  Use rosplan_knowledge_msgs-msg:at_end_del_effects instead.")
  (at_end_del_effects m))

(cl:ensure-generic-function 'at_start_assign_effects-val :lambda-list '(m))
(cl:defmethod at_start_assign_effects-val ((m <DomainOperator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:at_start_assign_effects-val is deprecated.  Use rosplan_knowledge_msgs-msg:at_start_assign_effects instead.")
  (at_start_assign_effects m))

(cl:ensure-generic-function 'at_end_assign_effects-val :lambda-list '(m))
(cl:defmethod at_end_assign_effects-val ((m <DomainOperator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:at_end_assign_effects-val is deprecated.  Use rosplan_knowledge_msgs-msg:at_end_assign_effects instead.")
  (at_end_assign_effects m))

(cl:ensure-generic-function 'at_start_simple_condition-val :lambda-list '(m))
(cl:defmethod at_start_simple_condition-val ((m <DomainOperator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:at_start_simple_condition-val is deprecated.  Use rosplan_knowledge_msgs-msg:at_start_simple_condition instead.")
  (at_start_simple_condition m))

(cl:ensure-generic-function 'over_all_simple_condition-val :lambda-list '(m))
(cl:defmethod over_all_simple_condition-val ((m <DomainOperator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:over_all_simple_condition-val is deprecated.  Use rosplan_knowledge_msgs-msg:over_all_simple_condition instead.")
  (over_all_simple_condition m))

(cl:ensure-generic-function 'at_end_simple_condition-val :lambda-list '(m))
(cl:defmethod at_end_simple_condition-val ((m <DomainOperator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:at_end_simple_condition-val is deprecated.  Use rosplan_knowledge_msgs-msg:at_end_simple_condition instead.")
  (at_end_simple_condition m))

(cl:ensure-generic-function 'at_start_neg_condition-val :lambda-list '(m))
(cl:defmethod at_start_neg_condition-val ((m <DomainOperator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:at_start_neg_condition-val is deprecated.  Use rosplan_knowledge_msgs-msg:at_start_neg_condition instead.")
  (at_start_neg_condition m))

(cl:ensure-generic-function 'over_all_neg_condition-val :lambda-list '(m))
(cl:defmethod over_all_neg_condition-val ((m <DomainOperator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:over_all_neg_condition-val is deprecated.  Use rosplan_knowledge_msgs-msg:over_all_neg_condition instead.")
  (over_all_neg_condition m))

(cl:ensure-generic-function 'at_end_neg_condition-val :lambda-list '(m))
(cl:defmethod at_end_neg_condition-val ((m <DomainOperator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rosplan_knowledge_msgs-msg:at_end_neg_condition-val is deprecated.  Use rosplan_knowledge_msgs-msg:at_end_neg_condition instead.")
  (at_end_neg_condition m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DomainOperator>) ostream)
  "Serializes a message object of type '<DomainOperator>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'formula) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'at_start_add_effects))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'at_start_add_effects))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'at_start_del_effects))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'at_start_del_effects))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'at_end_add_effects))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'at_end_add_effects))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'at_end_del_effects))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'at_end_del_effects))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'at_start_assign_effects))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'at_start_assign_effects))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'at_end_assign_effects))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'at_end_assign_effects))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'at_start_simple_condition))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'at_start_simple_condition))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'over_all_simple_condition))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'over_all_simple_condition))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'at_end_simple_condition))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'at_end_simple_condition))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'at_start_neg_condition))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'at_start_neg_condition))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'over_all_neg_condition))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'over_all_neg_condition))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'at_end_neg_condition))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'at_end_neg_condition))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DomainOperator>) istream)
  "Deserializes a message object of type '<DomainOperator>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'formula) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'at_start_add_effects) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'at_start_add_effects)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'at_start_del_effects) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'at_start_del_effects)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'at_end_add_effects) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'at_end_add_effects)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'at_end_del_effects) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'at_end_del_effects)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'at_start_assign_effects) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'at_start_assign_effects)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainAssignment))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'at_end_assign_effects) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'at_end_assign_effects)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainAssignment))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'at_start_simple_condition) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'at_start_simple_condition)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'over_all_simple_condition) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'over_all_simple_condition)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'at_end_simple_condition) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'at_end_simple_condition)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'at_start_neg_condition) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'at_start_neg_condition)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'over_all_neg_condition) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'over_all_neg_condition)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'at_end_neg_condition) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'at_end_neg_condition)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rosplan_knowledge_msgs-msg:DomainFormula))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DomainOperator>)))
  "Returns string type for a message object of type '<DomainOperator>"
  "rosplan_knowledge_msgs/DomainOperator")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DomainOperator)))
  "Returns string type for a message object of type 'DomainOperator"
  "rosplan_knowledge_msgs/DomainOperator")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DomainOperator>)))
  "Returns md5sum for a message object of type '<DomainOperator>"
  "f41e4eca186d347375561fa0ba1d4ab7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DomainOperator)))
  "Returns md5sum for a message object of type 'DomainOperator"
  "f41e4eca186d347375561fa0ba1d4ab7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DomainOperator>)))
  "Returns full string definition for message of type '<DomainOperator>"
  (cl:format cl:nil "# A message used to represent an ungrounded operator in the domain.~%~%# (1) name and parameters~%rosplan_knowledge_msgs/DomainFormula formula~%~%# (2) duration constraint~%~%~%# (3) effect lists~%rosplan_knowledge_msgs/DomainFormula[] at_start_add_effects~%rosplan_knowledge_msgs/DomainFormula[] at_start_del_effects~%rosplan_knowledge_msgs/DomainFormula[] at_end_add_effects~%rosplan_knowledge_msgs/DomainFormula[] at_end_del_effects~%rosplan_knowledge_msgs/DomainAssignment[] at_start_assign_effects~%rosplan_knowledge_msgs/DomainAssignment[] at_end_assign_effects~%~%# (4) conditions~%rosplan_knowledge_msgs/DomainFormula[] at_start_simple_condition~%rosplan_knowledge_msgs/DomainFormula[] over_all_simple_condition~%rosplan_knowledge_msgs/DomainFormula[] at_end_simple_condition~%rosplan_knowledge_msgs/DomainFormula[] at_start_neg_condition~%rosplan_knowledge_msgs/DomainFormula[] over_all_neg_condition~%rosplan_knowledge_msgs/DomainFormula[] at_end_neg_condition~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainAssignment~%# A message used to store the numeric effects of an action~%# Can be grounded or ungrounded~%~%uint8 ASSIGN   = 0~%uint8 INCREASE  = 1~%uint8 DECREASE = 2~%uint8 SCALE_UP = 3~%uint8 SCALE_DOWN = 4~%uint8 ASSIGN_CTS = 5~%~%uint8 assign_type~%~%rosplan_knowledge_msgs/DomainFormula LHS~%rosplan_knowledge_msgs/ExprComposite RHS~%~%bool grounded~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprComposite~%# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DomainOperator)))
  "Returns full string definition for message of type 'DomainOperator"
  (cl:format cl:nil "# A message used to represent an ungrounded operator in the domain.~%~%# (1) name and parameters~%rosplan_knowledge_msgs/DomainFormula formula~%~%# (2) duration constraint~%~%~%# (3) effect lists~%rosplan_knowledge_msgs/DomainFormula[] at_start_add_effects~%rosplan_knowledge_msgs/DomainFormula[] at_start_del_effects~%rosplan_knowledge_msgs/DomainFormula[] at_end_add_effects~%rosplan_knowledge_msgs/DomainFormula[] at_end_del_effects~%rosplan_knowledge_msgs/DomainAssignment[] at_start_assign_effects~%rosplan_knowledge_msgs/DomainAssignment[] at_end_assign_effects~%~%# (4) conditions~%rosplan_knowledge_msgs/DomainFormula[] at_start_simple_condition~%rosplan_knowledge_msgs/DomainFormula[] over_all_simple_condition~%rosplan_knowledge_msgs/DomainFormula[] at_end_simple_condition~%rosplan_knowledge_msgs/DomainFormula[] at_start_neg_condition~%rosplan_knowledge_msgs/DomainFormula[] over_all_neg_condition~%rosplan_knowledge_msgs/DomainFormula[] at_end_neg_condition~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainFormula~%# A message used to represent an atomic formula from the domain.~%# typed_parameters matches label -> type~%string name~%diagnostic_msgs/KeyValue[] typed_parameters~%~%================================================================================~%MSG: diagnostic_msgs/KeyValue~%string key # what to label this value when viewing~%string value # a value to track over time~%~%================================================================================~%MSG: rosplan_knowledge_msgs/DomainAssignment~%# A message used to store the numeric effects of an action~%# Can be grounded or ungrounded~%~%uint8 ASSIGN   = 0~%uint8 INCREASE  = 1~%uint8 DECREASE = 2~%uint8 SCALE_UP = 3~%uint8 SCALE_DOWN = 4~%uint8 ASSIGN_CTS = 5~%~%uint8 assign_type~%~%rosplan_knowledge_msgs/DomainFormula LHS~%rosplan_knowledge_msgs/ExprComposite RHS~%~%bool grounded~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprComposite~%# A message used to represent a numerical expression; composite type (2/2)~%# stores an array of ExprBase as prefix notation~%~%# components~%ExprBase[] tokens~%~%================================================================================~%MSG: rosplan_knowledge_msgs/ExprBase~%# A message used to represent a numerical expression; base types (1/2)~%~%# expression types~%uint8 CONSTANT = 0~%uint8 FUNCTION = 1~%uint8 OPERATOR = 2~%uint8 SPECIAL  = 3~%~%# operators~%uint8 ADD    = 0~%uint8 SUB    = 1~%uint8 MUL    = 2~%uint8 DIV    = 3~%uint8 UMINUS = 4~%~%# special types~%uint8 HASHT      = 0~%uint8 TOTAL_TIME = 1~%uint8 DURATION   = 2~%~%# expression base type~%uint8 expr_type~%~%# constant value~%float64 constant~%~%# function~%rosplan_knowledge_msgs/DomainFormula function~%~%# operator~%uint8 op~%~%# special~%uint8 special_type~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DomainOperator>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'formula))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'at_start_add_effects) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'at_start_del_effects) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'at_end_add_effects) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'at_end_del_effects) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'at_start_assign_effects) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'at_end_assign_effects) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'at_start_simple_condition) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'over_all_simple_condition) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'at_end_simple_condition) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'at_start_neg_condition) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'over_all_neg_condition) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'at_end_neg_condition) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DomainOperator>))
  "Converts a ROS message object to a list"
  (cl:list 'DomainOperator
    (cl:cons ':formula (formula msg))
    (cl:cons ':at_start_add_effects (at_start_add_effects msg))
    (cl:cons ':at_start_del_effects (at_start_del_effects msg))
    (cl:cons ':at_end_add_effects (at_end_add_effects msg))
    (cl:cons ':at_end_del_effects (at_end_del_effects msg))
    (cl:cons ':at_start_assign_effects (at_start_assign_effects msg))
    (cl:cons ':at_end_assign_effects (at_end_assign_effects msg))
    (cl:cons ':at_start_simple_condition (at_start_simple_condition msg))
    (cl:cons ':over_all_simple_condition (over_all_simple_condition msg))
    (cl:cons ':at_end_simple_condition (at_end_simple_condition msg))
    (cl:cons ':at_start_neg_condition (at_start_neg_condition msg))
    (cl:cons ':over_all_neg_condition (over_all_neg_condition msg))
    (cl:cons ':at_end_neg_condition (at_end_neg_condition msg))
))
