;; Auto-generated. Do not edit!


(when (boundp 'rosplan_dispatch_msgs::ActionDispatch)
  (if (not (find-package "ROSPLAN_DISPATCH_MSGS"))
    (make-package "ROSPLAN_DISPATCH_MSGS"))
  (shadow 'ActionDispatch (find-package "ROSPLAN_DISPATCH_MSGS")))
(unless (find-package "ROSPLAN_DISPATCH_MSGS::ACTIONDISPATCH")
  (make-package "ROSPLAN_DISPATCH_MSGS::ACTIONDISPATCH"))

(in-package "ROS")
;;//! \htmlinclude ActionDispatch.msg.html
(if (not (find-package "DIAGNOSTIC_MSGS"))
  (ros::roseus-add-msgs "diagnostic_msgs"))


(defclass rosplan_dispatch_msgs::ActionDispatch
  :super ros::object
  :slots (_action_id _name _parameters _duration _dispatch_time ))

(defmethod rosplan_dispatch_msgs::ActionDispatch
  (:init
   (&key
    ((:action_id __action_id) 0)
    ((:name __name) "")
    ((:parameters __parameters) (let (r) (dotimes (i 0) (push (instance diagnostic_msgs::KeyValue :init) r)) r))
    ((:duration __duration) 0.0)
    ((:dispatch_time __dispatch_time) 0.0)
    )
   (send-super :init)
   (setq _action_id (round __action_id))
   (setq _name (string __name))
   (setq _parameters __parameters)
   (setq _duration (float __duration))
   (setq _dispatch_time (float __dispatch_time))
   self)
  (:action_id
   (&optional __action_id)
   (if __action_id (setq _action_id __action_id)) _action_id)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:parameters
   (&rest __parameters)
   (if (keywordp (car __parameters))
       (send* _parameters __parameters)
     (progn
       (if __parameters (setq _parameters (car __parameters)))
       _parameters)))
  (:duration
   (&optional __duration)
   (if __duration (setq _duration __duration)) _duration)
  (:dispatch_time
   (&optional __dispatch_time)
   (if __dispatch_time (setq _dispatch_time __dispatch_time)) _dispatch_time)
  (:serialization-length
   ()
   (+
    ;; int32 _action_id
    4
    ;; string _name
    4 (length _name)
    ;; diagnostic_msgs/KeyValue[] _parameters
    (apply #'+ (send-all _parameters :serialization-length)) 4
    ;; float32 _duration
    4
    ;; float32 _dispatch_time
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _action_id
       (write-long _action_id s)
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; diagnostic_msgs/KeyValue[] _parameters
     (write-long (length _parameters) s)
     (dolist (elem _parameters)
       (send elem :serialize s)
       )
     ;; float32 _duration
       (sys::poke _duration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _dispatch_time
       (sys::poke _dispatch_time (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _action_id
     (setq _action_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; diagnostic_msgs/KeyValue[] _parameters
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _parameters (let (r) (dotimes (i n) (push (instance diagnostic_msgs::KeyValue :init) r)) r))
     (dolist (elem- _parameters)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; float32 _duration
     (setq _duration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dispatch_time
     (setq _dispatch_time (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get rosplan_dispatch_msgs::ActionDispatch :md5sum-) "80f1ebdf8c68451c7e598f98e7f12dba")
(setf (get rosplan_dispatch_msgs::ActionDispatch :datatype-) "rosplan_dispatch_msgs/ActionDispatch")
(setf (get rosplan_dispatch_msgs::ActionDispatch :definition-)
      "#actionDispatch message
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



(provide :rosplan_dispatch_msgs/ActionDispatch "80f1ebdf8c68451c7e598f98e7f12dba")


