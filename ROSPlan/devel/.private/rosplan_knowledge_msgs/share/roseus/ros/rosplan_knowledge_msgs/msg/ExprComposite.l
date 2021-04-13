;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::ExprComposite)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'ExprComposite (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRCOMPOSITE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRCOMPOSITE"))

(in-package "ROS")
;;//! \htmlinclude ExprComposite.msg.html


(defclass rosplan_knowledge_msgs::ExprComposite
  :super ros::object
  :slots (_tokens ))

(defmethod rosplan_knowledge_msgs::ExprComposite
  (:init
   (&key
    ((:tokens __tokens) (let (r) (dotimes (i 0) (push (instance rosplan_knowledge_msgs::ExprBase :init) r)) r))
    )
   (send-super :init)
   (setq _tokens __tokens)
   self)
  (:tokens
   (&rest __tokens)
   (if (keywordp (car __tokens))
       (send* _tokens __tokens)
     (progn
       (if __tokens (setq _tokens (car __tokens)))
       _tokens)))
  (:serialization-length
   ()
   (+
    ;; rosplan_knowledge_msgs/ExprBase[] _tokens
    (apply #'+ (send-all _tokens :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; rosplan_knowledge_msgs/ExprBase[] _tokens
     (write-long (length _tokens) s)
     (dolist (elem _tokens)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; rosplan_knowledge_msgs/ExprBase[] _tokens
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _tokens (let (r) (dotimes (i n) (push (instance rosplan_knowledge_msgs::ExprBase :init) r)) r))
     (dolist (elem- _tokens)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get rosplan_knowledge_msgs::ExprComposite :md5sum-) "9633231342c31ed233d306d6bf5cb1d3")
(setf (get rosplan_knowledge_msgs::ExprComposite :datatype-) "rosplan_knowledge_msgs/ExprComposite")
(setf (get rosplan_knowledge_msgs::ExprComposite :definition-)
      "# A message used to represent a numerical expression; composite type (2/2)
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



(provide :rosplan_knowledge_msgs/ExprComposite "9633231342c31ed233d306d6bf5cb1d3")


