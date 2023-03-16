(in-package :pepper-demo)

(def-process-module pepper-navigation (motion-designator)
  (roslisp:ros-info (pepper-process-modules)
                    "pepper navigation invoked with motion designator `~a'."
                    motion-designator)
  (destructuring-bind (command motion) (reference motion-designator)
    (ecase command
(look
        ( let (
               (target (pepper-looking-motion-target motion))
              ;; (arm (pepper-looking-motion-arm motion))
               )
         (let ((my-target-type (desig:desig-prop-value target :type)))

          (cond 
          ((string= my-target-type
                :object)

          (let ((obj (desig:desig-prop-value target :name)))
             (print obj)
             (lookObject obj))))
             
             ))))))