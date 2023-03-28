(in-package :pepper-demo)

;;navigation
(def-process-module pepper-navigation (motion-designator)
  (roslisp:ros-info (pepper-process-modules)
                    "pepper navigation invoked with motion designator `~a'."
                    motion-designator)
  (destructuring-bind (command motion) (reference motion-designator)
    (ecase command
     (look
             ( let (
                    (target (pepper-looking-motion-target motion)))
                   ;; (arm (pepper-looking-motion-arm motion))
               
              (let ((my-target-type (desig:desig-prop-value target :type)))

               (cond 
                ((string= my-target-type
                      :object)

                 (let ((obj (desig:desig-prop-value target :name)))
                    (print obj)
                    (look-object obj)))))))
             
             
             
     (move-to
            (let ((x  (pepper-moving-motion-x-val  motion))
                  (y  (pepper-moving-motion-y-val  motion)))
              (call-move-to-srv x y))))))            
             
  ;;commmunication           
(def-process-module pepper-communication (motion-designator)
 (roslisp:ros-info (pepper-process-modules)
                   "pepper navigation invoked with motion designator `~a'."
                   motion-designator)
 (destructuring-bind (command motion) (reference motion-designator)
   (ecase command         
    (speak
            
           (let ((sentence  (pepper-communication-motion-sentence motion)))
            (print sentence)
            (call-say-srv sentence))))))                  