(in-package :pepper-demo)

;;(init-ros-pepper)

;;(defvar *pepper-state* (make-fluent :name :pepper-state :value NoActvity) "current state of pepper")

;;(defvar *speaking-point-pub* nil "")

(defvar *chest-color-srv* nil "ROS service to set chest color")
(defvar *eye-color-srv* nil "ROS service to set eye color")
;;(defvar *ear-progress-srv* nil "ROS service to set ear progress")
(defvar *move-to-srv* nil "ROS service to move")
(defvar *neutral-pose-srv* nil "ROS service set neutral pose")
(defvar *prio-pub* nil "prio ROS publisher")

;;test parameters for pub PrioSetter

 (defparameter
                 
                 *buffer-list* (make-sequence '(vector string) 
   3
   :initial-element "speaking"))

    (defparameter
                 
                 *value-list* (make-sequence '(vector integer) 
   3
   :initial-element 1))



(defun init-ros-pepper()
    "Initialize ROS Communication"
  ;;(setf *speaking-point-pub* (advertise (format nil "speaking")"pepper_head_manager_msgs/PrioritizedPoint"))
    (setf *chest-color-srv* "/naoqi_driver/leds/fade_rgb") 
    (setf *eye-color-srv* "/naoqi_driver/leds/fade_rgb")
    ;;(setf *ear-progress-srv* "/naoqi_driver/leds/on")
    (setf *move-to-srv* "/naoqi_driver/motion/move_to") 
    (setf *neutral-pose-srv* "/naoqi_driver/motion/neutral")
    (setf *prio-pub* (advertise (format nil "/pepper_head_manager/set_priorities")"resource_management_msgs/PrioritiesSetter")) 
)

;;fade service
(defun call-chest-color-srv (color)
    "Function to call the SetChestColor service."
    (call-service *chest-color-srv* ' nao_interaction_msgs-srv:LedsFadeRGB
                :name "ChestLeds"
                :color_name color)
)

;;fade service
(defun call-eye-color-srv (color)
    "Function to call the SetEyeColor service."
    (call-service *eye-color-srv* ' nao_interaction_msgs-srv:LedsFadeRGB
                :name "FaceLeds"
                :color_name color)
)

;;on service
;;(defun call-ear-progress-srv (color)
  ;;  "Function to call the SetEarProgress service."
    ;;(call-service *ear-progress-srv* ' nao_interaction_msgs-srv:String
      ;;          :name "EarLeds"
        ;;        :color_name color)
;;)

;;nav service
(defun call-move-to-srv (x y)
    "Function to call the MoveTo service."
  (let 
  ((pose-message (roslisp:make-msg "geometry_msgs/PoseStamped"
    (frame_id header) "base_footprint"
    (x position pose)  x
    (y position pose)  y)))
  (call-service *move-to-srv* ' nao_interaction_msgs-srv:GoToPose
                :pose pose-message )
))


;;neutral service
(defun call-neutral-pose-srv ()
    "Function to call the NeutralPose service."
  (call-service *neutral-pose-srv* ' std_srvs-srv:Empty )
)


    (defun send-prio-info (buffer-list value-list)
  "Function to send prio info"
  (publish *prio-pub* (make-message "resource_management_msgs/PrioritiesSetter"
    :buffers buffer-list
    :values value-list
    )))

