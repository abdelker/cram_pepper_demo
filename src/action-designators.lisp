(in-package :pepper-demo)

(def-fact-group pepper-action-designators (action-grounding) 

;;listen-to-interaction 
(<- (desig:action-grounding ?desig (listen-to-interaction  ?desig))
      (desig-prop ?desig (:type  :listening)) ;
      (desig-prop ?desig (:understand ?interaction-desig))
      )

;;listen-and-reply
(<- (desig:action-grounding ?desig (listen-and-reply  ?desig))
      (desig-prop ?desig (:type  :listening-and-replying)) 
      (desig-prop ?desig (:receive ?you-interaction-desig))
      (desig-prop ?desig (:reply ?me-interaction-desig))
      ) 

;;telling
(<- (desig:action-grounding ?desig (tell ?desig))
      (desig-prop ?desig (:type  :asking)) 
      (desig-prop ?desig (:question ?question))
      (desig-prop ?desig (:agent ?agent))
      ) 

;;asking
(<- (desig:action-grounding ?desig (ask ?desig))
      (desig-prop ?desig (:type  :asking)) 
      (desig-prop ?desig (:question ?question))
      (desig-prop ?desig (:agent ?agent))
      ) 

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

;;pointing at
  (<- (desig:action-grounding ?desig (point ?desig))
      (desig-prop ?desig (:type  :pointing))
      (desig-prop ?desig (:at ?object-designator))
      (desig-prop ?desig (:arm ?selected-arm)))
      ) 