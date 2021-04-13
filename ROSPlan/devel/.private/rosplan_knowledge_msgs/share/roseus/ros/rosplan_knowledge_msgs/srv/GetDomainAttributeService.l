;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::GetDomainAttributeService)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'GetDomainAttributeService (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINATTRIBUTESERVICE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINATTRIBUTESERVICE"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINATTRIBUTESERVICEREQUEST")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINATTRIBUTESERVICEREQUEST"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINATTRIBUTESERVICERESPONSE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINATTRIBUTESERVICERESPONSE"))

(in-package "ROS")





(defclass rosplan_knowledge_msgs::GetDomainAttributeServiceRequest
  :super ros::object
  :slots ())

(defmethod rosplan_knowledge_msgs::GetDomainAttributeServiceRequest
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

(defclass rosplan_knowledge_msgs::GetDomainAttributeServiceResponse
  :super ros::object
  :slots (_items ))

(defmethod rosplan_knowledge_msgs::GetDomainAttributeServiceResponse
  (:init
   (&key
    ((:items __items) (let (r) (dotimes (i 0) (push (instance rosplan_knowledge_msgs::DomainFormula :init) r)) r))
    )
   (send-super :init)
   (setq _items __items)
   self)
  (:items
   (&rest __items)
   (if (keywordp (car __items))
       (send* _items __items)
     (progn
       (if __items (setq _items (car __items)))
       _items)))
  (:serialization-length
   ()
   (+
    ;; rosplan_knowledge_msgs/DomainFormula[] _items
    (apply #'+ (send-all _items :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; rosplan_knowledge_msgs/DomainFormula[] _items
     (write-long (length _items) s)
     (dolist (elem _items)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; rosplan_knowledge_msgs/DomainFormula[] _items
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _items (let (r) (dotimes (i n) (push (instance rosplan_knowledge_msgs::DomainFormula :init) r)) r))
     (dolist (elem- _items)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::GetDomainAttributeService
  :super ros::object
  :slots ())

(setf (get rosplan_knowledge_msgs::GetDomainAttributeService :md5sum-) "900aa034059a0ceeaa146f6ab4b7e066")
(setf (get rosplan_knowledge_msgs::GetDomainAttributeService :datatype-) "rosplan_knowledge_msgs/GetDomainAttributeService")
(setf (get rosplan_knowledge_msgs::GetDomainAttributeService :request) rosplan_knowledge_msgs::GetDomainAttributeServiceRequest)
(setf (get rosplan_knowledge_msgs::GetDomainAttributeService :response) rosplan_knowledge_msgs::GetDomainAttributeServiceResponse)

(defmethod rosplan_knowledge_msgs::GetDomainAttributeServiceRequest
  (:response () (instance rosplan_knowledge_msgs::GetDomainAttributeServiceResponse :init)))

(setf (get rosplan_knowledge_msgs::GetDomainAttributeServiceRequest :md5sum-) "900aa034059a0ceeaa146f6ab4b7e066")
(setf (get rosplan_knowledge_msgs::GetDomainAttributeServiceRequest :datatype-) "rosplan_knowledge_msgs/GetDomainAttributeServiceRequest")
(setf (get rosplan_knowledge_msgs::GetDomainAttributeServiceRequest :definition-)
      "# Fetching the Domain (3/3):
# Get all predicates or functions in the domain.

---
rosplan_knowledge_msgs/DomainFormula[] items


================================================================================
MSG: rosplan_knowledge_msgs/DomainFormula
# A message used to represent an atomic formula from the domain.
# typed_parameters matches label -> type
string name
diagnostic_msgs/KeyValue[] typed_parameters

================================================================================
MSG: diagnostic_msgs/KeyValue
string key # what to label this value when viewing
string value # a value to track over time
")

(setf (get rosplan_knowledge_msgs::GetDomainAttributeServiceResponse :md5sum-) "900aa034059a0ceeaa146f6ab4b7e066")
(setf (get rosplan_knowledge_msgs::GetDomainAttributeServiceResponse :datatype-) "rosplan_knowledge_msgs/GetDomainAttributeServiceResponse")
(setf (get rosplan_knowledge_msgs::GetDomainAttributeServiceResponse :definition-)
      "# Fetching the Domain (3/3):
# Get all predicates or functions in the domain.

---
rosplan_knowledge_msgs/DomainFormula[] items


================================================================================
MSG: rosplan_knowledge_msgs/DomainFormula
# A message used to represent an atomic formula from the domain.
# typed_parameters matches label -> type
string name
diagnostic_msgs/KeyValue[] typed_parameters

================================================================================
MSG: diagnostic_msgs/KeyValue
string key # what to label this value when viewing
string value # a value to track over time
")



(provide :rosplan_knowledge_msgs/GetDomainAttributeService "900aa034059a0ceeaa146f6ab4b7e066")


