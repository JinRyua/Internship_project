;; Auto-generated. Do not edit!


(when (boundp 'rosplan_dispatch_msgs::EsterelPlan)
  (if (not (find-package "ROSPLAN_DISPATCH_MSGS"))
    (make-package "ROSPLAN_DISPATCH_MSGS"))
  (shadow 'EsterelPlan (find-package "ROSPLAN_DISPATCH_MSGS")))
(unless (find-package "ROSPLAN_DISPATCH_MSGS::ESTERELPLAN")
  (make-package "ROSPLAN_DISPATCH_MSGS::ESTERELPLAN"))

(in-package "ROS")
;;//! \htmlinclude EsterelPlan.msg.html


(defclass rosplan_dispatch_msgs::EsterelPlan
  :super ros::object
  :slots (_nodes _edges ))

(defmethod rosplan_dispatch_msgs::EsterelPlan
  (:init
   (&key
    ((:nodes __nodes) (let (r) (dotimes (i 0) (push (instance rosplan_dispatch_msgs::EsterelPlanNode :init) r)) r))
    ((:edges __edges) (let (r) (dotimes (i 0) (push (instance rosplan_dispatch_msgs::EsterelPlanEdge :init) r)) r))
    )
   (send-super :init)
   (setq _nodes __nodes)
   (setq _edges __edges)
   self)
  (:nodes
   (&rest __nodes)
   (if (keywordp (car __nodes))
       (send* _nodes __nodes)
     (progn
       (if __nodes (setq _nodes (car __nodes)))
       _nodes)))
  (:edges
   (&rest __edges)
   (if (keywordp (car __edges))
       (send* _edges __edges)
     (progn
       (if __edges (setq _edges (car __edges)))
       _edges)))
  (:serialization-length
   ()
   (+
    ;; rosplan_dispatch_msgs/EsterelPlanNode[] _nodes
    (apply #'+ (send-all _nodes :serialization-length)) 4
    ;; rosplan_dispatch_msgs/EsterelPlanEdge[] _edges
    (apply #'+ (send-all _edges :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; rosplan_dispatch_msgs/EsterelPlanNode[] _nodes
     (write-long (length _nodes) s)
     (dolist (elem _nodes)
       (send elem :serialize s)
       )
     ;; rosplan_dispatch_msgs/EsterelPlanEdge[] _edges
     (write-long (length _edges) s)
     (dolist (elem _edges)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; rosplan_dispatch_msgs/EsterelPlanNode[] _nodes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _nodes (let (r) (dotimes (i n) (push (instance rosplan_dispatch_msgs::EsterelPlanNode :init) r)) r))
     (dolist (elem- _nodes)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; rosplan_dispatch_msgs/EsterelPlanEdge[] _edges
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _edges (let (r) (dotimes (i n) (push (instance rosplan_dispatch_msgs::EsterelPlanEdge :init) r)) r))
     (dolist (elem- _edges)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get rosplan_dispatch_msgs::EsterelPlan :md5sum-) "e505c1d88305f080c9c58693879a1a79")
(setf (get rosplan_dispatch_msgs::EsterelPlan :datatype-) "rosplan_dispatch_msgs/EsterelPlan")
(setf (get rosplan_dispatch_msgs::EsterelPlan :definition-)
      "#EsterelPlan message
EsterelPlanNode[] nodes
EsterelPlanEdge[] edges

================================================================================
MSG: rosplan_dispatch_msgs/EsterelPlanNode
#EsterelPlanNode message

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

================================================================================
MSG: rosplan_dispatch_msgs/EsterelPlanEdge
#EsterelPlanEdge message
int32 edge_id
string edge_name
int32 signal_type
int32[] source_ids
int32[] sink_ids
float64 duration_lower_bound
float64 duration_upper_bound

")



(provide :rosplan_dispatch_msgs/EsterelPlan "e505c1d88305f080c9c58693879a1a79")


