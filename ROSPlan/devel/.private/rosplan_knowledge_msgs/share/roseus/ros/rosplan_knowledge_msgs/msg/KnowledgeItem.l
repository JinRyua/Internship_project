;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::KnowledgeItem)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'KnowledgeItem (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEITEM")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEITEM"))

(in-package "ROS")
;;//! \htmlinclude KnowledgeItem.msg.html
(if (not (find-package "DIAGNOSTIC_MSGS"))
  (ros::roseus-add-msgs "diagnostic_msgs"))


(intern "*INSTANCE*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEITEM"))
(shadow '*INSTANCE* (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEITEM"))
(defconstant rosplan_knowledge_msgs::KnowledgeItem::*INSTANCE* 0)
(intern "*FACT*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEITEM"))
(shadow '*FACT* (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEITEM"))
(defconstant rosplan_knowledge_msgs::KnowledgeItem::*FACT* 1)
(intern "*FUNCTION*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEITEM"))
(shadow '*FUNCTION* (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEITEM"))
(defconstant rosplan_knowledge_msgs::KnowledgeItem::*FUNCTION* 2)
(intern "*EXPRESSION*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEITEM"))
(shadow '*EXPRESSION* (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEITEM"))
(defconstant rosplan_knowledge_msgs::KnowledgeItem::*EXPRESSION* 3)
(intern "*INEQUALITY*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEITEM"))
(shadow '*INEQUALITY* (find-package "ROSPLAN_KNOWLEDGE_MSGS::KNOWLEDGEITEM"))
(defconstant rosplan_knowledge_msgs::KnowledgeItem::*INEQUALITY* 4)
(defclass rosplan_knowledge_msgs::KnowledgeItem
  :super ros::object
  :slots (_knowledge_type _initial_time _is_negative _instance_type _instance_name _attribute_name _values _function_value _optimization _expr _ineq ))

(defmethod rosplan_knowledge_msgs::KnowledgeItem
  (:init
   (&key
    ((:knowledge_type __knowledge_type) 0)
    ((:initial_time __initial_time) (instance ros::time :init))
    ((:is_negative __is_negative) nil)
    ((:instance_type __instance_type) "")
    ((:instance_name __instance_name) "")
    ((:attribute_name __attribute_name) "")
    ((:values __values) (let (r) (dotimes (i 0) (push (instance diagnostic_msgs::KeyValue :init) r)) r))
    ((:function_value __function_value) 0.0)
    ((:optimization __optimization) "")
    ((:expr __expr) (instance rosplan_knowledge_msgs::ExprComposite :init))
    ((:ineq __ineq) (instance rosplan_knowledge_msgs::DomainInequality :init))
    )
   (send-super :init)
   (setq _knowledge_type (round __knowledge_type))
   (setq _initial_time __initial_time)
   (setq _is_negative __is_negative)
   (setq _instance_type (string __instance_type))
   (setq _instance_name (string __instance_name))
   (setq _attribute_name (string __attribute_name))
   (setq _values __values)
   (setq _function_value (float __function_value))
   (setq _optimization (string __optimization))
   (setq _expr __expr)
   (setq _ineq __ineq)
   self)
  (:knowledge_type
   (&optional __knowledge_type)
   (if __knowledge_type (setq _knowledge_type __knowledge_type)) _knowledge_type)
  (:initial_time
   (&optional __initial_time)
   (if __initial_time (setq _initial_time __initial_time)) _initial_time)
  (:is_negative
   (&optional __is_negative)
   (if __is_negative (setq _is_negative __is_negative)) _is_negative)
  (:instance_type
   (&optional __instance_type)
   (if __instance_type (setq _instance_type __instance_type)) _instance_type)
  (:instance_name
   (&optional __instance_name)
   (if __instance_name (setq _instance_name __instance_name)) _instance_name)
  (:attribute_name
   (&optional __attribute_name)
   (if __attribute_name (setq _attribute_name __attribute_name)) _attribute_name)
  (:values
   (&rest __values)
   (if (keywordp (car __values))
       (send* _values __values)
     (progn
       (if __values (setq _values (car __values)))
       _values)))
  (:function_value
   (&optional __function_value)
   (if __function_value (setq _function_value __function_value)) _function_value)
  (:optimization
   (&optional __optimization)
   (if __optimization (setq _optimization __optimization)) _optimization)
  (:expr
   (&rest __expr)
   (if (keywordp (car __expr))
       (send* _expr __expr)
     (progn
       (if __expr (setq _expr (car __expr)))
       _expr)))
  (:ineq
   (&rest __ineq)
   (if (keywordp (car __ineq))
       (send* _ineq __ineq)
     (progn
       (if __ineq (setq _ineq (car __ineq)))
       _ineq)))
  (:serialization-length
   ()
   (+
    ;; uint8 _knowledge_type
    1
    ;; time _initial_time
    8
    ;; bool _is_negative
    1
    ;; string _instance_type
    4 (length _instance_type)
    ;; string _instance_name
    4 (length _instance_name)
    ;; string _attribute_name
    4 (length _attribute_name)
    ;; diagnostic_msgs/KeyValue[] _values
    (apply #'+ (send-all _values :serialization-length)) 4
    ;; float64 _function_value
    8
    ;; string _optimization
    4 (length _optimization)
    ;; rosplan_knowledge_msgs/ExprComposite _expr
    (send _expr :serialization-length)
    ;; rosplan_knowledge_msgs/DomainInequality _ineq
    (send _ineq :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _knowledge_type
       (write-byte _knowledge_type s)
     ;; time _initial_time
       (write-long (send _initial_time :sec) s) (write-long (send _initial_time :nsec) s)
     ;; bool _is_negative
       (if _is_negative (write-byte -1 s) (write-byte 0 s))
     ;; string _instance_type
       (write-long (length _instance_type) s) (princ _instance_type s)
     ;; string _instance_name
       (write-long (length _instance_name) s) (princ _instance_name s)
     ;; string _attribute_name
       (write-long (length _attribute_name) s) (princ _attribute_name s)
     ;; diagnostic_msgs/KeyValue[] _values
     (write-long (length _values) s)
     (dolist (elem _values)
       (send elem :serialize s)
       )
     ;; float64 _function_value
       (sys::poke _function_value (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; string _optimization
       (write-long (length _optimization) s) (princ _optimization s)
     ;; rosplan_knowledge_msgs/ExprComposite _expr
       (send _expr :serialize s)
     ;; rosplan_knowledge_msgs/DomainInequality _ineq
       (send _ineq :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _knowledge_type
     (setq _knowledge_type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; time _initial_time
     (send _initial_time :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _initial_time :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _is_negative
     (setq _is_negative (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _instance_type
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _instance_type (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _instance_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _instance_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _attribute_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _attribute_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; diagnostic_msgs/KeyValue[] _values
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _values (let (r) (dotimes (i n) (push (instance diagnostic_msgs::KeyValue :init) r)) r))
     (dolist (elem- _values)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; float64 _function_value
     (setq _function_value (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; string _optimization
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _optimization (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; rosplan_knowledge_msgs/ExprComposite _expr
     (send _expr :deserialize buf ptr-) (incf ptr- (send _expr :serialization-length))
   ;; rosplan_knowledge_msgs/DomainInequality _ineq
     (send _ineq :deserialize buf ptr-) (incf ptr- (send _ineq :serialization-length))
   ;;
   self)
  )

(setf (get rosplan_knowledge_msgs::KnowledgeItem :md5sum-) "2339db6aaf05241f945b3ba17ef04eb1")
(setf (get rosplan_knowledge_msgs::KnowledgeItem :datatype-) "rosplan_knowledge_msgs/KnowledgeItem")
(setf (get rosplan_knowledge_msgs::KnowledgeItem :definition-)
      "# A knowledge item used to represent a piece of the state in ROSPlan

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



(provide :rosplan_knowledge_msgs/KnowledgeItem "2339db6aaf05241f945b3ba17ef04eb1")


