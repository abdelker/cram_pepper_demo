(in-package :pepper-demo)

(defvar buffer-list nil "Buffer List")
(defvar value-list nil "Value List")

;;PRIORITIZE 3
;;INHIBIT -1
;;BACKGROUND 0

(defun say (text &optional (sleep-time 1) (neutral-pose t) (no-move nil))
 (cond 
  ((eq no-move t)
   (call-say-no-move-srv text))
  
  ((call-say-srv text)))
 (sleep sleep-time)

 (cond 
  ((eql neutral-pose t)
   (sleep sleep-time))))

(defun look-at (&optional (buffer-name nil))
  (let ((buffer-list (vector  "speaking" "env_monitoring" "human_monitoring")))
 ;;(look-at "env_monitoring")
    (cond 
     ((string= buffer-name "speaking")  
                
      (progn 
        (let ((value-list (vector  3 -1 0)))
         (send-prio-info buffer-list value-list))))
         
    
     ((string= buffer-name "env_monitoring")  
                
      (progn 
        (let ((value-list (vector  -1 3 0)))
         (send-prio-info buffer-list value-list))))
         

     ((progn 
         (let ((value-list (vector  -1 -1 0)))
          (send-prio-info buffer-list value-list)))))))
                
   ;; ((princ "try again"))
    
    
      

(defun point-at (&optional (buffer-name nil) (selected-arm nil))

  (let ((buffer-list (vector  "social" "manipulation")) 
        (value-list-no (vector  -1 -1)))
 ;;(look-at "env_monitoring")
    (cond 
     ((eql selected-arm nil)  
                
      (progn 
        (setf value-list (vector  -1 3))
        (send-prio-arm-right-info buffer-list value-list)
        (send-prio-arm-left-info buffer-list value-list))))
         
    
    (cond 
      ((string= buffer-name "social")  
                
       (setf value-list (vector  3 -1)))
        

      ((string= buffer-name "manipulation")  
         
       (setf value-list (vector  -1 3)))
         
      ((setf value-list (vector  -1 -1))))

    (cond
      
     ((string= selected-arm "left")
      (progn 
      (princ "i am here")
       (send-prio-arm-right-info buffer-list value-list-no)
       (send-prio-arm-left-info buffer-list value-list)))
      
      
     ((progn 
       (send-prio-arm-right-info buffer-list value-list)
       (send-prio-arm-left-info buffer-list value-list-no))))))
      
      
      
        
    
    
