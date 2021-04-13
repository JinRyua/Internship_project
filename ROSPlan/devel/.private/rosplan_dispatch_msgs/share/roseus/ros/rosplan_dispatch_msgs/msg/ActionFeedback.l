;; Auto-generated. Do not edit!


(when (boundp 'rosplan_dispatch_msgs::ActionFeedback)
  (if (not (find-package "ROSPLAN_DISPATCH_MSGS"))
    (make-package "ROSPLAN_DISPATCH_MSGS"))
  (shadow 'ActionFeedback (find-package "ROSPLAN_DISPATCH_MSGS")))
(unless (find-package "ROSPLAN_DISPATCH_MSGS::ACTIONFEEDBACK")
  (make-package "ROSPLAN_DISPATCH_MSGS::ACTIONFEEDBACK"))

(in-package "ROS")
;;//! \htmlinclude ActionFeedback.msg.html
(if (not (find-package "DIAGNOSTIC_MSGS"))
  (ros::roseus-add-msgs "diagnostic_msgs"))


(defclass rosplan_dispatch_msgs::ActionFeedback
  :super ros::object
  :slots (_action_id _status _information ))

(defmethod rosplan_dispatch_msgs::ActionFeedback
  (:init
   (&key
    ((:action_id __action_id) 0)
    ((:status __status) "")
    ((:information __information) (let (r) (dotimes (i 0) (push (instance diagnostic_msgs::KeyValue :init) r)) r))
    )
   (send-super :init)
   (setq _action_id (round __action_id))
   (setq _status (string __status))
   (setq _information __information)
   self)
  (:action_id
   (&optional __action_id)
   (if __action_id (setq _action_id __action_id)) _action_id)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:information
   (&rest __information)
   (if (keywordp (car __information))
       (send* _information __information)
     (progn
       (if __information (setq _information (car __information)))
       _information)))
  (:serialization-length
   ()
   (+
    ;; int32 _action_id
    4
    ;; string _status
    4 (length _status)
    ;; diagnostic_msgs/KeyValue[] _information
    (apply #'+ (send-all _information :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _action_id
       (write-long _action_id s)
     ;; string _status
       (write-long (length _status) s) (princ _status s)
     ;; diagnostic_msgs/KeyValue[] _information
     (write-long (length _information) s)
     (dolist (elem _information)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _action_id
     (setq _action_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _status
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _status (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; diagnostic_msgs/KeyValue[] _information
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _information (let (r) (dotimes (i n) (push (instance diagnostic_msgs::KeyValue :init) r)) r))
     (dolist (elem- _information)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get rosplan_dispatch_msgs::ActionFeedback :md5sum-) "e28991799802dd700e1390bf56614b89")
(setf (get rosplan_dispatch_msgs::ActionFeedback :datatype-) "rosplan_dispatch_msgs/ActionFeedback")
(setf (get rosplan_dispatch_msgs::ActionFeedback :definition-)
      "#actionFeedback message
int32 action_id
string status
diagnostic_msgs/KeyValue[] information

================================================================================
MSG: diagnostic_msgs/KeyValue
string key # what to label this value when viewing
string value # a value to track over time

")



(provide :rosplan_dispatch_msgs/ActionFeedback "e28991799802dd700e1390bf56614b89")


