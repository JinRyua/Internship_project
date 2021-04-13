;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::GetDomainOperatorDetailsService)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'GetDomainOperatorDetailsService (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINOPERATORDETAILSSERVICE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINOPERATORDETAILSSERVICE"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINOPERATORDETAILSSERVICEREQUEST")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINOPERATORDETAILSSERVICEREQUEST"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINOPERATORDETAILSSERVICERESPONSE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::GETDOMAINOPERATORDETAILSSERVICERESPONSE"))

(in-package "ROS")





(defclass rosplan_knowledge_msgs::GetDomainOperatorDetailsServiceRequest
  :super ros::object
  :slots (_name ))

(defmethod rosplan_knowledge_msgs::GetDomainOperatorDetailsServiceRequest
  (:init
   (&key
    ((:name __name) "")
    )
   (send-super :init)
   (setq _name (string __name))
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::GetDomainOperatorDetailsServiceResponse
  :super ros::object
  :slots (_op ))

(defmethod rosplan_knowledge_msgs::GetDomainOperatorDetailsServiceResponse
  (:init
   (&key
    ((:op __op) (instance rosplan_knowledge_msgs::DomainOperator :init))
    )
   (send-super :init)
   (setq _op __op)
   self)
  (:op
   (&rest __op)
   (if (keywordp (car __op))
       (send* _op __op)
     (progn
       (if __op (setq _op (car __op)))
       _op)))
  (:serialization-length
   ()
   (+
    ;; rosplan_knowledge_msgs/DomainOperator _op
    (send _op :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; rosplan_knowledge_msgs/DomainOperator _op
       (send _op :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; rosplan_knowledge_msgs/DomainOperator _op
     (send _op :deserialize buf ptr-) (incf ptr- (send _op :serialization-length))
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::GetDomainOperatorDetailsService
  :super ros::object
  :slots ())

(setf (get rosplan_knowledge_msgs::GetDomainOperatorDetailsService :md5sum-) "d1ca18637f3dfc6b50d99a8c3a27f01d")
(setf (get rosplan_knowledge_msgs::GetDomainOperatorDetailsService :datatype-) "rosplan_knowledge_msgs/GetDomainOperatorDetailsService")
(setf (get rosplan_knowledge_msgs::GetDomainOperatorDetailsService :request) rosplan_knowledge_msgs::GetDomainOperatorDetailsServiceRequest)
(setf (get rosplan_knowledge_msgs::GetDomainOperatorDetailsService :response) rosplan_knowledge_msgs::GetDomainOperatorDetailsServiceResponse)

(defmethod rosplan_knowledge_msgs::GetDomainOperatorDetailsServiceRequest
  (:response () (instance rosplan_knowledge_msgs::GetDomainOperatorDetailsServiceResponse :init)))

(setf (get rosplan_knowledge_msgs::GetDomainOperatorDetailsServiceRequest :md5sum-) "d1ca18637f3dfc6b50d99a8c3a27f01d")
(setf (get rosplan_knowledge_msgs::GetDomainOperatorDetailsServiceRequest :datatype-) "rosplan_knowledge_msgs/GetDomainOperatorDetailsServiceRequest")
(setf (get rosplan_knowledge_msgs::GetDomainOperatorDetailsServiceRequest :definition-)
      "# Fetching the Domain (2.5/3):
# Get all details of a specific operator in the domain.
string name
---
rosplan_knowledge_msgs/DomainOperator op


================================================================================
MSG: rosplan_knowledge_msgs/DomainOperator
# A message used to represent an ungrounded operator in the domain.

# (1) name and parameters
rosplan_knowledge_msgs/DomainFormula formula

# (2) duration constraint


# (3) effect lists
rosplan_knowledge_msgs/DomainFormula[] at_start_add_effects
rosplan_knowledge_msgs/DomainFormula[] at_start_del_effects
rosplan_knowledge_msgs/DomainFormula[] at_end_add_effects
rosplan_knowledge_msgs/DomainFormula[] at_end_del_effects
rosplan_knowledge_msgs/DomainAssignment[] at_start_assign_effects
rosplan_knowledge_msgs/DomainAssignment[] at_end_assign_effects

# (4) conditions
rosplan_knowledge_msgs/DomainFormula[] at_start_simple_condition
rosplan_knowledge_msgs/DomainFormula[] over_all_simple_condition
rosplan_knowledge_msgs/DomainFormula[] at_end_simple_condition
rosplan_knowledge_msgs/DomainFormula[] at_start_neg_condition
rosplan_knowledge_msgs/DomainFormula[] over_all_neg_condition
rosplan_knowledge_msgs/DomainFormula[] at_end_neg_condition

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
MSG: rosplan_knowledge_msgs/DomainAssignment
# A message used to store the numeric effects of an action
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

(setf (get rosplan_knowledge_msgs::GetDomainOperatorDetailsServiceResponse :md5sum-) "d1ca18637f3dfc6b50d99a8c3a27f01d")
(setf (get rosplan_knowledge_msgs::GetDomainOperatorDetailsServiceResponse :datatype-) "rosplan_knowledge_msgs/GetDomainOperatorDetailsServiceResponse")
(setf (get rosplan_knowledge_msgs::GetDomainOperatorDetailsServiceResponse :definition-)
      "# Fetching the Domain (2.5/3):
# Get all details of a specific operator in the domain.
string name
---
rosplan_knowledge_msgs/DomainOperator op


================================================================================
MSG: rosplan_knowledge_msgs/DomainOperator
# A message used to represent an ungrounded operator in the domain.

# (1) name and parameters
rosplan_knowledge_msgs/DomainFormula formula

# (2) duration constraint


# (3) effect lists
rosplan_knowledge_msgs/DomainFormula[] at_start_add_effects
rosplan_knowledge_msgs/DomainFormula[] at_start_del_effects
rosplan_knowledge_msgs/DomainFormula[] at_end_add_effects
rosplan_knowledge_msgs/DomainFormula[] at_end_del_effects
rosplan_knowledge_msgs/DomainAssignment[] at_start_assign_effects
rosplan_knowledge_msgs/DomainAssignment[] at_end_assign_effects

# (4) conditions
rosplan_knowledge_msgs/DomainFormula[] at_start_simple_condition
rosplan_knowledge_msgs/DomainFormula[] over_all_simple_condition
rosplan_knowledge_msgs/DomainFormula[] at_end_simple_condition
rosplan_knowledge_msgs/DomainFormula[] at_start_neg_condition
rosplan_knowledge_msgs/DomainFormula[] over_all_neg_condition
rosplan_knowledge_msgs/DomainFormula[] at_end_neg_condition

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
MSG: rosplan_knowledge_msgs/DomainAssignment
# A message used to store the numeric effects of an action
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



(provide :rosplan_knowledge_msgs/GetDomainOperatorDetailsService "d1ca18637f3dfc6b50d99a8c3a27f01d")


