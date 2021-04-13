;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::GetMetricService)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'GetMetricService (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETMETRICSERVICE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETMETRICSERVICE"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETMETRICSERVICEREQUEST")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETMETRICSERVICEREQUEST"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETMETRICSERVICERESPONSE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETMETRICSERVICERESPONSE"))

(in-package "ROS")





(defclass rosplan_knowledge_msgs::GetMetricServiceRequest
  :super ros::object
  :slots ())

(defmethod rosplan_knowledge_msgs::GetMetricServiceRequest
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

(defclass rosplan_knowledge_msgs::GetMetricServiceResponse
  :super ros::object
  :slots (_metric ))

(defmethod rosplan_knowledge_msgs::GetMetricServiceResponse
  (:init
   (&key
    ((:metric __metric) (instance rosplan_knowledge_msgs::KnowledgeItem :init))
    )
   (send-super :init)
   (setq _metric __metric)
   self)
  (:metric
   (&rest __metric)
   (if (keywordp (car __metric))
       (send* _metric __metric)
     (progn
       (if __metric (setq _metric (car __metric)))
       _metric)))
  (:serialization-length
   ()
   (+
    ;; rosplan_knowledge_msgs/KnowledgeItem _metric
    (send _metric :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; rosplan_knowledge_msgs/KnowledgeItem _metric
       (send _metric :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; rosplan_knowledge_msgs/KnowledgeItem _metric
     (send _metric :deserialize buf ptr-) (incf ptr- (send _metric :serialization-length))
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::GetMetricService
  :super ros::object
  :slots ())

(setf (get rosplan_knowledge_msgs::GetMetricService :md5sum-) "d8654505c165321f0d5dd974ec4ca392")
(setf (get rosplan_knowledge_msgs::GetMetricService :datatype-) "rosplan_knowledge_msgs/GetMetricService")
(setf (get rosplan_knowledge_msgs::GetMetricService :request) rosplan_knowledge_msgs::GetMetricServiceRequest)
(setf (get rosplan_knowledge_msgs::GetMetricService :response) rosplan_knowledge_msgs::GetMetricServiceResponse)

(defmethod rosplan_knowledge_msgs::GetMetricServiceRequest
  (:response () (instance rosplan_knowledge_msgs::GetMetricServiceResponse :init)))

(setf (get rosplan_knowledge_msgs::GetMetricServiceRequest :md5sum-) "d8654505c165321f0d5dd974ec4ca392")
(setf (get rosplan_knowledge_msgs::GetMetricServiceRequest :datatype-) "rosplan_knowledge_msgs/GetMetricServiceRequest")
(setf (get rosplan_knowledge_msgs::GetMetricServiceRequest :definition-)
      "# PDDL problem generation; service(3/3):
# Get the problem metric.
# The result is passed as a KnowledgeItem, where the value needs to be parsed by the program.
---
rosplan_knowledge_msgs/KnowledgeItem metric


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

(setf (get rosplan_knowledge_msgs::GetMetricServiceResponse :md5sum-) "d8654505c165321f0d5dd974ec4ca392")
(setf (get rosplan_knowledge_msgs::GetMetricServiceResponse :datatype-) "rosplan_knowledge_msgs/GetMetricServiceResponse")
(setf (get rosplan_knowledge_msgs::GetMetricServiceResponse :definition-)
      "# PDDL problem generation; service(3/3):
# Get the problem metric.
# The result is passed as a KnowledgeItem, where the value needs to be parsed by the program.
---
rosplan_knowledge_msgs/KnowledgeItem metric


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



(provide :rosplan_knowledge_msgs/GetMetricService "d8654505c165321f0d5dd974ec4ca392")


