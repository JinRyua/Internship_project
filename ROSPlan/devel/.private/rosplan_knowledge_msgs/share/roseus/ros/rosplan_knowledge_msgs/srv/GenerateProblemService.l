;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::GenerateProblemService)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'GenerateProblemService (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GENERATEPROBLEMSERVICE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GENERATEPROBLEMSERVICE"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GENERATEPROBLEMSERVICEREQUEST")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GENERATEPROBLEMSERVICEREQUEST"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GENERATEPROBLEMSERVICERESPONSE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GENERATEPROBLEMSERVICERESPONSE"))

(in-package "ROS")





(defclass rosplan_knowledge_msgs::GenerateProblemServiceRequest
  :super ros::object
  :slots (_problem_path _contingent ))

(defmethod rosplan_knowledge_msgs::GenerateProblemServiceRequest
  (:init
   (&key
    ((:problem_path __problem_path) "")
    ((:contingent __contingent) nil)
    )
   (send-super :init)
   (setq _problem_path (string __problem_path))
   (setq _contingent __contingent)
   self)
  (:problem_path
   (&optional __problem_path)
   (if __problem_path (setq _problem_path __problem_path)) _problem_path)
  (:contingent
   (&optional __contingent)
   (if __contingent (setq _contingent __contingent)) _contingent)
  (:serialization-length
   ()
   (+
    ;; string _problem_path
    4 (length _problem_path)
    ;; bool _contingent
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _problem_path
       (write-long (length _problem_path) s) (princ _problem_path s)
     ;; bool _contingent
       (if _contingent (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _problem_path
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _problem_path (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _contingent
     (setq _contingent (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::GenerateProblemServiceResponse
  :super ros::object
  :slots (_message ))

(defmethod rosplan_knowledge_msgs::GenerateProblemServiceResponse
  (:init
   (&key
    ((:message __message) "")
    )
   (send-super :init)
   (setq _message (string __message))
   self)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:serialization-length
   ()
   (+
    ;; string _message
    4 (length _message)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::GenerateProblemService
  :super ros::object
  :slots ())

(setf (get rosplan_knowledge_msgs::GenerateProblemService :md5sum-) "691992df67730037ceca53e2831f2e82")
(setf (get rosplan_knowledge_msgs::GenerateProblemService :datatype-) "rosplan_knowledge_msgs/GenerateProblemService")
(setf (get rosplan_knowledge_msgs::GenerateProblemService :request) rosplan_knowledge_msgs::GenerateProblemServiceRequest)
(setf (get rosplan_knowledge_msgs::GenerateProblemService :response) rosplan_knowledge_msgs::GenerateProblemServiceResponse)

(defmethod rosplan_knowledge_msgs::GenerateProblemServiceRequest
  (:response () (instance rosplan_knowledge_msgs::GenerateProblemServiceResponse :init)))

(setf (get rosplan_knowledge_msgs::GenerateProblemServiceRequest :md5sum-) "691992df67730037ceca53e2831f2e82")
(setf (get rosplan_knowledge_msgs::GenerateProblemServiceRequest :datatype-) "rosplan_knowledge_msgs/GenerateProblemServiceRequest")
(setf (get rosplan_knowledge_msgs::GenerateProblemServiceRequest :definition-)
      "# simple service for generating a PDDL problem with goals from the KMS
string problem_path
bool contingent
---
string message

")

(setf (get rosplan_knowledge_msgs::GenerateProblemServiceResponse :md5sum-) "691992df67730037ceca53e2831f2e82")
(setf (get rosplan_knowledge_msgs::GenerateProblemServiceResponse :datatype-) "rosplan_knowledge_msgs/GenerateProblemServiceResponse")
(setf (get rosplan_knowledge_msgs::GenerateProblemServiceResponse :definition-)
      "# simple service for generating a PDDL problem with goals from the KMS
string problem_path
bool contingent
---
string message

")



(provide :rosplan_knowledge_msgs/GenerateProblemService "691992df67730037ceca53e2831f2e82")


