;; Auto-generated. Do not edit!


(when (boundp 'rosplan_knowledge_msgs::RemoveWaypoint)
  (if (not (find-package "ROSPLAN_KNOWLEDGE_MSGS"))
    (make-package "ROSPLAN_KNOWLEDGE_MSGS"))
  (shadow 'RemoveWaypoint (find-package "ROSPLAN_KNOWLEDGE_MSGS")))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::REMOVEWAYPOINT")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::REMOVEWAYPOINT"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::REMOVEWAYPOINTREQUEST")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::REMOVEWAYPOINTREQUEST"))
(unless (find-package "ROSPLAN_KNOWLEDGE_MSGS::REMOVEWAYPOINTRESPONSE")
  (make-package "ROSPLAN_KNOWLEDGE_MSGS::REMOVEWAYPOINTRESPONSE"))

(in-package "ROS")





(defclass rosplan_knowledge_msgs::RemoveWaypointRequest
  :super ros::object
  :slots (_id ))

(defmethod rosplan_knowledge_msgs::RemoveWaypointRequest
  (:init
   (&key
    ((:id __id) "")
    )
   (send-super :init)
   (setq _id (string __id))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:serialization-length
   ()
   (+
    ;; string _id
    4 (length _id)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _id
       (write-long (length _id) s) (princ _id s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass rosplan_knowledge_msgs::RemoveWaypointResponse
  :super ros::object
  :slots ())

(defmethod rosplan_knowledge_msgs::RemoveWaypointResponse
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

(defclass rosplan_knowledge_msgs::RemoveWaypoint
  :super ros::object
  :slots ())

(setf (get rosplan_knowledge_msgs::RemoveWaypoint :md5sum-) "bbfcda76036ebbe3d36caf7af80b260c")
(setf (get rosplan_knowledge_msgs::RemoveWaypoint :datatype-) "rosplan_knowledge_msgs/RemoveWaypoint")
(setf (get rosplan_knowledge_msgs::RemoveWaypoint :request) rosplan_knowledge_msgs::RemoveWaypointRequest)
(setf (get rosplan_knowledge_msgs::RemoveWaypoint :response) rosplan_knowledge_msgs::RemoveWaypointResponse)

(defmethod rosplan_knowledge_msgs::RemoveWaypointRequest
  (:response () (instance rosplan_knowledge_msgs::RemoveWaypointResponse :init)))

(setf (get rosplan_knowledge_msgs::RemoveWaypointRequest :md5sum-) "bbfcda76036ebbe3d36caf7af80b260c")
(setf (get rosplan_knowledge_msgs::RemoveWaypointRequest :datatype-) "rosplan_knowledge_msgs/RemoveWaypointRequest")
(setf (get rosplan_knowledge_msgs::RemoveWaypointRequest :definition-)
      "string id
---


")

(setf (get rosplan_knowledge_msgs::RemoveWaypointResponse :md5sum-) "bbfcda76036ebbe3d36caf7af80b260c")
(setf (get rosplan_knowledge_msgs::RemoveWaypointResponse :datatype-) "rosplan_knowledge_msgs/RemoveWaypointResponse")
(setf (get rosplan_knowledge_msgs::RemoveWaypointResponse :definition-)
      "string id
---


")



(provide :rosplan_knowledge_msgs/RemoveWaypoint "bbfcda76036ebbe3d36caf7af80b260c")


