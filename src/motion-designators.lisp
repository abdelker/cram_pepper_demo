(in-package :pepper-demo)


(defstruct pepper-looking-motion
  "Represents a looking motion"
  target
 ;; arm
)

(def-fact-group pepper-navigation-motion-designators (motion-grounding)
(<- (desig:motion-grounding ?desig (look ?motion))
    (desig-prop ?desig (:type :looking))
    (desig-prop ?desig (:target ?target))
    ;;(desig-prop ?desig (:arm ?arm))
    (lisp-fun make-pepper-looking-motion :target ?target ?motion)))