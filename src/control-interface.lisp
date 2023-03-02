(in-package :pepper-demo)

;;(defvar *pepper-state* (make-fluent :name :pepper-state :value NoActvity) "current state of pepper")

;;(defvar *speaking-point-pub* nil "")

(defvar *chest-color-srv* nil "ROS service to set chest color")


(defun init-ros-pepper()
    "Initialize ROS Communication"
  ;;(setf *speaking-point-pub* (advertise (format nil "speaking")"pepper_head_manager_msgs/PrioritizedPoint"))
    (setf *chest-color-srv* "/naoqi_driver/leds/fade_rgb") 
)

;;(roslisp:call-service "/naoqi_driver/leds/fade_rgb" 'nao_interaction_msgs-srv:LedsFadeRGB :name "ChestLeds" :color_name "red")

(defun call-chest-color-srv (color)
    "Function to call the SetChestColor service."
    (call-service *chest-color-srv* ' nao_interaction_msgs-srv:LedsFadeRGB
                :name "ChestLeds"
                :color_name color)
)

;;(defun send-speaking-point()
;;    ""
;;    (publish *speaking-point-pub* (make-message "pepper_head_manager_msgs/PrioritizedPoint" :data ))
;;)