(in-package :pepper-demo)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun take-cube-sentence ()
 (let ((cube (dt::get-current-cube-verbalization)))
  (say-take-cube cube)))






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar ?target nil)

(defun init-pepper ()
  ;;(start-ros-node "cram_pepper_demo")
  ;;(init-ros-dt)
  (init-list-discourse)
  (init-ros-pepper)
  (init-ros-dt-pepper))




(defun demo ()
 (setq ?target (desig:an object
                (type object)
                (name "cube_BBTG")))
 (let((?targettest ?target))
   (princ ?targettest)
   (top-level
     (with-process-modules-running (pepper-navigation)
       (let ((target (desig:a motion (type looking) (target ?targettest))))
          (pm-execute 'pepper-navigation target))))))


(defun demo-moveto ()
 (let((?x -0.25) (?y 0))
   (top-level
     (with-process-modules-running (pepper-navigation)
       (let ((target (desig:a motion (type moving) (x-val ?x) (y-val ?y))))
          (pm-execute 'pepper-navigation target))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun demo-greet ()
 (let ((?sentence (take-cube-sentence)) (?place (cl-transforms:make-3d-vector 0.25 0.0 0)))
  (top-level
    (with-process-modules-running (pepper-navigation pepper-communication)
      (exe:perform (desig:an action (type greeting) (:greeting-speech ?sentence) (:greeting-place ?place)))))))


(defun greet-human (&key ((:greeting-speech ?sentence)) ((:greeting-place ?place)) &allow-other-keys)

        (exe:perform (desig:an action (type moving) (:to ?place)))
       (exe:perform (desig:an action (type speaking) (:speech ?sentence))))

(defun move-to (&key ((:to ?place)) &allow-other-keys)
    (let ((?x (float (cl-transforms:x ?place) 1.0)) 
          (?y (float (cl-transforms:y ?place) 1.0)))
     (pm-execute 'pepper-navigation  (desig:a motion (type moving) (:x-val ?x) (:y-val ?y)))))
        
(defun speak (&key ((:speech ?sentence)) &allow-other-keys)
;  (let ((?text-to-speak ?sentence))
;       (print ?text-to-speak)
      (pm-execute 'pepper-communication (desig:a motion (type speaking) (:sentence ?sentence))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun demo-dt ()
 (start-ros-node "cram_pepper_demo_ros_node")
 (init-tf)
 (init-pepper)
 ;;(init-dt-pepper)
 ;;(init-list-discourse)
 ;;(dt::add-human
 (dt::init-dt "pepper" "eng")  
 (dt::construct-you-agent-desig "human_0"))
  ;;(princ ">>>changing context")(terpri)
 ;;(change-context)
 ;;(i-restart))
 
 



(defun i-scanning ()
 (look-at)
 (check-onto))


(defun i-restart ()
 (i-scanning)
 (dt::update-cube-list)
 (princ "---> RESTART")(terpri)
 (princ dt::*cubes*)(terpri))

(defun i-perform-dt-step ()

 (let ((response-disambiguate-srv (dt::disambiguate-cube dt::*current-cube*)))
      (setq *sparql-result* (msg-slot-value response-disambiguate-srv :SPARQLRESULT))
      (setq *ambiguous* (msg-slot-value response-disambiguate-srv :AMBIGUOUS)))
 (let ((response-verbalize-srv (dt::call-verbalize-srv *sparql-result*)))
      (setq *verbalization* (msg-slot-value response-verbalize-srv :VERBALIZATION)))
                                
 (say (say-take-cube *verbalization*)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;demo listening

; (defun demo-greet ()
;  (let ((?sentence (say-hello)) (?place (cl-transforms:make-3d-vector 0.25 0.0 0)))
;   (top-level
;     (with-process-modules-running (pepper-navigation pepper-communication)
;       (exe:perform (desig:an action (type listening) (:understand ?interaction-desig)))))))


;;;;;; demo point at

; (defun speak (&key ((:speech ?sentence)) &allow-other-keys)
; ;  (let ((?text-to-speak ?sentence))
; ;       (print ?text-to-speak)
;       (pm-execute 'pepper-communication (desig:a motion (type speaking) (:sentence ?sentence))))


; (defun point (&key ((:at ?object-designator)) ((:arm ?selected-arm)) &allow-other-keys)
;  (let ((object ?object-designator) (arm ?selected-arm))
;       (exe:perform (desig:an action (type pointing) (:at object) (:arm arm)))))
(defun test-mo ()
 (top-level
      (with-process-modules-running (pepper-navigation)
       (pm-execute 'pepper-navigation  (desig:a motion (type testing))))))

(defun test-int ()
 (top-level
      (with-process-modules-running (process-input)
       (pm-execute 'process-input (desig:an interaction (type understanding) (:input "the cube") (:context nil))))))

(defun test-int-c ()
 (let ((?ctx (dt::reset-context)))
  (write-line (format nil "the context is:~a" ?ctx))
  (top-level
       (with-process-modules-running (process-input)
        (pm-execute 'process-input (desig:an interaction (type understanding) (:input "the cube") (:context ?ctx)))))))


(defun test-you-int ()
 (dt::reset-context)
 (write-line "what is your agent name?")
 (let ((?agent-name (read)))
  (write-line "what do you want?")
  (let ((?message (read)))
   (top-level
        (with-process-modules-running (listening)
         (pm-execute 'listening (desig:an interaction (type receiving) (:from-agent ?agent-name) (:with-content ?message))))))))


(defparameter *count* 0)
(defparameter *mvt-duration* 3)
(defparameter *agent-state* "in-progress")
(defparameter *agent-goal* nil)
(defparameter *current-cube* (desig:an object
                              (type object)
                              (name "cube_BGCG")))
                  
;;demo

; (defun demo ()
;  (setq ?target (desig:an object
;                 (type object)
;                 (name "cube_BBTG")))
;  (let((?targettest ?target))
;    (princ ?targettest)
;    (top-level
;      (with-process-modules-running (pepper-navigation)
;        (let ((target (desig:a motion (type looking) (target ?targettest))))
;           (pm-execute 'pepper-navigation target))))))

;  (defun speak (&key ((:speech ?sentence)) &allow-other-keys)
; ;  (let ((?text-to-speak ?sentence))
; ;       (print ?text-to-speak)
;       (pm-execute 'pepper-communication (desig:a motion (type speaking) (:sentence ?sentence))))         

;;dt actions
(defun look-at (&key ((:at ?object-desig)) &allow-other-keys)
 (write-line "Performing Action : Looking")
 (let ((?object ?object-desig))
  (pm-execute 'pepper-navigation  (desig:a motion (type looking) (:target ?object)))))

(defun wait-for-agent (&key ((:for ?agent-desig)) &allow-other-keys)
 (let ((?agent ?agent-desig))
  (write-line (format nil "Performing Action : Waiting for ~a" ?agent))))


(defun init-dt-demo ()
 (top-level
      (with-process-modules-running (pepper-navigation)
       (exe:perform (desig:an action (type monitoring) (:task "dt"))))))

(defun monitor-dt-task (&key ((:task ?dt)) &allow-other-keys)
 (occasions-events:on-event (make-instance 'dt-event-detecting-human :you-agent dt::*you-agent-desig*))
 (roslisp:loop-at-most-every 1  (occasions-events:on-event (make-instance 'monitor))))


(defun reset-goal ()

;;set goal/event to WaitingHuman1
 (occasions-events:on-event (make-instance 'dt-event-detecting-human :you-agent dt::*you-agent-desig*)))

;;event classes for goals

(defclass monitor (occasions-events:event) ())


(defclass dt-event-detecting-human (occasions-events:event)  
 ((detected-agent
   :initarg :you-agent
   :reader you-agent
   :initform nil)))


(defclass dt-event-instructing-human (occasions-events:event) 
 ((the-current-cube
    :initarg :current-cube
    :reader current-cube
    :initform nil)))


(defclass dt-event-waiting-for-human (occasions-events:event) ())


(defclass dt-event-looking-at-cube (occasions-events:event) ())

;; event classes for cube takes

(defclass dt-event-detecting-wrong-cube-take (occasions-events:event)
 ((no-cube-taken
   :initarg :no-take 
   :reader no-take
   :initform nil)))


(defclass dt-event-detecting-good-cube-take  (occasions-events:event) ())


;;event-handlers

(defmethod occasions-events:on-event ((occasions-events:event monitor))
 (write-line "I am monitoring.")
 (cond ((string= *agent-state* "in-progress")
        (progn 
         (setf *count* (+ *count* 1))
        
         (ecase *agent-goal*
          (:wait-for-human1 (cond ((>= *count* (+ *mvt-duration* 2))
                                   (progn 
                                          (setf *count* 0)
                                          ;;(setf *agent-goal* :look-at-cube1)
                                          (occasions-events:on-event (make-instance 'dt-event-instructing-human :current-cube *current-cube*))))))
          (:look-at-cube1 (cond ((>= *count* (+ *mvt-duration* 2))
                                 (progn 
                                        (setf *count* 0)
                                        ;;(setf *agent-goal* :wait-for-human2) 
                                        (occasions-events:on-event (make-instance 'dt-event-waiting-for-human))))))
                                        
                                        
          (:wait-for-human2 (cond ((>= *count* (+ *mvt-duration* 2))
                                   (progn 
                                          (setf *count* 0)
                                          ;;(setf *agent-goal* :look-at-cube2)  
                                          (occasions-events:on-event (make-instance 'dt-event-instructing-human)))))))))
               

  ((reset-goal))))


(defmethod occasions-events:on-event ((occasions-events:event dt-event-detecting-human))
 (write-line "Current event: detecting-human and current goal: :wait-for-human1")
 (let ((?you-agent (you-agent occasions-events:event)))(princ ?you-agent)
  (exe:perform (desig:an action (type waiting) (:for ?you-agent))))
 (setf *agent-goal* :wait-for-human1))

(defmethod occasions-events:on-event ((occasions-events:event dt-event-instructing-human))
 (write-line "Current event: instructing-human and current goal: :look-at-cube1")
 (let ((?current-cube (current-cube occasions-events:event)))(princ ?current-cube)
  (exe:perform (desig:an action (type looking) (:at ?current-cube))))
 (setf *agent-goal* :look-at-cube1))

(defmethod occasions-events:on-event ((occasions-events:event dt-event-waiting-for-human))
 (write-line "Current event: waiting-for-human and current goal: :wait-for-human2")
;  (cond ((>= *count* (+ *mvt-duration* 2))
;         (progn 
;                (setf *count* 0)
; ;;(perform lookobject)
;          (occasions-events:on-event (make-instance 'waiting-for-human2))))))
 (setf *agent-goal* :wait-for-human2))


; (defmethod occasions-events:on-event ((occasions-events:event waiting-for-human2))
;  (write-line "I am waiting now for human2")
;  (cond 
;   ((eql *count* *mvt-duration*))
;    ;(perform sayWaiting))
   
;   ((>= *count* (+ *mvt-duration* 2))
;   ;; (perform lookObject)
;    (occasions-events:on-event (make-instance 'looking-at-cube2)))))


; (defmethod occasions-events:on-event ((occasions-events:event looking-at-cube2))
;  (write-line "I am looking now at cube2")
;  (cond ((>= *count* (+ *mvt-duration* 2))
;         (progn 
;          (setf *count* 0)
; ;;(perform lookobject)))
;          (occasions-events:on-event (make-instance 'wrong-cube-take :no-take t))))))


; ; ;; event-handlers for cube takes

; (defmethod occasions-events:on-event ((occasions-events:event wrong-cube-take))
; ;;(perform lookAt)
;  (cond 
;   ((eql (no-take event) t))))
;    ;(perfom sayNoCubeTake))
   
;    ;(perform sayWaiting))
   
;  ;; ((perform sayWrongCubeTake))
;   ;; (perform lookObject)
;   ;; (perform lookExperimentator)
;   ;; (perform pointAt)
; ;;   (perform sayhelp)
;   ;; (occasions-events:on-event (make-instance 'looking-at-cube2)))))