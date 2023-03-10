(in-package :pepper-demo)



(defvar *disambiguate-srv* nil "ROS service to disambgiuate")
(defvar *verbalize-srv* nil "ROS service to verbalize")
(defvar *understand-srv* nil "ROS service to understand")
(defvar *merge-srv* nil "ROS service to merge")
(defvar *sparql-srv* nil "ROS service to sparql")

(defvar ctx-designate nil)
(defvar table "table_1")
(defvar table1 "table_1")
(defvar str_sparql nil)

(defun init-ros-dt ()
  (setf *disambiguate-srv* "/KSP/disambiguate")
  (setf *understand-srv* "/KSP/understand")
  (setf *merge-srv* "/KSP/merge")
  (setf *sparql-srv* "/ontologenius/sparql/pepper"))

;;sparql_ontology
(defun call-sparql-srv (merge-sparql)
  "Function to call the sparql-srv service."
  (princ merge-sparql)
  (terpri)
  ;;(cond 
  ;; ((typep merge-sparql 'list)
  (setq str_sparql (format nil
                           "~{~A~^, ~}"
                           (coerce merge-sparql 'list)))
  ;; ))
  ;;(setq str_sparql merge-sparql)

  (princ str_sparql)
  (terpri)
  (princ "ontology results: ")
  (terpri)
  (princ (call-service *sparql-srv* 'ontologenius-srv:OntologeniusSparqlService :query
                       str_sparql)))

(defun call-merge-srv (query ctx partial)
  "Function to call the KSP-merge service."
  (princ "Waiting for KSP merge")
  (terpri)
  (princ (format nil "query: ~a" query))
  (terpri)
  (princ (format nil "ctx: ~a" ctx))
  (terpri)
  (princ "merge response: ")
  (terpri)
  (princ (call-service *merge-srv* 'knowledge_sharing_planner_msgs-srv:Merge :base_query
                       query :context_query ctx
                       :partial partial)))

(defun call-understand-srv (sentence)
  "Function to call the KSP-understand service."
  (princ "Waiting for KSP Understand")
  (terpri)
  (princ "understand response: ")
  (terpri)
  (princ (call-service *understand-srv* 'knowledge_sharing_planner_msgs-srv:Understand :verbalization
                       sentence)))



(defun create-symbol-table (match)
  (roslisp:make-msg "ontologenius/OntologeniusSparqlResponse"
                    :names (slot-value match 'ONTOLOGENIUS-MSG:NAMES):values
                    (slot-value match 'ONTOLOGENIUS-MSG:VALUES)))


(defun call-disambiguate-srv (match ctx)
  "Function to call the SetChestColor service."
  (call-service *disambiguate-srv* ' knowledge_sharing_planner_msgs-srv:Disambiguation
                :ontology "pepper"
                :symbol_table (create-symbol-table match)
                :individual (svref (slot-value match 'ONTOLOGENIUS-MSG:VALUES) 0)
                ;;   (loop for n in (coerce match 'list) do (princ n) (return n))
                )
  ) 

(defun designateCube (sentences)
  (setq response-understand-srv (call-understand-srv sentences))
  (setq action (slot-value response-understand-srv 'KNOWLEDGE_SHARING_PLANNER_MSGS-SRV:ACTION))
  (setq sparql (slot-value response-understand-srv 'KNOWLEDGE_SHARING_PLANNER_MSGS-SRV:SPARQLQUERY))
  ;; (cond 
  ;;((not ctx-designate)
  (setq ctx-designate (vector (format nil "?0 isAbove ~a" table1)
                              "?0 isInContainer ?1"
                              "?1 isA VisibleDtBox")
        ;;  ))
        )
  (setq response-merge-srv (call-merge-srv sparql ctx-designate nil))
  (setq merge-sparql (slot-value response-merge-srv 'KNOWLEDGE_SHARING_PLANNER_MSGS-SRV:MERGED_QUERY))
  (setq response-sparql-srv (call-sparql-srv merge-sparql))
  (setq matches (slot-value response-sparql-srv 'ONTOLOGENIUS-SRV:RESULTS))
  (cond
   ((> (length matches) 1)
    (progn
      (terpri)
      (princ "I am not sure of what you are speaking about...")
      (terpri)
      (setq new-context matches)
      (setq question "")
      ;;(setq onematch 
      (loop for
            match
            in
            (coerce matches 'list)
            do
            ;;(
            (setq response-disambiguate-srv (call-disambiguate-srv match new-context))
            (terpri)
            (princ "Sparqlresponse: ")
            (terpri)
            (princ (setq sparql-result (slot-value response-disambiguate-srv 'KNOWLEDGE_SHARING_PLANNER_MSGS-SRV:SPARQLRESULT)))
            (setq ambiguous (slot-value response-disambiguate-srv 'KNOWLEDGE_SHARING_PLANNER_MSGS-SRV:AMBIGUOUS))
            (cond
             ((not (coerce ambiguous 'list))
              (setq match-sparql sparql-result))
             (return nil)))))))


