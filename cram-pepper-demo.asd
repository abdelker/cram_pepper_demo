
(defsystem cram-pepper-demo
  :depends-on (:roslisp
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
	           )

  :components
  ((:module "src"
            :components
            ((:file "package")            
             )))
  )

