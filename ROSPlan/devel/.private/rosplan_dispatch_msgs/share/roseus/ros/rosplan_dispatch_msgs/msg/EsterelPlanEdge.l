;; Auto-generated. Do not edit!


(when (boundp 'rosplan_dispatch_msgs::EsterelPlanEdge)
  (if (not (find-package "ROSPLAN_DISPATCH_MSGS"))
    (make-package "ROSPLAN_DISPATCH_MSGS"))
  (shadow 'EsterelPlanEdge (find-package "ROSPLAN_DISPATCH_MSGS")))
(unless (find-package "ROSPLAN_DISPATCH_MSGS::ESTERELPLANEDGE")
  (make-package "ROSPLAN_DISPATCH_MSGS::ESTERELPLANEDGE"))

(in-package "ROS")
;;//! \htmlinclude EsterelPlanEdge.msg.html


(defclass rosplan_dispatch_msgs::EsterelPlanEdge
  :super ros::object
  :slots (_edge_id _edge_name _signal_type _source_ids _sink_ids _duration_lower_bound _duration_upper_bound ))

(defmethod rosplan_dispatch_msgs::EsterelPlanEdge
  (:init
   (&key
    ((:edge_id __edge_id) 0)
    ((:edge_name __edge_name) "")
    ((:signal_type __signal_type) 0)
    ((:source_ids __source_ids) (make-array 0 :initial-element 0 :element-type :integer))
    ((:sink_ids __sink_ids) (make-array 0 :initial-element 0 :element-type :integer))
    ((:duration_lower_bound __duration_lower_bound) 0.0)
    ((:duration_upper_bound __duration_upper_bound) 0.0)
    )
   (send-super :init)
   (setq _edge_id (round __edge_id))
   (setq _edge_name (string __edge_name))
   (setq _signal_type (round __signal_type))
   (setq _source_ids __source_ids)
   (setq _sink_ids __sink_ids)
   (setq _duration_lower_bound (float __duration_lower_bound))
   (setq _duration_upper_bound (float __duration_upper_bound))
   self)
  (:edge_id
   (&optional __edge_id)
   (if __edge_id (setq _edge_id __edge_id)) _edge_id)
  (:edge_name
   (&optional __edge_name)
   (if __edge_name (setq _edge_name __edge_name)) _edge_name)
  (:signal_type
   (&optional __signal_type)
   (if __signal_type (setq _signal_type __signal_type)) _signal_type)
  (:source_ids
   (&optional __source_ids)
   (if __source_ids (setq _source_ids __source_ids)) _source_ids)
  (:sink_ids
   (&optional __sink_ids)
   (if __sink_ids (setq _sink_ids __sink_ids)) _sink_ids)
  (:duration_lower_bound
   (&optional __duration_lower_bound)
   (if __duration_lower_bound (setq _duration_lower_bound __duration_lower_bound)) _duration_lower_bound)
  (:duration_upper_bound
   (&optional __duration_upper_bound)
   (if __duration_upper_bound (setq _duration_upper_bound __duration_upper_bound)) _duration_upper_bound)
  (:serialization-length
   ()
   (+
    ;; int32 _edge_id
    4
    ;; string _edge_name
    4 (length _edge_name)
    ;; int32 _signal_type
    4
    ;; int32[] _source_ids
    (* 4    (length _source_ids)) 4
    ;; int32[] _sink_ids
    (* 4    (length _sink_ids)) 4
    ;; float64 _duration_lower_bound
    8
    ;; float64 _duration_upper_bound
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _edge_id
       (write-long _edge_id s)
     ;; string _edge_name
       (write-long (length _edge_name) s) (princ _edge_name s)
     ;; int32 _signal_type
       (write-long _signal_type s)
     ;; int32[] _source_ids
     (write-long (length _source_ids) s)
     (dotimes (i (length _source_ids))
       (write-long (elt _source_ids i) s)
       )
     ;; int32[] _sink_ids
     (write-long (length _sink_ids) s)
     (dotimes (i (length _sink_ids))
       (write-long (elt _sink_ids i) s)
       )
     ;; float64 _duration_lower_bound
       (sys::poke _duration_lower_bound (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _duration_upper_bound
       (sys::poke _duration_upper_bound (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _edge_id
     (setq _edge_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _edge_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _edge_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _signal_type
     (setq _signal_type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32[] _source_ids
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _source_ids (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _source_ids i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32[] _sink_ids
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _sink_ids (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _sink_ids i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; float64 _duration_lower_bound
     (setq _duration_lower_bound (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _duration_upper_bound
     (setq _duration_upper_bound (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get rosplan_dispatch_msgs::EsterelPlanEdge :md5sum-) "dbbf05c7357969fc7b48ff26fa7775db")
(setf (get rosplan_dispatch_msgs::EsterelPlanEdge :datatype-) "rosplan_dispatch_msgs/EsterelPlanEdge")
(setf (get rosplan_dispatch_msgs::EsterelPlanEdge :definition-)
      "#EsterelPlanEdge message
int32 edge_id
string edge_name
int32 signal_type
int32[] source_ids
int32[] sink_ids
float64 duration_lower_bound
float64 duration_upper_bound

")



(provide :rosplan_dispatch_msgs/EsterelPlanEdge "dbbf05c7357969fc7b48ff26fa7775db")


