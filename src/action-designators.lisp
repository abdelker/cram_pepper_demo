(in-package :pepper-demo)

(def-fact-group pepper-action-designators (action-grounding) 

;;looking at
  (<- (desig:action-grounding ?desig (look-at ?desig))
      (desig-prop ?desig (:type  :looking))
      (desig-prop ?desig (:target ?object-desig))
      ;;(desig-prop ?desig (:arm ?arm))
      ) 
;;moving-to   
  (<- (desig:action-grounding ?desig (move-to ?desig))
      (desig-prop ?desig (:type  :moving-to))
      (desig-prop ?desig (:to ?place)))

;;saying
 (<- (desig:action-grounding ?desig (say ?desig))
      (desig-prop ?desig (:type  :saying))
      (desig-prop ?desig (:sentence ?sentence)))

;;scannin
  (<- (desig:action-grounding ?desig (scan ?desig))
      (desig-prop ?desig (:type  :scanning))
      (desig-prop ?desig (:zone ?zone)))
      ) 