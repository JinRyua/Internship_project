;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::ExprBase)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'ExprBase (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))

(in-package "ROS")
;;//! \htmlinclude ExprBase.msg.html


(intern "*CONSTANT*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(shadow '*CONSTANT* (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(defconstant rosplan_knowledge_msgs::ExprBase::*CONSTANT* 0)
(intern "*FUNCTION*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(shadow '*FUNCTION* (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(defconstant rosplan_knowledge_msgs::ExprBase::*FUNCTION* 1)
(intern "*OPERATOR*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(shadow '*OPERATOR* (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(defconstant rosplan_knowledge_msgs::ExprBase::*OPERATOR* 2)
(intern "*SPECIAL*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(shadow '*SPECIAL* (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(defconstant rosplan_knowledge_msgs::ExprBase::*SPECIAL* 3)
(intern "*ADD*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(shadow '*ADD* (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(defconstant rosplan_knowledge_msgs::ExprBase::*ADD* 0)
(intern "*SUB*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(shadow '*SUB* (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(defconstant rosplan_knowledge_msgs::ExprBase::*SUB* 1)
(intern "*MUL*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(shadow '*MUL* (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(defconstant rosplan_knowledge_msgs::ExprBase::*MUL* 2)
(intern "*DIV*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(shadow '*DIV* (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(defconstant rosplan_knowledge_msgs::ExprBase::*DIV* 3)
(intern "*UMINUS*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(shadow '*UMINUS* (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(defconstant rosplan_knowledge_msgs::ExprBase::*UMINUS* 4)
(intern "*HASHT*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(shadow '*HASHT* (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(defconstant rosplan_knowledge_msgs::ExprBase::*HASHT* 0)
(intern "*TOTAL_TIME*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(shadow '*TOTAL_TIME* (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(defconstant rosplan_knowledge_msgs::ExprBase::*TOTAL_TIME* 1)
(intern "*DURATION*" (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(shadow '*DURATION* (find-package "ROSPLAN_KNOWLEDGE_MSGS::EXPRBASE"))
(defconstant rosplan_knowledge_msgs::ExprBase::*DURATION* 2)
(defclass rosplan_knowledge_msgs::ExprBase
  :super ros::object
  :slots (_expr_type _constant _function _op _special_type ))

(defmethod rosplan_knowledge_msgs::ExprBase
  (:init
   (&key
    ((:expr_type __expr_type) 0)
    ((:constant __constant) 0.0)
    ((:function __function) (instance rosplan_knowledge_msgs::DomainFormula :init))
    ((:op __op) 0)
    ((:special_type __special_type) 0)
    )
   (send-super :init)
   (setq _expr_type (round __expr_type))
   (setq _constant (float __constant))
   (setq _function __function)
   (setq _op (round __op))
   (setq _special_type (round __special_type))
   self)
  (:expr_type
   (&optional __expr_type)
   (if __expr_type (setq _expr_type __expr_type)) _expr_type)
  (:constant
   (&optional __constant)
   (if __constant (setq _constant __constant)) _constant)
  (:function
   (&rest __function)
   (if (keywordp (car __function))
       (send* _function __function)
     (progn
       (if __function (setq _function (car __function)))
       _function)))
  (:op
   (&optional __op)
   (if __op (setq _op __op)) _op)
  (:special_type
   (&optional __special_type)
   (if __special_type (setq _special_type __special_type)) _special_type)
  (:serialization-length
   ()
   (+
    ;; uint8 _expr_type
    1
    ;; float64 _constant
    8
    ;; rosplan_knowledge_msgs/DomainFormula _function
    (send _function :serialization-length)
    ;; uint8 _op
    1
    ;; uint8 _special_type
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _expr_type
       (write-byte _expr_type s)
     ;; float64 _constant
       (sys::poke _constant (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; rosplan_knowledge_msgs/DomainFormula _function
       (send _function :serialize s)
     ;; uint8 _op
       (write-byte _op s)
     ;; uint8 _special_type
       (write-byte _special_type s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _expr_type
     (setq _expr_type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float64 _constant
     (setq _constant (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; rosplan_knowledge_msgs/DomainFormula _function
     (send _function :deserialize buf ptr-) (incf ptr- (send _function :serialization-length))
   ;; uint8 _op
     (setq _op (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _special_type
     (setq _special_type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get rosplan_knowledge_msgs::ExprBase :md5sum-) "5d33d1b51272864ef936be512369146f")
(setf (get rosplan_knowledge_msgs::ExprBase :datatype-) "rosplan_knowledge_msgs/ExprBase")
(setf (get rosplan_knowledge_msgs::ExprBase :definition-)
      "# A message used to represent a numerical expression; base types (1/2)

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



(provide :rosplan_knowledge_msgs/ExprBase "5d33d1b51272864ef936be512369146f")


