;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::DomainFormula)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'DomainFormula (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAINFORMULA")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAINFORMULA"))

(in-package "ROS")
;;//! \htmlinclude DomainFormula.msg.html
(if (not (find-package "DIAGNOSTIC_MSGS"))
  (ros::roseus-add-msgs "diagnostic_msgs"))


(defclass rosplan_knowledge_msgs::DomainFormula
  :super ros::object
  :slots (_name _typed_parameters ))

(defmethod rosplan_knowledge_msgs::DomainFormula
  (:init
   (&key
    ((:name __name) "")
    ((:typed_parameters __typed_parameters) (let (r) (dotimes (i 0) (push (instance diagnostic_msgs::KeyValue :init) r)) r))
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _typed_parameters __typed_parameters)
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:typed_parameters
   (&rest __typed_parameters)
   (if (keywordp (car __typed_parameters))
       (send* _typed_parameters __typed_parameters)
     (progn
       (if __typed_parameters (setq _typed_parameters (car __typed_parameters)))
       _typed_parameters)))
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; diagnostic_msgs/KeyValue[] _typed_parameters
    (apply #'+ (send-all _typed_parameters :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; diagnostic_msgs/KeyValue[] _typed_parameters
     (write-long (length _typed_parameters) s)
     (dolist (elem _typed_parameters)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; diagnostic_msgs/KeyValue[] _typed_parameters
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _typed_parameters (let (r) (dotimes (i n) (push (instance diagnostic_msgs::KeyValue :init) r)) r))
     (dolist (elem- _typed_parameters)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get rosplan_knowledge_msgs::DomainFormula :md5sum-) "b9c7cfc3aa64764d3a82f96d3671bab1")
(setf (get rosplan_knowledge_msgs::DomainFormula :datatype-) "rosplan_knowledge_msgs/DomainFormula")
(setf (get rosplan_knowledge_msgs::DomainFormula :definition-)
      "# A message used to represent an atomic formula from the domain.
# typed_parameters matches label -> type
string name
diagnostic_msgs/KeyValue[] typed_parameters

================================================================================
MSG: diagnostic_msgs/KeyValue
string key # what to label this value when viewing
string value # a value to track over time

")



(provide :rosplan_knowledge_msgs/DomainFormula "b9c7cfc3aa64764d3a82f96d3671bab1")


