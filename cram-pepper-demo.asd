
(defsystem cram-pepper-demo
  :depends-on (
             :roslisp
	           :actionlib_msgs-msg
	           :actionlib
	           :geometry_msgs-msg
             :cl-transforms
	           :cram-language
             :cram-designators 
	           :cram-prolog
             :cram-process-modules 
	           :cram-language-designator-support
             :cram-executive 
	           :cram-cloud-logger
             :nao_interaction_msgs-srv
             :exp_pepper-msg
           ;;:cram-common-failure
             :resource_management_msgs-msg
             :knowledge_sharing_planner_msgs-msg
             :knowledge_sharing_planner_msgs-srv
             :mementar-msg
             :ontologenius-srv
             :ontologenius-msg
	           )

  :components
  ((:module "src"
            :components
            (
              (:file "package")
              (:file "control-interface" :depends-on ("package"))
              (:file "scan-server" :depends-on ("package"))
            ;;(:file "pepper-actions" :depends-on ("package" 
            ;;                                      "control-interface"))
              (:file "dt" :depends-on ("package"))

             )))
  )

