(in-package :pepper-demo)

;;publisher
(defvar *speaking-point-pub* nil "ROS publisher")
(defvar *env-point-pub* nil "ROS publisher")
(defvar *pointAt-right-pub* nil "ROS publisher")
(defvar *pointAt-left-pub* nil "ROS publisher")
(defvar *neutral-right-pub* nil "ROS publisher")
(defvar *neutral-left-pub* nil "ROS publisher")
(defvar *speechToText-sub* nil "ROS subscriber")

(defun init-ros-dt-pepper ()

(setf *speaking-point-pub* (advertise "/pepper_head_manager/speaking/pepper_head_manager_msgs1_PrioritizedPoint")
    "pepper_head_manager_msgs/PrioritizedPoint")
(setf *env-point-pub* (advertise "/pepper_head_manager/env_monitoring/pepper_head_manager_msgs1_PrioritizedPoint")
    "pepper_head_manager_msgs/PrioritizedPoint")
(setf *pointAt-right-pub* (advertise "/pepper_arm_manager_right/social/pepper_arm_manager_msgs1_PrioritizedPoint")
    "pepper_head_manager_msgs/PrioritizedPoint")
(setf *neutral-left-pub* (advertise "/pepper_arm_manager_left/social/pepper_arm_manager_msgs1_PrioritizedPoint")
    "pepper_head_manager_msgs/PrioritizedPoint")
(setf *pointAt-right-pub* (advertise "/pepper_arm_manager_right/manipulation/pepper_arm_manager_msgs2_PrioritizedJointTrajectory")
    "pepper_head_manager_msgs/PrioritizedJointTrajectory")
(setf *pointAt-left-pub* (advertise "/pepper_arm_manager_left/manipulation/pepper_arm_manager_msgs2_PrioritizedJointTrajectory")
    "pepper_head_manager_msgs/PrioritizedJointTrajectory")
(setf *speechToText-sub* (subscribe "ros_stt/said" "std_msgs/String"
                              #'listenningDesignate))    
)

;;speechToText-cb
(defun listenningDesignate (sentences)
  "Callback for speechToText."
  (princ (format nil "phrases recu: ~a" sentences))
  (setf (value *avatar-pose*) msg)
  )


  (defun lookObject (object-name)
  "Function to .."
  (let 
  ((point-message (roslisp:make-msg "geometry_msgs/PointStamped"
    (frame_id header) object-name
    (stamp header) (ros-time))))
  (publish *env-point-pub* (make-message "pepper_head_manager_msgs/PrioritizedPoint" 
  :priority 1)
  :data point-message)
  (lookAt("env_monitoring")))
 )