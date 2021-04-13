;; Auto-generated. Do not edit!


(when (boundp 'Display::display_msg)
  (if (not (find-package "DISPLAY"))
    (make-package "DISPLAY"))
  (shadow 'display_msg (find-package "DISPLAY")))
(unless (find-package "DISPLAY::DISPLAY_MSG")
  (make-package "DISPLAY::DISPLAY_MSG"))

(in-package "ROS")
;;//! \htmlinclude display_msg.msg.html


(defclass Display::display_msg
  :super ros::object
  :slots (_msg ))

(defmethod Display::display_msg
  (:init
   (&key
    ((:msg __msg) "")
    )
   (send-super :init)
   (setq _msg (string __msg))
   self)
  (:msg
   (&optional __msg)
   (if __msg (setq _msg __msg)) _msg)
  (:serialization-length
   ()
   (+
    ;; string _msg
    4 (length _msg)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _msg
       (write-long (length _msg) s) (princ _msg s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _msg
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _msg (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get Display::display_msg :md5sum-) "7d96ed730776804754140b85e64c862e")
(setf (get Display::display_msg :datatype-) "Display/display_msg")
(setf (get Display::display_msg :definition-)
      "string msg

")



(provide :Display/display_msg "7d96ed730776804754140b85e64c862e")


