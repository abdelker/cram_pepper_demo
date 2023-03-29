(in-package :pepper-demo)

;;publisher
(defvar *speaking-point-pub* nil "ROS publisher")
(defvar *env-point-pub* nil "ROS publisher")
(defvar *pointAt-right-pub* nil "ROS publisher")
(defvar *pointAt-left-pub* nil "ROS publisher")
(defvar *neutral-right-pub* nil "ROS publisher")
(defvar *neutral-left-pub* nil "ROS publisher")
(defvar *speechToText-sub* nil "ROS subscriber")
;;(defvar selected-arm nil)
(defvar *current-state* nil)

(defun init-ros-dt-pepper ()
  (setf *speaking-point-pub* (advertise "/pepper_head_manager/speaking/pepper_head_manager_msgs1_PrioritizedPoint"
                              "pepper_head_manager_msgs/PrioritizedPoint"))
  (setf *env-point-pub* (advertise "/pepper_head_manager/env_monitoring/pepper_head_manager_msgs1_PrioritizedPoint"
                         "pepper_head_manager_msgs/PrioritizedPoint"))
  (setf *pointAt-right-pub* (advertise "/pepper_arm_manager_right/social/pepper_arm_manager_msgs1_PrioritizedPoint"
                             "pepper_head_manager_msgs/PrioritizedPoint"))
  (setf *neutral-left-pub* (advertise "/pepper_arm_manager_left/social/pepper_arm_manager_msgs1_PrioritizedPoint"
                            "pepper_head_manager_msgs/PrioritizedPoint"))
  (setf *pointAt-right-pub* (advertise "/pepper_arm_manager_right/manipulation/pepper_arm_manager_msgs2_PrioritizedJointTrajectory"
                             "pepper_head_manager_msgs/PrioritizedJointTrajectory"))
  (setf *pointAt-left-pub* (advertise "/pepper_arm_manager_left/manipulation/pepper_arm_manager_msgs2_PrioritizedJointTrajectory"
                            "pepper_head_manager_msgs/PrioritizedJointTrajectory"))
  ; (setf *speechToText-sub* (subscribe "ros_stt/said" "std_msgs/String"
  ;                                     #'listenningDesignate)) 
  ;;(init-speaking-buffer)
  (setq *current-state* nil)
  (set-state :no-activity))
;;;;;;;;;;;;;;ui-ontology-code;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (defun check-onto ()
;     (dt::update-cube-list)
;     (cond ((> (length dt::*cubes*) 1)
;         (pepper-state :ready))
;         ((progn 
;             ())))
; )
  
(defun pepper-state (state)
  (ecase state
             (:ready 0)
             (:scanning 1)
             (:in-progress 2)
             (:in-help 3)
             (:no-activity 4)
             (:listening 5))) 

(defun pepper-goal (goal)
  (ecase goal
             (:waiting-human-1 0)
             (:look-at-cube 1)
             (:waiting-human 2)
             (:look-at-exp 3)
             (:look-at-cube-2 4)
             (:idle 5))) 

(defun set-state(state)
      (cond ((and (not (eql *current-state* :listening))
                  (not (eql state :no-activity)))
             (setq *current-state* state))
           ( (cond ((eql state :no-activity)
                    (call-chest-color-srv "white"))
                  ((eql state :in-progress)
                   (call-chest-color-srv "blue"))
                  ((eql state :ready)
                   (call-chest-color-srv "green"))
                  ((eql state :scanning)
                   (call-chest-color-srv "yellow"))
                  ((eql state :in-help)
                   (call-chest-color-srv "yellow"))
                  ((eql state :listening)
                   (call-chest-color-srv "green"))))
           ((eql state :no-activity)
            (progn 
                  (setq *current-state* state)
                  (call-chest-color-srv "white")))))
;;(pepper-state state))

(defun point-at-object (object-name)
  "Function to point at Object"
  (princ "point at :")
  (princ object-name)
  (cond
   ((string= object-name nil)
    (princ "no cube to point at")))
    ;;(return nil)
    
  (let ((point-message (roslisp:make-msg "geometry_msgs/PointStamped"
                                         (frame_id header)
                                         object-name
                                         (stamp header)
                                         (ros-time))))
       (setq selected-arm (selectArm object-name))
    (cond
     ((string= selected-arm "left")
      (publish *pointAt-left-pub*
               (make-message "pepper_head_manager_msgs/PrioritizedPoint"
                             :priority 1 :data point-message)))
               
     ((string= selected-arm "right")
      (publish *pointAt-right-pub*
               (make-message "pepper_head_manager_msgs/PrioritizedPoint"
                             :priority 1 :data point-message))))))
               
   ;;  ((return nil))
     
     ;;(pointAt "social" selected-arm)
     ;;(return t)
     

(defun select-arm (cube-name)
 (let (( new-pose (transform-pose cube-name "base_footprint"))
       (selected-arm "left"))))
     

(defun transform-pose (from-frame to-frame stamp)
   (cl-transforms-stamped:lookup-transform cram-tf:*transformer* 
    to-frame from-frame :timeout 10.0))
  


(defun init-tf ()

  (setf cram-tf:*tf-default-timeout* 10.0)
  (setf cram-tf:*tf-broadcasting-enabled* t)
  (setf cram-tf:*transformer* (make-instance 'cl-tf2:buffer-client)))


(roslisp-utilities:register-ros-init-function init-tf)


;;speechToText-cb
; (defun listenningDesignate (sentences)
;   "Callback for speechToText."
;   (princ (format nil "phrases recu: ~a" sentences))
;   (setf (value *avatar-pose*) msg))


(defun look-object (object-name)
  "Function to look at Object"
       (let 
                ((point-message (roslisp:make-msg "geometry_msgs/PointStamped"
                                                                      (frame_id header) object-name
                                                                      (stamp header) (ros-time)))
                 (priority-message (roslisp:make-msg "resource_management_msgs/MessagePriority"
                                               :value 1)))
        (publish *env-point-pub* (roslisp:make-msg "pepper_head_manager_msgs/PrioritizedPoint" 
                                               :priority priority-message :data point-message))
        (look-at "env_monitoring")))
  

(defun init-speaking-buffer ()
      (let 
            ((point-message (roslisp:make-msg "geometry_msgs/PointStamped"
                                    (frame_id header) "base_footprint"
                                    (stamp header) (ros-time)
                                    (x point) 1
                                    (y point) 1.5
                                    (z point) 1.7))
             (priority-message (roslisp:make-msg "resource_management_msgs/MessagePriority"
                                     :value 1)))
       (publish *speaking-point-pub* (roslisp:make-msg "pepper_head_manager_msgs/PrioritizedPoint") 
                                     :priority priority-message :data point-message)))
      
