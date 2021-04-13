;; Auto-generated. Do not edit!


(when (boundp 'rosplan_dispatch_msgs::CompletePlan)
  (if (not (find-package "ROSPLAN_DISPATCH_MSGS"))
    (make-package "ROSPLAN_DISPATCH_MSGS"))
  (shadow 'CompletePlan (find-package "ROSPLAN_DISPATCH_MSGS")))
(unless (find-package "ROSPLAN_DISPATCH_MSGS::COMPLETEPLAN")
  (make-package "ROSPLAN_DISPATCH_MSGS::COMPLETEPLAN"))

(in-package "ROS")
;;//! \htmlinclude CompletePlan.msg.html


(defclass rosplan_dispatch_msgs::CompletePlan
  :super ros::object
  :slots (_plan ))

(defmethod rosplan_dispatch_msgs::CompletePlan
  (:init
   (&key
    ((:plan __plan) (let (r) (dotimes (i 0) (push (instance rosplan_dispatch_msgs::ActionDispatch :init) r)) r))
    )
   (send-super :init)
   (setq _plan __plan)
   self)
  (:plan
   (&rest __plan)
   (if (keywordp (car __plan))
       (send* _plan __plan)
     (progn
       (if __plan (setq _plan (car __plan)))
       _plan)))
  (:serialization-length
   ()
   (+
    ;; rosplan_dispatch_msgs/ActionDispatch[] _plan
    (apply #'+ (send-all _plan :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; rosplan_dispatch_msgs/ActionDispatch[] _plan
     (write-long (length _plan) s)
     (dolist (elem _plan)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; rosplan_dispatch_msgs/ActionDispatch[] _plan
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _plan (let (r) (dotimes (i n) (push (instance rosplan_dispatch_msgs::ActionDispatch :init) r)) r))
     (dolist (elem- _plan)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get rosplan_dispatch_msgs::CompletePlan :md5sum-) "7e1d10b4d2f9481e13d9d30c7a8045ff")
(setf (get rosplan_dispatch_msgs::CompletePlan :datatype-) "rosplan_dispatch_msgs/CompletePlan")
(setf (get rosplan_dispatch_msgs::CompletePlan :definition-)
      "#completePlan message
ActionDispatch[] plan

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



(provide :rosplan_dispatch_msgs/CompletePlan "7e1d10b4d2f9481e13d9d30c7a8045ff")


