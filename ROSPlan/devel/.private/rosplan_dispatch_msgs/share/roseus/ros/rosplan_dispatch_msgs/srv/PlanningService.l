;; Auto-generated. Do not edit!


(when (boundp 'rosplan_dispatch_msgs::PlanningService)
  (if (not (find-package "ROSPLAN_DISPATCH_MSGS"))
    (make-package "ROSPLAN_DISPATCH_MSGS"))
  (shadow 'PlanningService (find-package "ROSPLAN_DISPATCH_MSGS")))
(unless (find-package "ROSPLAN_DISPATCH_MSGS::PLANNINGSERVICE")
  (make-package "ROSPLAN_DISPATCH_MSGS::PLANNINGSERVICE"))
(unless (find-package "ROSPLAN_DISPATCH_MSGS::PLANNINGSERVICEREQUEST")
  (make-package "ROSPLAN_DISPATCH_MSGS::PLANNINGSERVICEREQUEST"))
(unless (find-package "ROSPLAN_DISPATCH_MSGS::PLANNINGSERVICERESPONSE")
  (make-package "ROSPLAN_DISPATCH_MSGS::PLANNINGSERVICERESPONSE"))

(in-package "ROS")





(defclass rosplan_dispatch_msgs::PlanningServiceRequest
  :super ros::object
  :slots (_domain_path _problem_path _data_path _planner_command _use_problem_topic ))

(defmethod rosplan_dispatch_msgs::PlanningServiceRequest
  (:init
   (&key
    ((:domain_path __domain_path) "")
    ((:problem_path __problem_path) "")
    ((:data_path __data_path) "")
    ((:planner_command __planner_command) "")
    ((:use_problem_topic __use_problem_topic) nil)
    )
   (send-super :init)
   (setq _domain_path (string __domain_path))
   (setq _problem_path (string __problem_path))
   (setq _data_path (string __data_path))
   (setq _planner_command (string __planner_command))
   (setq _use_problem_topic __use_problem_topic)
   self)
  (:domain_path
   (&optional __domain_path)
   (if __domain_path (setq _domain_path __domain_path)) _domain_path)
  (:problem_path
   (&optional __problem_path)
   (if __problem_path (setq _problem_path __problem_path)) _problem_path)
  (:data_path
   (&optional __data_path)
   (if __data_path (setq _data_path __data_path)) _data_path)
  (:planner_command
   (&optional __planner_command)
   (if __planner_command (setq _planner_command __planner_command)) _planner_command)
  (:use_problem_topic
   (&optional __use_problem_topic)
   (if __use_problem_topic (setq _use_problem_topic __use_problem_topic)) _use_problem_topic)
  (:serialization-length
   ()
   (+
    ;; string _domain_path
    4 (length _domain_path)
    ;; string _problem_path
    4 (length _problem_path)
    ;; string _data_path
    4 (length _data_path)
    ;; string _planner_command
    4 (length _planner_command)
    ;; bool _use_problem_topic
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _domain_path
       (write-long (length _domain_path) s) (princ _domain_path s)
     ;; string _problem_path
       (write-long (length _problem_path) s) (princ _problem_path s)
     ;; string _data_path
       (write-long (length _data_path) s) (princ _data_path s)
     ;; string _planner_command
       (write-long (length _planner_command) s) (princ _planner_command s)
     ;; bool _use_problem_topic
       (if _use_problem_topic (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _domain_path
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _domain_path (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _problem_path
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _problem_path (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _data_path
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _data_path (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _planner_command
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _planner_command (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _use_problem_topic
     (setq _use_problem_topic (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass rosplan_dispatch_msgs::PlanningServiceResponse
  :super ros::object
  :slots (_plan_found ))

(defmethod rosplan_dispatch_msgs::PlanningServiceResponse
  (:init
   (&key
    ((:plan_found __plan_found) nil)
    )
   (send-super :init)
   (setq _plan_found __plan_found)
   self)
  (:plan_found
   (&optional __plan_found)
   (if __plan_found (setq _plan_found __plan_found)) _plan_found)
  (:serialization-length
   ()
   (+
    ;; bool _plan_found
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _plan_found
       (if _plan_found (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _plan_found
     (setq _plan_found (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass rosplan_dispatch_msgs::PlanningService
  :super ros::object
  :slots ())

(setf (get rosplan_dispatch_msgs::PlanningService :md5sum-) "b620a1e7a07d465aa5a10fe0ee615756")
(setf (get rosplan_dispatch_msgs::PlanningService :datatype-) "rosplan_dispatch_msgs/PlanningService")
(setf (get rosplan_dispatch_msgs::PlanningService :request) rosplan_dispatch_msgs::PlanningServiceRequest)
(setf (get rosplan_dispatch_msgs::PlanningService :response) rosplan_dispatch_msgs::PlanningServiceResponse)

(defmethod rosplan_dispatch_msgs::PlanningServiceRequest
  (:response () (instance rosplan_dispatch_msgs::PlanningServiceResponse :init)))

(setf (get rosplan_dispatch_msgs::PlanningServiceRequest :md5sum-) "b620a1e7a07d465aa5a10fe0ee615756")
(setf (get rosplan_dispatch_msgs::PlanningServiceRequest :datatype-) "rosplan_dispatch_msgs/PlanningServiceRequest")
(setf (get rosplan_dispatch_msgs::PlanningServiceRequest :definition-)
      "# starts the planning and dispatch
string domain_path
string problem_path
string data_path
string planner_command
bool use_problem_topic
---
bool plan_found

")

(setf (get rosplan_dispatch_msgs::PlanningServiceResponse :md5sum-) "b620a1e7a07d465aa5a10fe0ee615756")
(setf (get rosplan_dispatch_msgs::PlanningServiceResponse :datatype-) "rosplan_dispatch_msgs/PlanningServiceResponse")
(setf (get rosplan_dispatch_msgs::PlanningServiceResponse :definition-)
      "# starts the planning and dispatch
string domain_path
string problem_path
string data_path
string planner_command
bool use_problem_topic
---
bool plan_found

")



(provide :rosplan_dispatch_msgs/PlanningService "b620a1e7a07d465aa5a10fe0ee615756")


