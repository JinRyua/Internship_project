;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::KnowledgeUpdateServiceArray)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'KnowledgeUpdateServiceArray (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAY")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAY"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAYREQUEST")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAYREQUEST"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAYRESPONSE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAYRESPONSE"))

(in-package "ROS")





(intern "*ADD_KNOWLEDGE*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAYREQUEST"))
(shadow '*ADD_KNOWLEDGE* (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAYREQUEST"))
(defconstant rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayRequest::*ADD_KNOWLEDGE* 0)
(intern "*ADD_GOAL*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAYREQUEST"))
(shadow '*ADD_GOAL* (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAYREQUEST"))
(defconstant rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayRequest::*ADD_GOAL* 1)
(intern "*REMOVE_KNOWLEDGE*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAYREQUEST"))
(shadow '*REMOVE_KNOWLEDGE* (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAYREQUEST"))
(defconstant rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayRequest::*REMOVE_KNOWLEDGE* 2)
(intern "*REMOVE_GOAL*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAYREQUEST"))
(shadow '*REMOVE_GOAL* (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAYREQUEST"))
(defconstant rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayRequest::*REMOVE_GOAL* 3)
(intern "*ADD_METRIC*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAYREQUEST"))
(shadow '*ADD_METRIC* (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAYREQUEST"))
(defconstant rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayRequest::*ADD_METRIC* 4)
(intern "*REMOVE_METRIC*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAYREQUEST"))
(shadow '*REMOVE_METRIC* (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEUPDATESERVICEARRAYREQUEST"))
(defconstant rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayRequest::*REMOVE_METRIC* 5)
(defclass rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayRequest
  :super ros::object
  :slots (_update_type _knowledge ))

(defmethod rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayRequest
  (:init
   (&key
    ((:update_type __update_type) (make-array 0 :initial-element 0 :element-type :char))
    ((:knowledge __knowledge) (let (r) (dotimes (i 0) (push (instance rosplan_knowledge_msgs::KnowledgeItem :init) r)) r))
    )
   (send-super :init)
   (setq _update_type __update_type)
   (setq _knowledge __knowledge)
   self)
  (:update_type
   (&optional __update_type)
   (if __update_type (setq _update_type __update_type)) _update_type)
  (:knowledge
   (&rest __knowledge)
   (if (keywordp (car __knowledge))
       (send* _knowledge __knowledge)
     (progn
       (if __knowledge (setq _knowledge (car __knowledge)))
       _knowledge)))
  (:serialization-length
   ()
   (+
    ;; uint8[] _update_type
    (* 1    (length _update_type)) 4
    ;; rosplan_knowledge_msgs/KnowledgeItem[] _knowledge
    (apply #'+ (send-all _knowledge :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8[] _update_type
     (write-long (length _update_type) s)
     (princ _update_type s)
     ;; rosplan_knowledge_msgs/KnowledgeItem[] _knowledge
     (write-long (length _knowledge) s)
     (dolist (elem _knowledge)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8[] _update_type
   (let ((n (sys::peek buf ptr- :integer))) (incf ptr- 4)
     (setq _update_type (make-array n :element-type :char))
     (replace _update_type buf :start2 ptr-) (incf ptr- n))
   ;; rosplan_knowledge_msgs/KnowledgeItem[] _knowledge
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _knowledge (let (r) (dotimes (i n) (push (instance rosplan_knowledge_msgs::KnowledgeItem :init) r)) r))
     (dolist (elem- _knowledge)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayResponse
  :super ros::object
  :slots (_success ))

(defmethod rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayResponse
  (:init
   (&key
    ((:success __success) nil)
    )
   (send-super :init)
   (setq _success __success)
   self)
  (:success
   (&optional __success)
   (if __success (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::KnowledgeUpdateServiceArray
  :super ros::object
  :slots ())

(setf (get rosplan_knowledge_msgs::KnowledgeUpdateServiceArray :md5sum-) "fe6a67316474d3583f51a383d1cdfadc")
(setf (get rosplan_knowledge_msgs::KnowledgeUpdateServiceArray :datatype-) "rosplan_knowledge_msgs/KnowledgeUpdateServiceArray")
(setf (get rosplan_knowledge_msgs::KnowledgeUpdateServiceArray :request) rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayRequest)
(setf (get rosplan_knowledge_msgs::KnowledgeUpdateServiceArray :response) rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayResponse)

(defmethod rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayRequest
  (:response () (instance rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayResponse :init)))

(setf (get rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayRequest :md5sum-) "fe6a67316474d3583f51a383d1cdfadc")
(setf (get rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayRequest :datatype-) "rosplan_knowledge_msgs/KnowledgeUpdateServiceArrayRequest")
(setf (get rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayRequest :definition-)
      "# Knowledge building; extra service:
# Add or remove knowledge from the current state using an array to save time.

uint8 ADD_KNOWLEDGE = 0
uint8 ADD_GOAL = 1
uint8 REMOVE_KNOWLEDGE = 2
uint8 REMOVE_GOAL = 3
uint8 ADD_METRIC = 4
uint8 REMOVE_METRIC = 5

uint8[] update_type
rosplan_knowledge_msgs/KnowledgeItem[] knowledge

================================================================================
MSG: rosplan_knowledge_msgs/KnowledgeItem
# A knowledge item used to represent a piece of the state in ROSPlan

uint8 INSTANCE = 0
uint8 FACT = 1
uint8 FUNCTION = 2
uint8 EXPRESSION = 3
uint8 INEQUALITY = 4

uint8 knowledge_type

# time at which this knowledge becomes true
time initial_time

# knowledge is explicitly false
bool is_negative

#---------
# INSTANCE
#---------

# instance knowledge_type
string instance_type
string instance_name

#----------------------
# PREDICATE OR FUNCTION
#----------------------

# attribute knowledge_type
string attribute_name
diagnostic_msgs/KeyValue[] values

#---------
# FUNCTION
#---------

# function value
float64 function_value

#-----------
# EXPRESSION
#-----------

string optimization
rosplan_knowledge_msgs/ExprComposite expr

#-----------
# INEQUALITY
#-----------

rosplan_knowledge_msgs/DomainInequality ineq

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

================================================================================
MSG: rosplan_knowledge_msgs/DomainFormula
# A message used to represent an atomic formula from the domain.
# typed_parameters matches label -> type
string name
diagnostic_msgs/KeyValue[] typed_parameters

================================================================================
MSG: rosplan_knowledge_msgs/DomainInequality
# A message used to store the numeric effects of an action
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
---
bool success

")

(setf (get rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayResponse :md5sum-) "fe6a67316474d3583f51a383d1cdfadc")
(setf (get rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayResponse :datatype-) "rosplan_knowledge_msgs/KnowledgeUpdateServiceArrayResponse")
(setf (get rosplan_knowledge_msgs::KnowledgeUpdateServiceArrayResponse :definition-)
      "# Knowledge building; extra service:
# Add or remove knowledge from the current state using an array to save time.

uint8 ADD_KNOWLEDGE = 0
uint8 ADD_GOAL = 1
uint8 REMOVE_KNOWLEDGE = 2
uint8 REMOVE_GOAL = 3
uint8 ADD_METRIC = 4
uint8 REMOVE_METRIC = 5

uint8[] update_type
rosplan_knowledge_msgs/KnowledgeItem[] knowledge

================================================================================
MSG: rosplan_knowledge_msgs/KnowledgeItem
# A knowledge item used to represent a piece of the state in ROSPlan

uint8 INSTANCE = 0
uint8 FACT = 1
uint8 FUNCTION = 2
uint8 EXPRESSION = 3
uint8 INEQUALITY = 4

uint8 knowledge_type

# time at which this knowledge becomes true
time initial_time

# knowledge is explicitly false
bool is_negative

#---------
# INSTANCE
#---------

# instance knowledge_type
string instance_type
string instance_name

#----------------------
# PREDICATE OR FUNCTION
#----------------------

# attribute knowledge_type
string attribute_name
diagnostic_msgs/KeyValue[] values

#---------
# FUNCTION
#---------

# function value
float64 function_value

#-----------
# EXPRESSION
#-----------

string optimization
rosplan_knowledge_msgs/ExprComposite expr

#-----------
# INEQUALITY
#-----------

rosplan_knowledge_msgs/DomainInequality ineq

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

================================================================================
MSG: rosplan_knowledge_msgs/DomainFormula
# A message used to represent an atomic formula from the domain.
# typed_parameters matches label -> type
string name
diagnostic_msgs/KeyValue[] typed_parameters

================================================================================
MSG: rosplan_knowledge_msgs/DomainInequality
# A message used to store the numeric effects of an action
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
---
bool success

")



(provide :rosplan_knowledge_msgs/KnowledgeUpdateServiceArray "fe6a67316474d3583f51a383d1cdfadc")


