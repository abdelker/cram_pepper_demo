(in-package :pepper-demo)


(defstruct pepper-looking-motion
  "Represents a looking motion"
  target
 ;; arm
)

(defstruct pepper-moving-motion
  "Represents a moving motion"
  x
  y
)

(defstruct pepper-scanning-motion
  "Represents a moving motion"
  x
  y
  z
)

(def-fact-group pepper-navigation-motion-designators (motion-grounding)
(<- (desig:motion-grounding ?desig (look ?motion))
    (desig-prop ?desig (:type :looking))
    (desig-prop ?desig (:target ?target))
    ;;(desig-prop ?desig (:arm ?arm))
    (lisp-fun make-pepper-looking-motion :target ?target ?motion))

(<- (desig:motion-grounding ?desig (move-to ?motion))
    (desig-prop ?desig (:type :moving))
    (desig-prop ?desig (:x ?x))
    (desig-prop ?desig (:y ?y))
    (lisp-fun make-avatar-motion :x ?x :y ?y ?motion))
    
(<- (desig:motion-grounding ?desig (scan ?motion))
    (desig-prop ?desig (:type :scanning))
    (desig-prop ?desig (:x ?x))
    (desig-prop ?desig (:y ?y))
    (desig-prop ?desig (:z ?z))
    (lisp-fun make-avatar-motion :x ?x :y ?y :z ?z ?motion))    
    )

(defstruct pepper-communication-motion
  "Represents a moving motion"
  sentence
)

(def-fact-group pepper-communication-motion-designators (motion-grounding)  
  (<- (desig:motion-grounding ?desig (say ?motion))
      (desig-prop ?desig (:type :saying))
      (desig-prop ?desig (:sentence ?sentence))
      (lisp-fun make-avatar-motion :sentence ?sentence ?motion)
      ))
  