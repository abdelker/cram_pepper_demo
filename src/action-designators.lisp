(in-package :pepper-demo)

(def-fact-group pepper-action-designators (action-grounding) 

;;looking at
  (<- (desig:action-grounding ?desig (look-at ?desig))
      (desig-prop ?desig (:type  :looking))
      (desig-prop ?desig (:target ?object-desig))
      ;;(desig-prop ?desig (:arm ?arm))
      ) )