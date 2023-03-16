(in-package :pepper-demo)

(defvar ?target nil)

(defun look-at ()
(setq ?target (desig:an object
  (type object)
  (name "cube_GBCG")))
(let((?targettest ?target))
  (princ ?targettest)
  (top-level
    (with-process-modules-running (pepper-navigation)
      (let ((target (desig:a motion (type looking) (target ?targettest))))
         (pm-execute 'pepper-navigation target))))))