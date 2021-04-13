;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::GetDomainTypeService)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'GetDomainTypeService (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINTYPESERVICE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINTYPESERVICE"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINTYPESERVICEREQUEST")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINTYPESERVICEREQUEST"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINTYPESERVICERESPONSE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINTYPESERVICERESPONSE"))

(in-package "ROS")





(defclass rosplan_knowledge_msgs::GetDomainTypeServiceRequest
  :super ros::object
  :slots ())

(defmethod rosplan_knowledge_msgs::GetDomainTypeServiceRequest
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

(defclass rosplan_knowledge_msgs::GetDomainTypeServiceResponse
  :super ros::object
  :slots (_types _super_types ))

(defmethod rosplan_knowledge_msgs::GetDomainTypeServiceResponse
  (:init
   (&key
    ((:types __types) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:super_types __super_types) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _types __types)
   (setq _super_types __super_types)
   self)
  (:types
   (&optional __types)
   (if __types (setq _types __types)) _types)
  (:super_types
   (&optional __super_types)
   (if __super_types (setq _super_types __super_types)) _super_types)
  (:serialization-length
   ()
   (+
    ;; string[] _types
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _types)) 4
    ;; string[] _super_types
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _super_types)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string[] _types
     (write-long (length _types) s)
     (dolist (elem _types)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _super_types
     (write-long (length _super_types) s)
     (dolist (elem _super_types)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string[] _types
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _types (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _types i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _super_types
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _super_types (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _super_types i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::GetDomainTypeService
  :super ros::object
  :slots ())

(setf (get rosplan_knowledge_msgs::GetDomainTypeService :md5sum-) "8cb6e21c43cdf2ec143646b3aeb9fd3d")
(setf (get rosplan_knowledge_msgs::GetDomainTypeService :datatype-) "rosplan_knowledge_msgs/GetDomainTypeService")
(setf (get rosplan_knowledge_msgs::GetDomainTypeService :request) rosplan_knowledge_msgs::GetDomainTypeServiceRequest)
(setf (get rosplan_knowledge_msgs::GetDomainTypeService :response) rosplan_knowledge_msgs::GetDomainTypeServiceResponse)

(defmethod rosplan_knowledge_msgs::GetDomainTypeServiceRequest
  (:response () (instance rosplan_knowledge_msgs::GetDomainTypeServiceResponse :init)))

(setf (get rosplan_knowledge_msgs::GetDomainTypeServiceRequest :md5sum-) "8cb6e21c43cdf2ec143646b3aeb9fd3d")
(setf (get rosplan_knowledge_msgs::GetDomainTypeServiceRequest :datatype-) "rosplan_knowledge_msgs/GetDomainTypeServiceRequest")
(setf (get rosplan_knowledge_msgs::GetDomainTypeServiceRequest :definition-)
      "# Fetching the Domain (1/3):
# Get all types in the domain.

---
string[] types
string[] super_types

")

(setf (get rosplan_knowledge_msgs::GetDomainTypeServiceResponse :md5sum-) "8cb6e21c43cdf2ec143646b3aeb9fd3d")
(setf (get rosplan_knowledge_msgs::GetDomainTypeServiceResponse :datatype-) "rosplan_knowledge_msgs/GetDomainTypeServiceResponse")
(setf (get rosplan_knowledge_msgs::GetDomainTypeServiceResponse :definition-)
      "# Fetching the Domain (1/3):
# Get all types in the domain.

---
string[] types
string[] super_types

")



(provide :rosplan_knowledge_msgs/GetDomainTypeService "8cb6e21c43cdf2ec143646b3aeb9fd3d")


