(in-package :pepper-demo)

;;(defvar *buffer-list* nil "Buffer List")
;;(defvar *value-list* nil "Buffer List")

;;PRIORITIZE 3
;;INHIBIT -1
;;BACKGROUND 0

(defun say (text &optional (sleep-time 1) (neutral-pose t) (no-move f))
 (cond 
  ((no-move)
    (call-say-no-move-srv text))
  
  ((call-say-srv text)))
  (sleep sleep-time)

  (cond 
  ((neutral-pose)
    (sleep sleep-time))))

(defun look-at (&optional (buffer-name nil))
  (let ((*buffer-list* (vector  "speaking" "env_monitoring" "human_monitoring")))
 ;;(look-at "env_monitoring")
    (cond 
    ((string= buffer-name "speaking")  
                
      (progn 
        (let ((*value-list* (vector  3 -1 0)))
        (send-prio-info *buffer-list* *value-list*)
        ))) 
    
    ((string= buffer-name "env_monitoring")  
                
      (progn 
        (let ((*value-list* (vector  -1 3 0)))
        (send-prio-info *buffer-list* *value-list*)
        ))) 

    ((progn 
        (let ((*value-list* (vector  -1 -1 0)))
        (send-prio-info *buffer-list* *value-list*)
        )))        
   ;; ((princ "try again"))
    )
    )
    )  

#| (defun pointAt(buffer-name selected-arm)

    (cond 
    ((string= selected-arm nil)  
                
      (progn 
        (let (((*buffer-list* (vector  "social" "manipulation")))
        ((*value-list* (vector  -1 3))))
        (send-prio-arm-right-info *buffer-list* *value-list*)
        (send-prio-arm-left-info *buffer-list* *value-list*)
        ))) 
  ;; ((let (((*buffer-list* (vector  "social" "manipulation")))

    )) |#
    
    
