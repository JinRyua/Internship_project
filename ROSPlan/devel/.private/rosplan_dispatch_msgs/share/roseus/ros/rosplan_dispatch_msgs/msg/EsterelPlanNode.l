;; Auto-generated. Do not edit!


(when (boundp 'rosplan_dispatch_msgs::EsterelPlanNode)
  (if (not (find-package "ROSPLAN_DISPATCH_MSGS"))
    (make-package "ROSPLAN_DISPATCH_MSGS"))
  (shadow 'EsterelPlanNode (find-package "ROSPLAN_DISPATCH_MSGS")))
(unless (find-package "ROSPLAN_DISPATCH_MSGS::ESTERELPLANNODE")
  (make-package "ROSPLAN_DISPATCH_MSGS::ESTERELPLANNODE"))

(in-package "ROS")
;;//! \htmlinclude EsterelPlanNode.msg.html


(intern "*ACTION_START*" (find-package "ROSPLAN_DISPATCH_MSGS::ESTERELPLANNODE"))
(shadow '*ACTION_START* (find-package "ROSPLAN_DISPATCH_MSGS::ESTERELPLANNODE"))
(defconstant rosplan_dispatch_msgs::EsterelPlanNode::*ACTION_START* 0)
(intern "*ACTION_END*" (find-package "ROSPLAN_DISPATCH_MSGS::ESTERELPLANNODE"))
(shadow '*ACTION_END* (find-package "ROSPLAN_DISPATCH_MSGS::ESTERELPLANNODE"))
(defconstant rosplan_dispatch_msgs::EsterelPlanNode::*ACTION_END* 1)
(intern "*PLAN_START*" (find-package "ROSPLAN_DISPATCH_MSGS::ESTERELPLANNODE"))
(shadow '*PLAN_START* (find-package "ROSPLAN_DISPATCH_MSGS::ESTERELPLANNODE"))
(defconstant rosplan_dispatch_msgs::EsterelPlanNode::*PLAN_START* 2)
(defclass rosplan_dispatch_msgs::EsterelPlanNode
  :super ros::object
  :slots (_node_type _node_id _name _action _edges_out _edges_in ))

(defmethod rosplan_dispatch_msgs::EsterelPlanNode
  (:init
   (&key
    ((:node_type __node_type) 0)
    ((:node_id __node_id) 0)
    ((:name __name) "")
    ((:action __action) (instance rosplan_dispatch_msgs::ActionDispatch :init))
    ((:edges_out __edges_out) (make-array 0 :initial-element 0 :element-type :integer))
    ((:edges_in __edges_in) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _node_type (round __node_type))
   (setq _node_id (round __node_id))
   (setq _name (string __name))
   (setq _action __action)
   (setq _edges_out __edges_out)
   (setq _edges_in __edges_in)
   self)
  (:node_type
   (&optional __node_type)
   (if __node_type (setq _node_type __node_type)) _node_type)
  (:node_id
   (&optional __node_id)
   (if __node_id (setq _node_id __node_id)) _node_id)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:action
   (&rest __action)
   (if (keywordp (car __action))
       (send* _action __action)
     (progn
       (if __action (setq _action (car __action)))
       _action)))
  (:edges_out
   (&optional __edges_out)
   (if __edges_out (setq _edges_out __edges_out)) _edges_out)
  (:edges_in
   (&optional __edges_in)
   (if __edges_in (setq _edges_in __edges_in)) _edges_in)
  (:serialization-length
   ()
   (+
    ;; byte _node_type
    1
    ;; int32 _node_id
    4
    ;; string _name
    4 (length _name)
    ;; rosplan_dispatch_msgs/ActionDispatch _action
    (send _action :serialization-length)
    ;; int32[] _edges_out
    (* 4    (length _edges_out)) 4
    ;; int32[] _edges_in
    (* 4    (length _edges_in)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; byte _node_type
       (write-byte _node_type s)
     ;; int32 _node_id
       (write-long _node_id s)
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; rosplan_dispatch_msgs/ActionDispatch _action
       (send _action :serialize s)
     ;; int32[] _edges_out
     (write-long (length _edges_out) s)
     (dotimes (i (length _edges_out))
       (write-long (elt _edges_out i) s)
       )
     ;; int32[] _edges_in
     (write-long (length _edges_in) s)
     (dotimes (i (length _edges_in))
       (write-long (elt _edges_in i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; byte _node_type
     (setq _node_type (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _node_type 127) (setq _node_type (- _node_type 256)))
   ;; int32 _node_id
     (setq _node_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; rosplan_dispatch_msgs/ActionDispatch _action
     (send _action :deserialize buf ptr-) (incf ptr- (send _action :serialization-length))
   ;; int32[] _edges_out
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _edges_out (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _edges_out i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32[] _edges_in
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _edges_in (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _edges_in i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get rosplan_dispatch_msgs::EsterelPlanNode :md5sum-) "da4ec1de4a3a375abc1d2472c95de8b7")
(setf (get rosplan_dispatch_msgs::EsterelPlanNode :datatype-) "rosplan_dispatch_msgs/EsterelPlanNode")
(setf (get rosplan_dispatch_msgs::EsterelPlanNode :definition-)
      "#EsterelPlanNode message

byte ACTION_START = 0
byte ACTION_END   = 1
byte PLAN_START   = 2

byte node_type
int32 node_id
string name
rosplan_dispatch_msgs/ActionDispatch action

int32[] edges_out
int32[] edges_in

================================================================================
MSG: rosplan_dispatch_msgs/ActionDispatch
#actionDispatch message
int32 action_id
string name
diagnostic_msgs/KeyValue[] parameters
float32 duration
float32 dispatch_time

================================================================================
MSG: diagnostic_msgs/KeyValue
string key # what to label this value when viewing
string value # a value to track over time

")



(provide :rosplan_dispatch_msgs/EsterelPlanNode "da4ec1de4a3a375abc1d2472c95de8b7")


