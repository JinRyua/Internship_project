
(cl:in-package :asdf)

(defsystem "Display-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "display_msg" :depends-on ("_package_display_msg"))
    (:file "_package_display_msg" :depends-on ("_package"))
  ))