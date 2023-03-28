(in-package :pepper-demo)

(def-fact-group pepper-action-designators (action-grounding) 

;;greet-human
  (<- (desig:action-grounding ?desig (greet-human ?desig))
      (desig-prop ?desig (:type  :greeting))
      (desig-prop ?desig (:greeting-speech ?sentence))
      (desig-prop ?desig (:greeting-place ?place))
      ) 


;;looking at
  (<- (desig:action-grounding ?desig (look-at ?desig))
      (desig-prop ?desig (:type  :looking))
      (desig-prop ?desig (:target ?object-desig))
      ;;(desig-prop ?desig (:arm ?arm))
      ) 
;;moving-to   
  (<- (desig:action-grounding ?desig (move-to ?desig))
      (desig-prop ?desig (:type  :moving))
      (desig-prop ?desig (:to ?place)))

;;speaking
 (<- (desig:action-grounding ?desig (speak ?desig))
      (desig-prop ?desig (:type  :speaking))
      (desig-prop ?desig (:speech ?sentence)))

;;scanning
  (<- (desig:action-grounding ?desig (scan ?desig))
      (desig-prop ?desig (:type  :scanning))
      (desig-prop ?desig (:zone ?zone)))
      ) 