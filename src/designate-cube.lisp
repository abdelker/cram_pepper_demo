(dt::designate-cube
              "pick the blue cube")
Waiting for KSP Understand
understand response: 
[UNDERSTAND-RESPONSE
   SPARQLQUERY:
     #(?0 isA Cube ?0 hasColor blue)
   ACTION:
     Pick
   COMPREHENSION_SCORE:
     1.0d0
   ANALYSE_SCORE:
     1.0d0]Waiting for KSP merge
query: #(?0 isA Cube ?0 hasColor blue)
ctx: #(?0 isAbove table_lack ?0 isInContainer ?1 ?1 isA VisibleDtBox)
merge response: 
[MERGE-RESPONSE
   MERGED_QUERY:
     #(?0 isAbove table_lack ?0 isInContainer ?1 ?1 isA VisibleDtBox
       ?0 isA Cube ?0 hasColor blue)]#(?0 isAbove table_lack
                                       ?0 isInContainer ?1 ?1 isA VisibleDtBox
                                       ?0 isA Cube ?0 hasColor blue)
?0 isAbove table_lack, ?0 isInContainer ?1, ?1 isA VisibleDtBox, ?0 isA Cube, ?0 hasColor blue
ontology results: 
[ONTOLOGENIUSSPARQLSERVICE-RESPONSE
   RESULTS:
     #([ONTOLOGENIUSSPARQLRESPONSE
          NAMES:
            #(0 1)
          VALUES:
            #(cube_GBTG box_C1)]
       [ONTOLOGENIUSSPARQLRESPONSE
          NAMES:
            #(0 1)
          VALUES:
            #(cube_BBCG box_C2)]
       [ONTOLOGENIUSSPARQLRESPONSE
          NAMES:
            #(0 1)
          VALUES:
            #(cube_BBTG box_C3)]
       [ONTOLOGENIUSSPARQLRESPONSE
          NAMES:
            #(0 1)
          VALUES:
            #(cube_GBCB box_C4)])
   ERROR:
     ]
I am not sure of what you are speaking about...

new context set:
#(?0 isAbove table_lack ?0 isInContainer ?1 ?1 isA VisibleDtBox ?0 isA Cube
  ?0 hasColor blue)
triplet :
[TRIPLET
   FROM:
     ?0
   RELATION:
     isAbove
   ON:
     table_lack]
triplet :
[TRIPLET
   FROM:
     ?0
   RELATION:
     isInContainer
   ON:
     ?1]
triplet :
[TRIPLET
   FROM:
     ?1
   RELATION:
     isA
   ON:
     VisibleDtBox]
triplet :
[TRIPLET
   FROM:
     ?0
   RELATION:
     isA
   ON:
     Cube]
triplet :
[TRIPLET
   FROM:
     ?0
   RELATION:
     hasColor
   ON:
     blue]resp disambiguate :[DISAMBIGUATION-RESPONSE
                                SUCCESS:
                                  T
                                RESULT:
                                  #([TRIPLET
                                       FROM:
                                         cube_GBTG_form
                                       RELATION:
                                         isA
                                       ON:
                                         Triangle]
                                    [TRIPLET
                                       FROM:
                                         cube_GBTG
                                       RELATION:
                                         hasFigure
                                       ON:
                                         cube_GBTG_form]
                                    [TRIPLET
                                       FROM:
                                         cube_GBTG_border
                                       RELATION:
                                         hasColor
                                       ON:
                                         green]
                                    [TRIPLET
                                       FROM:
                                         cube_GBTG_border
                                       RELATION:
                                         isA
                                       ON:
                                         Border]
                                    [TRIPLET
                                       FROM:
                                         cube_GBTG
                                       RELATION:
                                         hasBorder
                                       ON:
                                         cube_GBTG_border])
                                SPARQLRESULT:
                                  #(?0 hasBorder ?2 ?2 isA Border
                                    ?2 hasColor green ?0 hasFigure ?3
                                    ?3 isA Triangle)
                                AMBIGUOUS:
                                  #()]
Sparql result: 
#(?0 hasBorder ?2 ?2 isA Border ?2 hasColor green ?0 hasFigure ?3
  ?3 isA Triangle)
sparql : #(?0 hasBorder ?2 ?2 isA Border ?2 hasColor green ?0 hasFigure ?3
           ?3 isA Triangle)
the context is:
#(?0 isAbove table_lack ?0 isInContainer ?1 ?1 isA VisibleDtBox ?0 isA Cube
  ?0 hasColor blue)Waiting for KSP merge
query: #(?0 hasBorder ?2 ?2 isA Border ?2 hasColor green ?0 hasFigure ?3
         ?3 isA Triangle)
ctx: #(?0 isAbove table_lack ?0 isInContainer ?1 ?1 isA VisibleDtBox
       ?0 isA Cube ?0 hasColor blue)
merge response: 
[MERGE-RESPONSE
   MERGED_QUERY:
     #(?0 isA Cube ?0 hasBorder ?2 ?2 isA Border ?2 hasColor green
       ?0 hasFigure ?3 ?3 isA Triangle)]Question part : the block ,with a green border and with a triangle 

triplet :
[TRIPLET
   FROM:
     ?0
   RELATION:
     isAbove
   ON:
     table_lack]
triplet :
[TRIPLET
   FROM:
     ?0
   RELATION:
     isInContainer
   ON:
     ?1]
triplet :
[TRIPLET
   FROM:
     ?1
   RELATION:
     isA
   ON:
     VisibleDtBox]
triplet :
[TRIPLET
   FROM:
     ?0
   RELATION:
     isA
   ON:
     Cube]
triplet :
[TRIPLET
   FROM:
     ?0
   RELATION:
     hasColor
   ON:
     blue]resp disambiguate :[DISAMBIGUATION-RESPONSE
                                SUCCESS:
                                  T
                                RESULT:
                                  #([TRIPLET
                                       FROM:
                                         cube_BBCG_form
                                       RELATION:
                                         hasColor
                                       ON:
                                         green]
                                    [TRIPLET
                                       FROM:
                                         cube_BBCG_form
                                       RELATION:
                                         isA
                                       ON:
                                         Circle]
                                    [TRIPLET
                                       FROM:
                                         cube_BBCG
                                       RELATION:
                                         hasFigure
                                       ON:
                                         cube_BBCG_form])
                                SPARQLRESULT:
                                  #(?0 hasFigure ?3 ?3 isA Circle
                                    ?3 hasColor green)
                                AMBIGUOUS:
                                  #()]
Sparql result: 
#(?0 hasFigure ?3 ?3 isA Circle ?3 hasColor green)
sparql : #(?0 hasFigure ?3 ?3 isA Circle ?3 hasColor green)
the context is:
#(?0 isAbove table_lack ?0 isInContainer ?1 ?1 isA VisibleDtBox ?0 isA Cube
  ?0 hasColor blue)Waiting for KSP merge
query: #(?0 hasFigure ?3 ?3 isA Circle ?3 hasColor green)
ctx: #(?0 isAbove table_lack ?0 isInContainer ?1 ?1 isA VisibleDtBox
       ?0 isA Cube ?0 hasColor blue)
merge response: 
[MERGE-RESPONSE
   MERGED_QUERY:
     #(?0 isA Cube ?0 hasFigure ?3 ?3 isA Circle ?3 hasColor green)]Question part : the block ,with a green circle 

triplet :
[TRIPLET
   FROM:
     ?0
   RELATION:
     isAbove
   ON:
     table_lack]
triplet :
[TRIPLET
   FROM:
     ?0
   RELATION:
     isInContainer
   ON:
     ?1]
triplet :
[TRIPLET
   FROM:
     ?1
   RELATION:
     isA
   ON:
     VisibleDtBox]
triplet :
[TRIPLET
   FROM:
     ?0
   RELATION:
     isA
   ON:
     Cube]
triplet :
[TRIPLET
   FROM:
     ?0
   RELATION:
     hasColor
   ON:
     blue]resp disambiguate :[DISAMBIGUATION-RESPONSE
                                SUCCESS:
                                  T
                                RESULT:
                                  #([TRIPLET
                                       FROM:
                                         cube_BBTG_form
                                       RELATION:
                                         isA
                                       ON:
                                         Triangle]
                                    [TRIPLET
                                       FROM:
                                         cube_BBTG
                                       RELATION:
                                         hasFigure
                                       ON:
                                         cube_BBTG_form]
                                    [TRIPLET
                                       FROM:
                                         cube_BBTG_border
                                       RELATION:
                                         hasColor
                                       ON:
                                         blue]
                                    [TRIPLET
                                       FROM:
                                         cube_BBTG_border
                                       RELATION:
                                         isA
                                       ON:
                                         Border]
                                    [TRIPLET
                                       FROM:
                                         cube_BBTG
                                       RELATION:
                                         hasBorder
                                       ON:
                                         cube_BBTG_border])
                                SPARQLRESULT:
                                  #(?0 hasBorder ?2 ?2 isA Border
                                    ?2 hasColor blue ?0 hasFigure ?3
                                    ?3 isA Triangle)
                                AMBIGUOUS:
                                  #()]
Sparql result: 
#(?0 hasBorder ?2 ?2 isA Border ?2 hasColor blue ?0 hasFigure ?3
  ?3 isA Triangle)
sparql : #(?0 hasBorder ?2 ?2 isA Border ?2 hasColor blue ?0 hasFigure ?3
           ?3 isA Triangle)
the context is:
#(?0 isAbove table_lack ?0 isInContainer ?1 ?1 isA VisibleDtBox ?0 isA Cube
  ?0 hasColor blue)Waiting for KSP merge
query: #(?0 hasBorder ?2 ?2 isA Border ?2 hasColor blue ?0 hasFigure ?3
         ?3 isA Triangle)
ctx: #(?0 isAbove table_lack ?0 isInContainer ?1 ?1 isA VisibleDtBox
       ?0 isA Cube ?0 hasColor blue)
merge response: 
[MERGE-RESPONSE
   MERGED_QUERY:
     #(?0 isA Cube ?0 hasBorder ?2 ?2 isA Border ?2 hasColor blue
       ?0 hasFigure ?3 ?3 isA Triangle)]Question part : the block ,with a blue border and with a triangle 

triplet :
[TRIPLET
   FROM:
     ?0
   RELATION:
     isAbove
   ON:
     table_lack]
triplet :
[TRIPLET
   FROM:
     ?0
   RELATION:
     isInContainer
   ON:
     ?1]
triplet :
[TRIPLET
   FROM:
     ?1
   RELATION:
     isA
   ON:
     VisibleDtBox]
triplet :
[TRIPLET
   FROM:
     ?0
   RELATION:
     isA
   ON:
     Cube]
triplet :
[TRIPLET
   FROM:
     ?0
   RELATION:
     hasColor
   ON:
     blue]resp disambiguate :[DISAMBIGUATION-RESPONSE
                                SUCCESS:
                                  T
                                RESULT:
                                  #([TRIPLET
                                       FROM:
                                         cube_GBCB_form
                                       RELATION:
                                         hasColor
                                       ON:
                                         blue]
                                    [TRIPLET
                                       FROM:
                                         cube_GBCB_form
                                       RELATION:
                                         isA
                                       ON:
                                         Circle]
                                    [TRIPLET
                                       FROM:
                                         cube_GBCB
                                       RELATION:
                                         hasFigure
                                       ON:
                                         cube_GBCB_form])
                                SPARQLRESULT:
                                  #(?0 hasFigure ?3 ?3 isA Circle
                                    ?3 hasColor blue)
                                AMBIGUOUS:
                                  #()]
Sparql result: 
#(?0 hasFigure ?3 ?3 isA Circle ?3 hasColor blue)
sparql : #(?0 hasFigure ?3 ?3 isA Circle ?3 hasColor blue)
the context is:
#(?0 isAbove table_lack ?0 isInContainer ?1 ?1 isA VisibleDtBox ?0 isA Cube
  ?0 hasColor blue)Waiting for KSP merge
query: #(?0 hasFigure ?3 ?3 isA Circle ?3 hasColor blue)
ctx: #(?0 isAbove table_lack ?0 isInContainer ?1 ?1 isA VisibleDtBox
       ?0 isA Cube ?0 hasColor blue)
merge response: 
[MERGE-RESPONSE
   MERGED_QUERY:
     #(?0 isA Cube ?0 hasFigure ?3 ?3 isA Circle ?3 hasColor blue)]Question part : the block ,with a blue circle 
Do you mean : the block ,with a green border and with a triangle , or, the block ,with a green circle , or, the block ,with a blue border and with a triangle , or, the block ,with a blue circle ?
NIL
"the block ,with a green border and with a triangle , or, the block ,with a green circle , or, the block ,with a blue border and with a triangle , or, the block ,with a blue circle "
"Pick"