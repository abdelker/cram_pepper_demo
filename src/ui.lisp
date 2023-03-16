(in-package :pepper-demo)

(defun designateCubeui (sentences)
  (princ "callback ui :")
  (princ sentences)
  (terpri)
  (multiple-value-bind (state result action)
      (designateCube sentences)
    (cond
     ((string= action "Remove")
      (impossible-Take))
     ((string= action "Take")
      (impossible-Take)))
    (cond
     ((state)
      (progn
        (princ "one cube find :")
        (princ result))))))

(defun testfail ()
  (handler-case 
    (call-service "/ontologenius/"
                'ontologenius-srv:OntologeniusService
                :action "add"
                :param "human_0"
                )
   
    (roslisp::ros-rpc-error () 
    (cond
    ((= (+ 3 4) 8)
    (print "failed to connect"))

    ((= (+ 3 4) 7)
    (print "other cond"))

   ;; (simple-error () (print "Cannot connect to container"))
  )
)))
