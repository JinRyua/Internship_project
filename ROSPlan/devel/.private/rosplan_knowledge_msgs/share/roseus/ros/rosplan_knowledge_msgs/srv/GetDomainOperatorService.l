;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::GetDomainOperatorService)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'GetDomainOperatorService (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINOPERATORSERVICE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINOPERATORSERVICE"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINOPERATORSERVICEREQUEST")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINOPERATORSERVICEREQUEST"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINOPERATORSERVICERESPONSE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINOPERATORSERVICERESPONSE"))

(in-package "ROS")





(defclass rosplan_knowledge_msgs::GetDomainOperatorServiceRequest
  :super ros::object
  :slots ())

(defmethod rosplan_knowledge_msgs::GetDomainOperatorServiceRequest
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

(defclass rosplan_knowledge_msgs::GetDomainOperatorServiceResponse
  :super ros::object
  :slots (_operators ))

(defmethod rosplan_knowledge_msgs::GetDomainOperatorServiceResponse
  (:init
   (&key
    ((:operators __operators) (let (r) (dotimes (i 0) (push (instance rosplan_knowledge_msgs::DomainFormula :init) r)) r))
    )
   (send-super :init)
   (setq _operators __operators)
   self)
  (:operators
   (&rest __operators)
   (if (keywordp (car __operators))
       (send* _operators __operators)
     (progn
       (if __operators (setq _operators (car __operators)))
       _operators)))
  (:serialization-length
   ()
   (+
    ;; rosplan_knowledge_msgs/DomainFormula[] _operators
    (apply #'+ (send-all _operators :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; rosplan_knowledge_msgs/DomainFormula[] _operators
     (write-long (length _operators) s)
     (dolist (elem _operators)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; rosplan_knowledge_msgs/DomainFormula[] _operators
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _operators (let (r) (dotimes (i n) (push (instance rosplan_knowledge_msgs::DomainFormula :init) r)) r))
     (dolist (elem- _operators)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::GetDomainOperatorService
  :super ros::object
  :slots ())

(setf (get rosplan_knowledge_msgs::GetDomainOperatorService :md5sum-) "01315931b687093b9f4ca53107f02d57")
(setf (get rosplan_knowledge_msgs::GetDomainOperatorService :datatype-) "rosplan_knowledge_msgs/GetDomainOperatorService")
(setf (get rosplan_knowledge_msgs::GetDomainOperatorService :request) rosplan_knowledge_msgs::GetDomainOperatorServiceRequest)
(setf (get rosplan_knowledge_msgs::GetDomainOperatorService :response) rosplan_knowledge_msgs::GetDomainOperatorServiceResponse)

(defmethod rosplan_knowledge_msgs::GetDomainOperatorServiceRequest
  (:response () (instance rosplan_knowledge_msgs::GetDomainOperatorServiceResponse :init)))

(setf (get rosplan_knowledge_msgs::GetDomainOperatorServiceRequest :md5sum-) "01315931b687093b9f4ca53107f02d57")
(setf (get rosplan_knowledge_msgs::GetDomainOperatorServiceRequest :datatype-) "rosplan_knowledge_msgs/GetDomainOperatorServiceRequest")
(setf (get rosplan_knowledge_msgs::GetDomainOperatorServiceRequest :definition-)
      "# Fetching the Domain (2/3):
# Get all operators in the domain.

---
rosplan_knowledge_msgs/DomainFormula[] operators


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

(setf (get rosplan_knowledge_msgs::GetDomainOperatorServiceResponse :md5sum-) "01315931b687093b9f4ca53107f02d57")
(setf (get rosplan_knowledge_msgs::GetDomainOperatorServiceResponse :datatype-) "rosplan_knowledge_msgs/GetDomainOperatorServiceResponse")
(setf (get rosplan_knowledge_msgs::GetDomainOperatorServiceResponse :definition-)
      "# Fetching the Domain (2/3):
# Get all operators in the domain.

---
rosplan_knowledge_msgs/DomainFormula[] operators


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



(provide :rosplan_knowledge_msgs/GetDomainOperatorService "01315931b687093b9f4ca53107f02d57")


