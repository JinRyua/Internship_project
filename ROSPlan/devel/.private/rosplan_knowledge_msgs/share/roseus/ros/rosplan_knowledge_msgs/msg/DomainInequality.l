;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::DomainInequality)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'DomainInequality (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAININEQUALITY")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAININEQUALITY"))

(in-package "ROS")
;;//! \htmlinclude DomainInequality.msg.html


(intern "*GREATER*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAININEQUALITY"))
(shadow '*GREATER* (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAININEQUALITY"))
(defconstant rosplan_knowledge_msgs::DomainInequality::*GREATER* 0)
(intern "*GREATEREQ*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAININEQUALITY"))
(shadow '*GREATEREQ* (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAININEQUALITY"))
(defconstant rosplan_knowledge_msgs::DomainInequality::*GREATEREQ* 1)
(intern "*LESS*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAININEQUALITY"))
(shadow '*LESS* (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAININEQUALITY"))
(defconstant rosplan_knowledge_msgs::DomainInequality::*LESS* 2)
(intern "*LESSEQ*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAININEQUALITY"))
(shadow '*LESSEQ* (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAININEQUALITY"))
(defconstant rosplan_knowledge_msgs::DomainInequality::*LESSEQ* 3)
(intern "*EQUALS*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAININEQUALITY"))
(shadow '*EQUALS* (find-package "ROSPLAN_KNOWLEDGE_MSGS::DOMAININEQUALITY"))
(defconstant rosplan_knowledge_msgs::DomainInequality::*EQUALS* 4)
(defclass rosplan_knowledge_msgs::DomainInequality
  :super ros::object
  :slots (_comparison_type _LHS _RHS _grounded ))

(defmethod rosplan_knowledge_msgs::DomainInequality
  (:init
   (&key
    ((:comparison_type __comparison_type) 0)
    ((:LHS __LHS) (instance rosplan_knowledge_msgs::ExprComposite :init))
    ((:RHS __RHS) (instance rosplan_knowledge_msgs::ExprComposite :init))
    ((:grounded __grounded) nil)
    )
   (send-super :init)
   (setq _comparison_type (round __comparison_type))
   (setq _LHS __LHS)
   (setq _RHS __RHS)
   (setq _grounded __grounded)
   self)
  (:comparison_type
   (&optional __comparison_type)
   (if __comparison_type (setq _comparison_type __comparison_type)) _comparison_type)
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
    ;; uint8 _comparison_type
    1
    ;; rosplan_knowledge_msgs/ExprComposite _LHS
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
     ;; uint8 _comparison_type
       (write-byte _comparison_type s)
     ;; rosplan_knowledge_msgs/ExprComposite _LHS
       (send _LHS :serialize s)
     ;; rosplan_knowledge_msgs/ExprComposite _RHS
       (send _RHS :serialize s)
     ;; bool _grounded
       (if _grounded (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _comparison_type
     (setq _comparison_type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; rosplan_knowledge_msgs/ExprComposite _LHS
     (send _LHS :deserialize buf ptr-) (incf ptr- (send _LHS :serialization-length))
   ;; rosplan_knowledge_msgs/ExprComposite _RHS
     (send _RHS :deserialize buf ptr-) (incf ptr- (send _RHS :serialization-length))
   ;; bool _grounded
     (setq _grounded (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get rosplan_knowledge_msgs::DomainInequality :md5sum-) "f37701458d82c14a53dcc25df39cacaa")
(setf (get rosplan_knowledge_msgs::DomainInequality :datatype-) "rosplan_knowledge_msgs/DomainInequality")
(setf (get rosplan_knowledge_msgs::DomainInequality :definition-)
      "# A message used to store the numeric effects of an action
# Can be grounded or ungrounded

uint8 GREATER   = 0
uint8 GREATEREQ = 1
uint8 LESS      = 2
uint8 LESSEQ    = 3
uint8 EQUALS    = 4

uint8 comparison_type

rosplan_knowledge_msgs/ExprComposite LHS
rosplan_knowledge_msgs/ExprComposite RHS

bool grounded

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



(provide :rosplan_knowledge_msgs/DomainInequality "f37701458d82c14a53dcc25df39cacaa")


