(in-package :cram-pepper-demo)

(def-fact-group occasions (
    waiting-for-human1
    looking-at-cube1
    waiting-for-human2
    looking-at-cube2

)

  (<- (waiting-for-human1 ?human)
    (fail))
  (<- (looking-at-cube1 ?cube)
    (fail))
  (<- (waiting-for-human2 ?human)
    (fail))
  (<- (looking-at-cube2 ?cube)
    (fail))
  )
