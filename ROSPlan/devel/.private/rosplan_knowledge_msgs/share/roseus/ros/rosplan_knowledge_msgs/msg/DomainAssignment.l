;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::DomainAssignment)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'DomainAssignment (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAINASSIGNMENT")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAINASSIGNMENT"))

(in-package "ROS")
;;//! \htmlinclude DomainAssignment.msg.html


(intern "*ASSIGN*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAINASSIGNMENT"))
(shadow '*ASSIGN* (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAINASSIGNMENT"))
(defconstant rosplan_knowledge_msgs::DomainAssignment::*ASSIGN* 0)
(intern "*INCREASE*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAINASSIGNMENT"))
(shadow '*INCREASE* (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAINASSIGNMENT"))
(defconstant rosplan_knowledge_msgs::DomainAssignment::*INCREASE* 1)
(intern "*DECREASE*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAINASSIGNMENT"))
(shadow '*DECREASE* (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAINASSIGNMENT"))
(defconstant rosplan_knowledge_msgs::DomainAssignment::*DECREASE* 2)
(intern "*SCALE_UP*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAINASSIGNMENT"))
(shadow '*SCALE_UP* (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAINASSIGNMENT"))
(defconstant rosplan_knowledge_msgs::DomainAssignment::*SCALE_UP* 3)
(intern "*SCALE_DOWN*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAINASSIGNMENT"))
(shadow '*SCALE_DOWN* (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAINASSIGNMENT"))
(defconstant rosplan_knowledge_msgs::DomainAssignment::*SCALE_DOWN* 4)
(intern "*ASSIGN_CTS*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAINASSIGNMENT"))
(shadow '*ASSIGN_CTS* (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAINASSIGNMENT"))
(defconstant rosplan_knowledge_msgs::DomainAssignment::*ASSIGN_CTS* 5)
(defclass rosplan_knowledge_msgs::DomainAssignment
  :super ros::object
  :slots (_assign_type _LHS _RHS _grounded ))

(defmethod rosplan_knowledge_msgs::DomainAssignment
  (:init
   (&key
    ((:assign_type __assign_type) 0)
    ((:LHS __LHS) (instance rosplan_knowledge_msgs::DomainFormula :init))
    ((:RHS __RHS) (instance rosplan_knowledge_msgs::ExprComposite :init))
    ((:grounded __grounded) nil)
    )
   (send-super :init)
   (setq _assign_type (round __assign_type))
   (setq _LHS __LHS)
   (setq _RHS __RHS)
   (setq _grounded __grounded)
   self)
  (:assign_type
   (&optional __assign_type)
   (if __assign_type (setq _assign_type __assign_type)) _assign_type)
  (:LHS
   (&rest __LHS)
   (if (keywordp (car __LHS))
       (send* _LHS __LHS)
     (progn
       (if __LHS (setq _LHS (car __LHS)))
       _LHS)))
  (:RHS
   (&rest __RHS)
   (if (keywordp (car __RHS))
       (send* _RHS __RHS)
     (progn
       (if __RHS (setq _RHS (car __RHS)))
       _RHS)))
  (:grounded
   (&optional __grounded)
   (if __grounded (setq _grounded __grounded)) _grounded)
  (:serialization-length
   ()
   (+
    ;; uint8 _assign_type
    1
    ;; rosplan_knowledge_msgs/DomainFormula _LHS
    (send _LHS :serialization-length)
    ;; rosplan_knowledge_msgs/ExprComposite _RHS
    (send _RHS :serialization-length)
    ;; bool _grounded
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _assign_type
       (write-byte _assign_type s)
     ;; rosplan_knowledge_msgs/DomainFormula _LHS
       (send _LHS :serialize s)
     ;; rosplan_knowledge_msgs/ExprComposite _RHS
       (send _RHS :serialize s)
     ;; bool _grounded
       (if _grounded (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _assign_type
     (setq _assign_type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; rosplan_knowledge_msgs/DomainFormula _LHS
     (send _LHS :deserialize buf ptr-) (incf ptr- (send _LHS :serialization-length))
   ;; rosplan_knowledge_msgs/ExprComposite _RHS
     (send _RHS :deserialize buf ptr-) (incf ptr- (send _RHS :serialization-length))
   ;; bool _grounded
     (setq _grounded (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get rosplan_knowledge_msgs::DomainAssignment :md5sum-) "608e2cda022aeb305ce8f279edb74325")
(setf (get rosplan_knowledge_msgs::DomainAssignment :datatype-) "rosplan_knowledge_msgs/DomainAssignment")
(setf (get rosplan_knowledge_msgs::DomainAssignment :definition-)
      "# A message used to store the numeric effects of an action
# Can be grounded or ungrounded

uint8 ASSIGN   = 0
uint8 INCREASE  = 1
uint8 DECREASE = 2
uint8 SCALE_UP = 3
uint8 SCALE_DOWN = 4
uint8 ASSIGN_CTS = 5

uint8 assign_type

rosplan_knowledge_msgs/DomainFormula LHS
rosplan_knowledge_msgs/ExprComposite RHS

bool grounded

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

================================================================================
MSG: rosplan_knowledge_msgs/ExprComposite
# A message used to represent a numerical expression; composite type (2/2)
# stores an array of ExprBase as prefix notation

# components
ExprBase[] tokens

================================================================================
MSG: rosplan_knowledge_msgs/ExprBase
# A message used to represent a numerical expression; base types (1/2)

# expression types
uint8 CONSTANT = 0
uint8 FUNCTION = 1
uint8 OPERATOR = 2
uint8 SPECIAL  = 3

# operators
uint8 ADD    = 0
uint8 SUB    = 1
uint8 MUL    = 2
uint8 DIV    = 3
uint8 UMINUS = 4

# special types
uint8 HASHT      = 0
uint8 TOTAL_TIME = 1
uint8 DURATION   = 2

# expression base type
uint8 expr_type

# constant value
float64 constant

# function
rosplan_knowledge_msgs/DomainFormula function

# operator
uint8 op

# special
uint8 special_type

")



(provide :rosplan_knowledge_msgs/DomainAssignment "608e2cda022aeb305ce8f279edb74325")


