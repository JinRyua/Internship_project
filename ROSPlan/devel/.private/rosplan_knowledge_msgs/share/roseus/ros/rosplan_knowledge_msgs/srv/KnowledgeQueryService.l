;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::KnowledgeQueryService)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'KnowledgeQueryService (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEQUERYSERVICE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEQUERYSERVICE"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEQUERYSERVICEREQUEST")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEQUERYSERVICEREQUEST"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEQUERYSERVICERESPONSE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEQUERYSERVICERESPONSE"))

(in-package "ROS")





(defclass rosplan_knowledge_msgs::KnowledgeQueryServiceRequest
  :super ros::object
  :slots (_knowledge ))

(defmethod rosplan_knowledge_msgs::KnowledgeQueryServiceRequest
  (:init
   (&key
    ((:knowledge __knowledge) (let (r) (dotimes (i 0) (push (instance rosplan_knowledge_msgs::KnowledgeItem :init) r)) r))
    )
   (send-super :init)
   (setq _knowledge __knowledge)
   self)
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
    ;; rosplan_knowledge_msgs/KnowledgeItem[] _knowledge
    (apply #'+ (send-all _knowledge :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; rosplan_knowledge_msgs/KnowledgeItem[] _knowledge
     (write-long (length _knowledge) s)
     (dolist (elem _knowledge)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
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

(defclass rosplan_knowledge_msgs::KnowledgeQueryServiceResponse
  :super ros::object
  :slots (_all_true _results _false_knowledge ))

(defmethod rosplan_knowledge_msgs::KnowledgeQueryServiceResponse
  (:init
   (&key
    ((:all_true __all_true) nil)
    ((:results __results) (let (r) (dotimes (i 0) (push nil r)) r))
    ((:false_knowledge __false_knowledge) (let (r) (dotimes (i 0) (push (instance rosplan_knowledge_msgs::KnowledgeItem :init) r)) r))
    )
   (send-super :init)
   (setq _all_true __all_true)
   (setq _results __results)
   (setq _false_knowledge __false_knowledge)
   self)
  (:all_true
   (&optional __all_true)
   (if __all_true (setq _all_true __all_true)) _all_true)
  (:results
   (&optional __results)
   (if __results (setq _results __results)) _results)
  (:false_knowledge
   (&rest __false_knowledge)
   (if (keywordp (car __false_knowledge))
       (send* _false_knowledge __false_knowledge)
     (progn
       (if __false_knowledge (setq _false_knowledge (car __false_knowledge)))
       _false_knowledge)))
  (:serialization-length
   ()
   (+
    ;; bool _all_true
    1
    ;; bool[] _results
    (* 1    (length _results)) 4
    ;; rosplan_knowledge_msgs/KnowledgeItem[] _false_knowledge
    (apply #'+ (send-all _false_knowledge :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _all_true
       (if _all_true (write-byte -1 s) (write-byte 0 s))
     ;; bool[] _results
     (write-long (length _results) s)
     (dotimes (i (length _results))
       (if (elt _results i) (write-byte -1 s) (write-byte 0 s))
       )
     ;; rosplan_knowledge_msgs/KnowledgeItem[] _false_knowledge
     (write-long (length _false_knowledge) s)
     (dolist (elem _false_knowledge)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _all_true
     (setq _all_true (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool[] _results
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _results (make-list n))
     (dotimes (i n)
     (setf (elt _results i) (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
     ))
   ;; rosplan_knowledge_msgs/KnowledgeItem[] _false_knowledge
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _false_knowledge (let (r) (dotimes (i n) (push (instance rosplan_knowledge_msgs::KnowledgeItem :init) r)) r))
     (dolist (elem- _false_knowledge)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::KnowledgeQueryService
  :super ros::object
  :slots ())

(setf (get rosplan_knowledge_msgs::KnowledgeQueryService :md5sum-) "e5cd9298f5a545040e7835836f3210cb")
(setf (get rosplan_knowledge_msgs::KnowledgeQueryService :datatype-) "rosplan_knowledge_msgs/KnowledgeQueryService")
(setf (get rosplan_knowledge_msgs::KnowledgeQueryService :request) rosplan_knowledge_msgs::KnowledgeQueryServiceRequest)
(setf (get rosplan_knowledge_msgs::KnowledgeQueryService :response) rosplan_knowledge_msgs::KnowledgeQueryServiceResponse)

(defmethod rosplan_knowledge_msgs::KnowledgeQueryServiceRequest
  (:response () (instance rosplan_knowledge_msgs::KnowledgeQueryServiceResponse :init)))

(setf (get rosplan_knowledge_msgs::KnowledgeQueryServiceRequest :md5sum-) "e5cd9298f5a545040e7835836f3210cb")
(setf (get rosplan_knowledge_msgs::KnowledgeQueryServiceRequest :datatype-) "rosplan_knowledge_msgs/KnowledgeQueryServiceRequest")
(setf (get rosplan_knowledge_msgs::KnowledgeQueryServiceRequest :definition-)
      "rosplan_knowledge_msgs/KnowledgeItem[] knowledge

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
bool all_true
bool[] results
rosplan_knowledge_msgs/KnowledgeItem[] false_knowledge


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

(setf (get rosplan_knowledge_msgs::KnowledgeQueryServiceResponse :md5sum-) "e5cd9298f5a545040e7835836f3210cb")
(setf (get rosplan_knowledge_msgs::KnowledgeQueryServiceResponse :datatype-) "rosplan_knowledge_msgs/KnowledgeQueryServiceResponse")
(setf (get rosplan_knowledge_msgs::KnowledgeQueryServiceResponse :definition-)
      "rosplan_knowledge_msgs/KnowledgeItem[] knowledge

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
bool all_true
bool[] results
rosplan_knowledge_msgs/KnowledgeItem[] false_knowledge


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



(provide :rosplan_knowledge_msgs/KnowledgeQueryService "e5cd9298f5a545040e7835836f3210cb")


