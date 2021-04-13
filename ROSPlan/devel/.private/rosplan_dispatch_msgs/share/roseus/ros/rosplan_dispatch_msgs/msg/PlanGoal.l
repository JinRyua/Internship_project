;; Auto-generated. Do not edit!


(when (boundp 'rosplan_dispatch_msgs::PlanGoal)
  (if (not (find-package "ROSPLAN_DISPATCH_MSGS"))
    (make-package "ROSPLAN_DISPATCH_MSGS"))
  (shadow 'PlanGoal (find-package "ROSPLAN_DISPATCH_MSGS")))
(unless (find-package "ROSPLAN_DISPATCH_MSGS::PLANGOAL")
  (make-package "ROSPLAN_DISPATCH_MSGS::PLANGOAL"))

(in-package "ROS")
;;//! \htmlinclude PlanGoal.msg.html


(defclass rosplan_dispatch_msgs::PlanGoal
  :super ros::object
  :slots (_domain_path _problem_path _data_path _planner_command _use_problem_topic _start_action_id ))

(defmethod rosplan_dispatch_msgs::PlanGoal
  (:init
   (&key
    ((:domain_path __domain_path) "")
    ((:problem_path __problem_path) "")
    ((:data_path __data_path) "")
    ((:planner_command __planner_command) "")
    ((:use_problem_topic __use_problem_topic) nil)
    ((:start_action_id __start_action_id) 0)
    )
   (send-super :init)
   (setq _domain_path (string __domain_path))
   (setq _problem_path (string __problem_path))
   (setq _data_path (string __data_path))
   (setq _planner_command (string __planner_command))
   (setq _use_problem_topic __use_problem_topic)
   (setq _start_action_id (round __start_action_id))
   self)
  (:domain_path
   (&optional __domain_path)
   (if __domain_path (setq _domain_path __domain_path)) _domain_path)
  (:problem_path
   (&optional __problem_path)
   (if __problem_path (setq _problem_path __problem_path)) _problem_path)
  (:data_path
   (&optional __data_path)
   (if __data_path (setq _data_path __data_path)) _data_path)
  (:planner_command
   (&optional __planner_command)
   (if __planner_command (setq _planner_command __planner_command)) _planner_command)
  (:use_problem_topic
   (&optional __use_problem_topic)
   (if __use_problem_topic (setq _use_problem_topic __use_problem_topic)) _use_problem_topic)
  (:start_action_id
   (&optional __start_action_id)
   (if __start_action_id (setq _start_action_id __start_action_id)) _start_action_id)
  (:serialization-length
   ()
   (+
    ;; string _domain_path
    4 (length _domain_path)
    ;; string _problem_path
    4 (length _problem_path)
    ;; string _data_path
    4 (length _data_path)
    ;; string _planner_command
    4 (length _planner_command)
    ;; bool _use_problem_topic
    1
    ;; uint64 _start_action_id
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _domain_path
       (write-long (length _domain_path) s) (princ _domain_path s)
     ;; string _problem_path
       (write-long (length _problem_path) s) (princ _problem_path s)
     ;; string _data_path
       (write-long (length _data_path) s) (princ _data_path s)
     ;; string _planner_command
       (write-long (length _planner_command) s) (princ _planner_command s)
     ;; bool _use_problem_topic
       (if _use_problem_topic (write-byte -1 s) (write-byte 0 s))
     ;; uint64 _start_action_id
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _start_action_id (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _start_action_id) (= (length (_start_action_id . bv)) 2)) ;; bignum
              (write-long (ash (elt (_start_action_id . bv) 0) 0) s)
              (write-long (ash (elt (_start_action_id . bv) 1) -1) s))
             ((and (class _start_action_id) (= (length (_start_action_id . bv)) 1)) ;; big1
              (write-long (elt (_start_action_id . bv) 0) s)
              (write-long (if (>= _start_action_id 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _start_action_id s)(write-long (if (>= _start_action_id 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _domain_path
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _domain_path (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _problem_path
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _problem_path (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _data_path
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _data_path (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _planner_command
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _planner_command (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _use_problem_topic
     (setq _use_problem_topic (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint64 _start_action_id
     
#+(or :alpha :irix6 :x86_64)
      (setf _start_action_id (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _start_action_id (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(setf (get rosplan_dispatch_msgs::PlanGoal :md5sum-) "ec56e034bdab5d47c02286cf335fd906")
(setf (get rosplan_dispatch_msgs::PlanGoal :datatype-) "rosplan_dispatch_msgs/PlanGoal")
(setf (get rosplan_dispatch_msgs::PlanGoal :definition-)
      "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======
# Planning action definition
# goal definition
string domain_path
string problem_path
string data_path
string planner_command
bool use_problem_topic
uint64 start_action_id

")



(provide :rosplan_dispatch_msgs/PlanGoal "ec56e034bdab5d47c02286cf335fd906")


