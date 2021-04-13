;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::GetAttributeService)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'GetAttributeService (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETATTRIBUTESERVICE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETATTRIBUTESERVICE"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETATTRIBUTESERVICEREQUEST")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETATTRIBUTESERVICEREQUEST"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETATTRIBUTESERVICERESPONSE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETATTRIBUTESERVICERESPONSE"))

(in-package "ROS")





(defclass rosplan_knowledge_msgs::GetAttributeServiceRequest
  :super ros::object
  :slots (_predicate_name ))

(defmethod rosplan_knowledge_msgs::GetAttributeServiceRequest
  (:init
   (&key
    ((:predicate_name __predicate_name) "")
    )
   (send-super :init)
   (setq _predicate_name (string __predicate_name))
   self)
  (:predicate_name
   (&optional __predicate_name)
   (if __predicate_name (setq _predicate_name __predicate_name)) _predicate_name)
  (:serialization-length
   ()
   (+
    ;; string _predicate_name
    4 (length _predicate_name)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _predicate_name
       (write-long (length _predicate_name) s) (princ _predicate_name s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _predicate_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _predicate_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::GetAttributeServiceResponse
  :super ros::object
  :slots (_attributes ))

(defmethod rosplan_knowledge_msgs::GetAttributeServiceResponse
  (:init
   (&key
    ((:attributes __attributes) (let (r) (dotimes (i 0) (push (instance rosplan_knowledge_msgs::KnowledgeItem :init) r)) r))
    )
   (send-super :init)
   (setq _attributes __attributes)
   self)
  (:attributes
   (&rest __attributes)
   (if (keywordp (car __attributes))
       (send* _attributes __attributes)
     (progn
       (if __attributes (setq _attributes (car __attributes)))
       _attributes)))
  (:serialization-length
   ()
   (+
    ;; rosplan_knowledge_msgs/KnowledgeItem[] _attributes
    (apply #'+ (send-all _attributes :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; rosplan_knowledge_msgs/KnowledgeItem[] _attributes
     (write-long (length _attributes) s)
     (dolist (elem _attributes)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; rosplan_knowledge_msgs/KnowledgeItem[] _attributes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _attributes (let (r) (dotimes (i n) (push (instance rosplan_knowledge_msgs::KnowledgeItem :init) r)) r))
     (dolist (elem- _attributes)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::GetAttributeService
  :super ros::object
  :slots ())

(setf (get rosplan_knowledge_msgs::GetAttributeService :md5sum-) "fe78089058f9089ebe2902711c474ad4")
(setf (get rosplan_knowledge_msgs::GetAttributeService :datatype-) "rosplan_knowledge_msgs/GetAttributeService")
(setf (get rosplan_knowledge_msgs::GetAttributeService :request) rosplan_knowledge_msgs::GetAttributeServiceRequest)
(setf (get rosplan_knowledge_msgs::GetAttributeService :response) rosplan_knowledge_msgs::GetAttributeServiceResponse)

(defmethod rosplan_knowledge_msgs::GetAttributeServiceRequest
  (:response () (instance rosplan_knowledge_msgs::GetAttributeServiceResponse :init)))

(setf (get rosplan_knowledge_msgs::GetAttributeServiceRequest :md5sum-) "fe78089058f9089ebe2902711c474ad4")
(setf (get rosplan_knowledge_msgs::GetAttributeServiceRequest :datatype-) "rosplan_knowledge_msgs/GetAttributeServiceRequest")
(setf (get rosplan_knowledge_msgs::GetAttributeServiceRequest :definition-)
      "# PDDL problem generation; service(2/3):
# Get all facts (or functions) by predicate name (or function name).
# The results are passed as an array of KnowledgeItems
# The array of initial_time is used for TILs and TIFs not yet active
string predicate_name
---
rosplan_knowledge_msgs/KnowledgeItem[] attributes


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
")

(setf (get rosplan_knowledge_msgs::GetAttributeServiceResponse :md5sum-) "fe78089058f9089ebe2902711c474ad4")
(setf (get rosplan_knowledge_msgs::GetAttributeServiceResponse :datatype-) "rosplan_knowledge_msgs/GetAttributeServiceResponse")
(setf (get rosplan_knowledge_msgs::GetAttributeServiceResponse :definition-)
      "# PDDL problem generation; service(2/3):
# Get all facts (or functions) by predicate name (or function name).
# The results are passed as an array of KnowledgeItems
# The array of initial_time is used for TILs and TIFs not yet active
string predicate_name
---
rosplan_knowledge_msgs/KnowledgeItem[] attributes


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
")



(provide :rosplan_knowledge_msgs/GetAttributeService "fe78089058f9089ebe2902711c474ad4")


