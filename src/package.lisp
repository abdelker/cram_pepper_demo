(defpackage :cram-pepper-demo
  (:nicknames :pepper-demo)
  (:use :cpl
        :roslisp
        :cl-transforms
        :cram-designators
        :cram-process-modules
        :cram-language-designator-support)
  (:import-from :cram-prolog :def-fact-group :<- :lisp-fun)
  )
