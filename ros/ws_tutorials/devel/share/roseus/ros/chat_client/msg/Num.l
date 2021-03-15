;; Auto-generated. Do not edit!


(when (boundp 'chat_client::Num)
  (if (not (find-package "CHAT_CLIENT"))
    (make-package "CHAT_CLIENT"))
  (shadow 'Num (find-package "CHAT_CLIENT")))
(unless (find-package "CHAT_CLIENT::NUM")
  (make-package "CHAT_CLIENT::NUM"))

(in-package "ROS")
;;//! \htmlinclude Num.msg.html


(defclass chat_client::Num
  :super ros::object
  :slots (_pub _str ))

(defmethod chat_client::Num
  (:init
   (&key
    ((:pub __pub) "")
    ((:str __str) "")
    )
   (send-super :init)
   (setq _pub (string __pub))
   (setq _str (string __str))
   self)
  (:pub
   (&optional __pub)
   (if __pub (setq _pub __pub)) _pub)
  (:str
   (&optional __str)
   (if __str (setq _str __str)) _str)
  (:serialization-length
   ()
   (+
    ;; string _pub
    4 (length _pub)
    ;; string _str
    4 (length _str)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _pub
       (write-long (length _pub) s) (princ _pub s)
     ;; string _str
       (write-long (length _str) s) (princ _str s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _pub
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _pub (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _str
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _str (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get chat_client::Num :md5sum-) "eaf759e25d19bdc5a284d26603fbb1c8")
(setf (get chat_client::Num :datatype-) "chat_client/Num")
(setf (get chat_client::Num :definition-)
      "string pub
string str

")



(provide :chat_client/Num "eaf759e25d19bdc5a284d26603fbb1c8")


