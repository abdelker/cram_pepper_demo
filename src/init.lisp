(in-package :pepper-demo)

(defun init ()
  (start-ros-node "cram_pepper_demo")
  (init-ros-dt)
  (init-ros-pepper)
  (init-ros-dt-pepper))