
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
             ;;:pepper_head_manager_msgs-msg
             :nao_interaction_msgs-srv
	           )

  :components
  ((:module "src"
            :components
            (
              (:file "package")
              (:file "control-interface" :depends-on ("package"))

             )))
  )

