;; Auto-generated. Do not edit!


(when (boundp 'rosplan_dispatch_msgs::ParsingService)
  (if (not (find-package "ROSPLAN_DISPATCH_MSGS"))
    (make-package "ROSPLAN_DISPATCH_MSGS"))
  (shadow 'ParsingService (find-package "ROSPLAN_DISPATCH_MSGS")))
(unless (find-package "ROSPLAN_DISPATCH_MSGS::PARSINGSERVICE")
  (make-package "ROSPLAN_DISPATCH_MSGS::PARSINGSERVICE"))
(unless (find-package "ROSPLAN_DISPATCH_MSGS::PARSINGSERVICEREQUEST")
  (make-package "ROSPLAN_DISPATCH_MSGS::PARSINGSERVICEREQUEST"))
(unless (find-package "ROSPLAN_DISPATCH_MSGS::PARSINGSERVICERESPONSE")
  (make-package "ROSPLAN_DISPATCH_MSGS::PARSINGSERVICERESPONSE"))

(in-package "ROS")





(defclass rosplan_dispatch_msgs::ParsingServiceRequest
  :super ros::object
  :slots (_plan_path ))

(defmethod rosplan_dispatch_msgs::ParsingServiceRequest
  (:init
   (&key
    ((:plan_path __plan_path) "")
    )
   (send-super :init)
   (setq _plan_path (string __plan_path))
   self)
  (:plan_path
   (&optional __plan_path)
   (if __plan_path (setq _plan_path __plan_path)) _plan_path)
  (:serialization-length
   ()
   (+
    ;; string _plan_path
    4 (length _plan_path)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _plan_path
       (write-long (length _plan_path) s) (princ _plan_path s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _plan_path
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _plan_path (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass rosplan_dispatch_msgs::ParsingServiceResponse
  :super ros::object
  :slots (_plan_parsed ))

(defmethod rosplan_dispatch_msgs::ParsingServiceResponse
  (:init
   (&key
    ((:plan_parsed __plan_parsed) nil)
    )
   (send-super :init)
   (setq _plan_parsed __plan_parsed)
   self)
  (:plan_parsed
   (&optional __plan_parsed)
   (if __plan_parsed (setq _plan_parsed __plan_parsed)) _plan_parsed)
  (:serialization-length
   ()
   (+
    ;; bool _plan_parsed
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _plan_parsed
       (if _plan_parsed (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _plan_parsed
     (setq _plan_parsed (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass rosplan_dispatch_msgs::ParsingService
  :super ros::object
  :slots ())

(setf (get rosplan_dispatch_msgs::ParsingService :md5sum-) "30a7fd003c9a74d70dc3c96bf0a9476f")
(setf (get rosplan_dispatch_msgs::ParsingService :datatype-) "rosplan_dispatch_msgs/ParsingService")
(setf (get rosplan_dispatch_msgs::ParsingService :request) rosplan_dispatch_msgs::ParsingServiceRequest)
(setf (get rosplan_dispatch_msgs::ParsingService :response) rosplan_dispatch_msgs::ParsingServiceResponse)

(defmethod rosplan_dispatch_msgs::ParsingServiceRequest
  (:response () (instance rosplan_dispatch_msgs::ParsingServiceResponse :init)))

(setf (get rosplan_dispatch_msgs::ParsingServiceRequest :md5sum-) "30a7fd003c9a74d70dc3c96bf0a9476f")
(setf (get rosplan_dispatch_msgs::ParsingServiceRequest :datatype-) "rosplan_dispatch_msgs/ParsingServiceRequest")
(setf (get rosplan_dispatch_msgs::ParsingServiceRequest :definition-)
      "# parses a plan from a file
string plan_path
---
bool plan_parsed

")

(setf (get rosplan_dispatch_msgs::ParsingServiceResponse :md5sum-) "30a7fd003c9a74d70dc3c96bf0a9476f")
(setf (get rosplan_dispatch_msgs::ParsingServiceResponse :datatype-) "rosplan_dispatch_msgs/ParsingServiceResponse")
(setf (get rosplan_dispatch_msgs::ParsingServiceResponse :definition-)
      "# parses a plan from a file
string plan_path
---
bool plan_parsed

")



(provide :rosplan_dispatch_msgs/ParsingService "30a7fd003c9a74d70dc3c96bf0a9476f")


