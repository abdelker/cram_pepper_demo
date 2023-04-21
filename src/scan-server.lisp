(in-package :pepper-demo)

; (defparameter *point-stamped* (roslisp:make-msg "geometry_msgs/PointStamped"
;                                     (frame_id header) "base_footprint"
;                                     (stamp header) (ros-time)
;                                     (x point) 1
;                                     (y point) 0
;                                     (z point) 0.6))

(defparameter *head-scan-action-timeout* 5.0
  "How many seconds to wait before returning from head-scan action.")

(defvar *head-scan-action-client* nil)

(defun init-head-scan-action-client ()
  (setf *head-scan-action-client* (actionlib:make-action-client
                                   "head_scan_server/head_scan"
                                   "exp_pepper/HeadScanAction"))
  (loop until (actionlib:wait-for-server *head-scan-action-client* 5.0)
        do (roslisp:ros-info (head-scan-action-client) "Waiting for head-scan action server..."))
  (roslisp:ros-info (head-scan-action-client) "head-scan action client created.")
  *head-scan-action-client*)

(defun destroy-head-scan-action-client ()
  (setf *head-scan-action-client* nil))

(roslisp-utilities:register-ros-cleanup-function destroy-head-scan-action-client)

(defun get-head-scan-action-client ()
  (or *head-scan-action-client*
      (init-head-scan-action-client)))

(defparameter *point-stamped*
  (cl-transforms-stamped:make-point-stamped
   "base_footprint"
   0.0
   (cl-transforms:make-3d-vector 1.0d0 0.0d0 0.55d0)))
;    ;;(cl-transforms:make-quaternion 0.0d0 0.0d0 -1.0d0 0.0d0)

(defun make-head-scan-action-goal (point-stamped)
;;(let ((*point-stamped* point-stamped))
  (actionlib:make-action-goal
    (get-head-scan-action-client)
    ;;(roslisp:make-message 'exp_pepper-msg:HeadScanActionGoal
    :height  0.5
    :width  1
    :step_length  0.5
    ;;:duration_per_point
    :duration_per_point (roslisp:make-msg 'std_msgs-msg:duration (data) 6.0)
    :central_point
    (cl-transforms-stamped:to-msg 
    point-stamped)))
    

(defun ensure-head-scan-input-parameters (pose)
  (declare (type (or cl-transforms:3d-vector
                     cl-transforms:point cl-transforms-stamped:point-stamped
                     cl-transforms:pose cl-transforms-stamped:pose-stamped) pose))
  "Returns a point-stamped in base_footprint or given frame"
  (let ((frame (or (when (typep pose 'cl-transforms-stamped:pose-stamped)
                     (cl-transforms-stamped:frame-id pose))
                   ;;cram-tf:*robot-base-frame*
                   "base_footprint"
                   )))
    (cram-tf:ensure-point-in-frame
     (etypecase pose
       (cl-transforms:point ; also covers 3d-vector and point-stamped
        pose)
       (cl-transforms:pose          ; also covers pose-stamped
        (cl-transforms:origin pose)))
     frame)))

; (defun ensure-head-scan-goal-reached (status)
;  (when (eql status :timeout)
;    (roslisp:ros-warn (pepper-demo head-scan) "head-scan action timed out."))
;   (unless (eql status :succeeded)
;    (cpl:fail 'common-fail:head-scan-low-level-failure :description "head-scan action did not succeed."))
;   todo: would be nice to check if the point is actually visible from the
;   end configuration
;   using looking-at or point-head-at from cram_3d_world
;   )

(defun call-head-scan-action (&key (pose (cl-transforms:make-identity-pose))
                          (action-timeout *head-scan-action-timeout*))
  (declare (type (or cl-transforms:3d-vector
                     cl-transforms:point cl-transforms-stamped:point-stamped
                     cl-transforms:pose cl-transforms-stamped:pose-stamped) pose))                    
  ;  (let ((goal-point-stamped 
  ;         (ensure-head-scan-input-parameters
  ;             pose)))
   ;; (multiple-value-bind (result status)
        (cpl:with-failure-handling
            ((simple-error (e)
               (format t "Actionlib error occured!~%~a~%Reinitializing...~%~%" e)
               (init-head-scan-action-client)
               (cpl:retry)))
          (let ((actionlib:*action-server-timeout* 5.0))
            (actionlib:call-goal
             (get-head-scan-action-client)
             (make-head-scan-action-goal pose)
             :timeout action-timeout)))
             ;; (values result status)
      )

(defun scan-zone (n-times)
  (dotimes (n n-times)
    (call-head-scan-action :pose *point-stamped* :action-timeout *head-scan-action-timeout*)))
   ;; (cl-transforms:make-3d-vector 1.0 0.0 0.6))))