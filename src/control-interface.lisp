(in-package :pepper-demo)

;;(defvar *pepper-state* (make-fluent :name :pepper-state :value NoActvity) "current state of pepper")

;;(defvar *speaking-point-pub* nil "")

(defvar *chest-color-srv* nil "ROS service to set chest color")
(defvar *eye-color-srv* nil "ROS service to set eye color")
;;(defvar *ear-progress-srv* nil "ROS service to set ear progress")
(defvar *move-to-srv* nil "ROS service to move pepper to")


(defun init-ros-pepper()
    "Initialize ROS Communication"
  ;;(setf *speaking-point-pub* (advertise (format nil "speaking")"pepper_head_manager_msgs/PrioritizedPoint"))
    (setf *chest-color-srv* "/naoqi_driver/leds/fade_rgb") 
    (setf *eye-color-srv* "/naoqi_driver/leds/fade_rgb")
    ;;(setf *ear-progress-srv* "/naoqi_driver/leds/on")
    (setf *move-to-srv* "/naoqi_driver/motion/move_to") 
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
    "Function to call the SMoveTo service."
  (let 
  ((pose-message (roslisp:make-msg "geometry_msgs/PoseStamped"
    (frame_id header) "base_footprint"
    (x position pose)  x
    (y position pose)  y)))
  (call-service *move-to-srv* ' nao_interaction_msgs-srv:GoToPose
                :pose pose-message )
))
