
(cl:in-package :asdf)

(defsystem "rosplan_dispatch_msgs-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "ParsingService" :depends-on ("_package_ParsingService"))
    (:file "_package_ParsingService" :depends-on ("_package"))
    (:file "PlanningService" :depends-on ("_package_PlanningService"))
    (:file "_package_PlanningService" :depends-on ("_package"))
    (:file "ProblemService" :depends-on ("_package_ProblemService"))
    (:file "_package_ProblemService" :depends-on ("_package"))
  ))