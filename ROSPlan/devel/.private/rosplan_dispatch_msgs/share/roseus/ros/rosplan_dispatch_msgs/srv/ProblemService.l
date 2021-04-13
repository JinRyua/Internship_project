;; Auto-generated. Do not edit!


(when (boundp 'rosplan_dispatch_msgs::ProblemService)
  (if (not (find-package "ROSPLAN_DISPATCH_MSGS"))
    (make-package "ROSPLAN_DISPATCH_MSGS"))
  (shadow 'ProblemService (find-package "ROSPLAN_DISPATCH_MSGS")))
(unless (find-package "ROSPLAN_DISPATCH_MSGS::PROBLEMSERVICE")
  (make-package "ROSPLAN_DISPATCH_MSGS::PROBLEMSERVICE"))
(unless (find-package "ROSPLAN_DISPATCH_MSGS::PROBLEMSERVICEREQUEST")
  (make-package "ROSPLAN_DISPATCH_MSGS::PROBLEMSERVICEREQUEST"))
(unless (find-package "ROSPLAN_DISPATCH_MSGS::PROBLEMSERVICERESPONSE")
  (make-package "ROSPLAN_DISPATCH_MSGS::PROBLEMSERVICERESPONSE"))

(in-package "ROS")





(defclass rosplan_dispatch_msgs::ProblemServiceRequest
  :super ros::object
  :slots (_problem_path _problem_string_response ))

(defmethod rosplan_dispatch_msgs::ProblemServiceRequest
  (:init
   (&key
    ((:problem_path __problem_path) "")
    ((:problem_string_response __problem_string_response) nil)
    )
   (send-super :init)
   (setq _problem_path (string __problem_path))
   (setq _problem_string_response __problem_string_response)
   self)
  (:problem_path
   (&optional __problem_path)
   (if __problem_path (setq _problem_path __problem_path)) _problem_path)
  (:problem_string_response
   (&optional __problem_string_response)
   (if __problem_string_response (setq _problem_string_response __problem_string_response)) _problem_string_response)
  (:serialization-length
   ()
   (+
    ;; string _problem_path
    4 (length _problem_path)
    ;; bool _problem_string_response
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _problem_path
       (write-long (length _problem_path) s) (princ _problem_path s)
     ;; bool _problem_string_response
       (if _problem_string_response (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _problem_path
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _problem_path (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _problem_string_response
     (setq _problem_string_response (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass rosplan_dispatch_msgs::ProblemServiceResponse
  :super ros::object
  :slots (_problem_generated _problem_string ))

(defmethod rosplan_dispatch_msgs::ProblemServiceResponse
  (:init
   (&key
    ((:problem_generated __problem_generated) nil)
    ((:problem_string __problem_string) "")
    )
   (send-super :init)
   (setq _problem_generated __problem_generated)
   (setq _problem_string (string __problem_string))
   self)
  (:problem_generated
   (&optional __problem_generated)
   (if __problem_generated (setq _problem_generated __problem_generated)) _problem_generated)
  (:problem_string
   (&optional __problem_string)
   (if __problem_string (setq _problem_string __problem_string)) _problem_string)
  (:serialization-length
   ()
   (+
    ;; bool _problem_generated
    1
    ;; string _problem_string
    4 (length _problem_string)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _problem_generated
       (if _problem_generated (write-byte -1 s) (write-byte 0 s))
     ;; string _problem_string
       (write-long (length _problem_string) s) (princ _problem_string s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _problem_generated
     (setq _problem_generated (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _problem_string
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _problem_string (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass rosplan_dispatch_msgs::ProblemService
  :super ros::object
  :slots ())

(setf (get rosplan_dispatch_msgs::ProblemService :md5sum-) "61fb3e0dd88c35b2c75cf0b688f40ee8")
(setf (get rosplan_dispatch_msgs::ProblemService :datatype-) "rosplan_dispatch_msgs/ProblemService")
(setf (get rosplan_dispatch_msgs::ProblemService :request) rosplan_dispatch_msgs::ProblemServiceRequest)
(setf (get rosplan_dispatch_msgs::ProblemService :response) rosplan_dispatch_msgs::ProblemServiceResponse)

(defmethod rosplan_dispatch_msgs::ProblemServiceRequest
  (:response () (instance rosplan_dispatch_msgs::ProblemServiceResponse :init)))

(setf (get rosplan_dispatch_msgs::ProblemServiceRequest :md5sum-) "61fb3e0dd88c35b2c75cf0b688f40ee8")
(setf (get rosplan_dispatch_msgs::ProblemServiceRequest :datatype-) "rosplan_dispatch_msgs/ProblemServiceRequest")
(setf (get rosplan_dispatch_msgs::ProblemServiceRequest :definition-)
      "# request a problem to be generated in the problem_path
string problem_path
bool problem_string_response
---
bool problem_generated
string problem_string

")

(setf (get rosplan_dispatch_msgs::ProblemServiceResponse :md5sum-) "61fb3e0dd88c35b2c75cf0b688f40ee8")
(setf (get rosplan_dispatch_msgs::ProblemServiceResponse :datatype-) "rosplan_dispatch_msgs/ProblemServiceResponse")
(setf (get rosplan_dispatch_msgs::ProblemServiceResponse :definition-)
      "# request a problem to be generated in the problem_path
string problem_path
bool problem_string_response
---
bool problem_generated
string problem_string

")



(provide :rosplan_dispatch_msgs/ProblemService "61fb3e0dd88c35b2c75cf0b688f40ee8")


