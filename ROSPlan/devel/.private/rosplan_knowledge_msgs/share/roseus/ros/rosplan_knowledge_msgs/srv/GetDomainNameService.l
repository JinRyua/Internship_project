;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::GetDomainNameService)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'GetDomainNameService (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINNAMESERVICE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINNAMESERVICE"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINNAMESERVICEREQUEST")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINNAMESERVICEREQUEST"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINNAMESERVICERESPONSE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINNAMESERVICERESPONSE"))

(in-package "ROS")





(defclass rosplan_knowledge_msgs::GetDomainNameServiceRequest
  :super ros::object
  :slots ())

(defmethod rosplan_knowledge_msgs::GetDomainNameServiceRequest
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::GetDomainNameServiceResponse
  :super ros::object
  :slots (_domain_name ))

(defmethod rosplan_knowledge_msgs::GetDomainNameServiceResponse
  (:init
   (&key
    ((:domain_name __domain_name) "")
    )
   (send-super :init)
   (setq _domain_name (string __domain_name))
   self)
  (:domain_name
   (&optional __domain_name)
   (if __domain_name (setq _domain_name __domain_name)) _domain_name)
  (:serialization-length
   ()
   (+
    ;; string _domain_name
    4 (length _domain_name)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _domain_name
       (write-long (length _domain_name) s) (princ _domain_name s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _domain_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _domain_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::GetDomainNameService
  :super ros::object
  :slots ())

(setf (get rosplan_knowledge_msgs::GetDomainNameService :md5sum-) "60174b39a7780212f0384c8d050df5a0")
(setf (get rosplan_knowledge_msgs::GetDomainNameService :datatype-) "rosplan_knowledge_msgs/GetDomainNameService")
(setf (get rosplan_knowledge_msgs::GetDomainNameService :request) rosplan_knowledge_msgs::GetDomainNameServiceRequest)
(setf (get rosplan_knowledge_msgs::GetDomainNameService :response) rosplan_knowledge_msgs::GetDomainNameServiceResponse)

(defmethod rosplan_knowledge_msgs::GetDomainNameServiceRequest
  (:response () (instance rosplan_knowledge_msgs::GetDomainNameServiceResponse :init)))

(setf (get rosplan_knowledge_msgs::GetDomainNameServiceRequest :md5sum-) "60174b39a7780212f0384c8d050df5a0")
(setf (get rosplan_knowledge_msgs::GetDomainNameServiceRequest :datatype-) "rosplan_knowledge_msgs/GetDomainNameServiceRequest")
(setf (get rosplan_knowledge_msgs::GetDomainNameServiceRequest :definition-)
      "# Fetching the Domain (0/3):
# Get the domain name.

---
string domain_name

")

(setf (get rosplan_knowledge_msgs::GetDomainNameServiceResponse :md5sum-) "60174b39a7780212f0384c8d050df5a0")
(setf (get rosplan_knowledge_msgs::GetDomainNameServiceResponse :datatype-) "rosplan_knowledge_msgs/GetDomainNameServiceResponse")
(setf (get rosplan_knowledge_msgs::GetDomainNameServiceResponse :definition-)
      "# Fetching the Domain (0/3):
# Get the domain name.

---
string domain_name

")



(provide :rosplan_knowledge_msgs/GetDomainNameService "60174b39a7780212f0384c8d050df5a0")


