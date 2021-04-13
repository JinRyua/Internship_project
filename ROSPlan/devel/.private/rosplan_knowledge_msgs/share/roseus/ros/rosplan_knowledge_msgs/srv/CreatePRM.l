;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::CreatePRM)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'CreatePRM (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::CREATEPRM")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::CREATEPRM"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::CREATEPRMREQUEST")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::CREATEPRMREQUEST"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::CREATEPRMRESPONSE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::CREATEPRMRESPONSE"))

(in-package "ROS")





(defclass rosplan_knowledge_msgs::CreatePRMRequest
  :super ros::object
  :slots (_nr_waypoints _min_distance _casting_distance _connecting_distance _occupancy_threshold _total_attempts ))

(defmethod rosplan_knowledge_msgs::CreatePRMRequest
  (:init
   (&key
    ((:nr_waypoints __nr_waypoints) 0)
    ((:min_distance __min_distance) 0.0)
    ((:casting_distance __casting_distance) 0.0)
    ((:connecting_distance __connecting_distance) 0.0)
    ((:occupancy_threshold __occupancy_threshold) 0)
    ((:total_attempts __total_attempts) 0)
    )
   (send-super :init)
   (setq _nr_waypoints (round __nr_waypoints))
   (setq _min_distance (float __min_distance))
   (setq _casting_distance (float __casting_distance))
   (setq _connecting_distance (float __connecting_distance))
   (setq _occupancy_threshold (round __occupancy_threshold))
   (setq _total_attempts (round __total_attempts))
   self)
  (:nr_waypoints
   (&optional __nr_waypoints)
   (if __nr_waypoints (setq _nr_waypoints __nr_waypoints)) _nr_waypoints)
  (:min_distance
   (&optional __min_distance)
   (if __min_distance (setq _min_distance __min_distance)) _min_distance)
  (:casting_distance
   (&optional __casting_distance)
   (if __casting_distance (setq _casting_distance __casting_distance)) _casting_distance)
  (:connecting_distance
   (&optional __connecting_distance)
   (if __connecting_distance (setq _connecting_distance __connecting_distance)) _connecting_distance)
  (:occupancy_threshold
   (&optional __occupancy_threshold)
   (if __occupancy_threshold (setq _occupancy_threshold __occupancy_threshold)) _occupancy_threshold)
  (:total_attempts
   (&optional __total_attempts)
   (if __total_attempts (setq _total_attempts __total_attempts)) _total_attempts)
  (:serialization-length
   ()
   (+
    ;; int32 _nr_waypoints
    4
    ;; float32 _min_distance
    4
    ;; float32 _casting_distance
    4
    ;; float32 _connecting_distance
    4
    ;; int8 _occupancy_threshold
    1
    ;; int32 _total_attempts
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _nr_waypoints
       (write-long _nr_waypoints s)
     ;; float32 _min_distance
       (sys::poke _min_distance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _casting_distance
       (sys::poke _casting_distance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _connecting_distance
       (sys::poke _connecting_distance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int8 _occupancy_threshold
       (write-byte _occupancy_threshold s)
     ;; int32 _total_attempts
       (write-long _total_attempts s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _nr_waypoints
     (setq _nr_waypoints (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _min_distance
     (setq _min_distance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _casting_distance
     (setq _casting_distance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _connecting_distance
     (setq _connecting_distance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int8 _occupancy_threshold
     (setq _occupancy_threshold (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _occupancy_threshold 127) (setq _occupancy_threshold (- _occupancy_threshold 256)))
   ;; int32 _total_attempts
     (setq _total_attempts (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::CreatePRMResponse
  :super ros::object
  :slots (_waypoints ))

(defmethod rosplan_knowledge_msgs::CreatePRMResponse
  (:init
   (&key
    ((:waypoints __waypoints) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _waypoints __waypoints)
   self)
  (:waypoints
   (&optional __waypoints)
   (if __waypoints (setq _waypoints __waypoints)) _waypoints)
  (:serialization-length
   ()
   (+
    ;; string[] _waypoints
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _waypoints)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string[] _waypoints
     (write-long (length _waypoints) s)
     (dolist (elem _waypoints)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string[] _waypoints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _waypoints (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _waypoints i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::CreatePRM
  :super ros::object
  :slots ())

(setf (get rosplan_knowledge_msgs::CreatePRM :md5sum-) "e2d990767484410646d05d82e9a4545b")
(setf (get rosplan_knowledge_msgs::CreatePRM :datatype-) "rosplan_knowledge_msgs/CreatePRM")
(setf (get rosplan_knowledge_msgs::CreatePRM :request) rosplan_knowledge_msgs::CreatePRMRequest)
(setf (get rosplan_knowledge_msgs::CreatePRM :response) rosplan_knowledge_msgs::CreatePRMResponse)

(defmethod rosplan_knowledge_msgs::CreatePRMRequest
  (:response () (instance rosplan_knowledge_msgs::CreatePRMResponse :init)))

(setf (get rosplan_knowledge_msgs::CreatePRMRequest :md5sum-) "e2d990767484410646d05d82e9a4545b")
(setf (get rosplan_knowledge_msgs::CreatePRMRequest :datatype-) "rosplan_knowledge_msgs/CreatePRMRequest")
(setf (get rosplan_knowledge_msgs::CreatePRMRequest :definition-)
      "int32 nr_waypoints
float32 min_distance
float32 casting_distance
float32 connecting_distance
int8 occupancy_threshold
int32 total_attempts
---
string[] waypoints
")

(setf (get rosplan_knowledge_msgs::CreatePRMResponse :md5sum-) "e2d990767484410646d05d82e9a4545b")
(setf (get rosplan_knowledge_msgs::CreatePRMResponse :datatype-) "rosplan_knowledge_msgs/CreatePRMResponse")
(setf (get rosplan_knowledge_msgs::CreatePRMResponse :definition-)
      "int32 nr_waypoints
float32 min_distance
float32 casting_distance
float32 connecting_distance
int8 occupancy_threshold
int32 total_attempts
---
string[] waypoints
")



(provide :rosplan_knowledge_msgs/CreatePRM "e2d990767484410646d05d82e9a4545b")


