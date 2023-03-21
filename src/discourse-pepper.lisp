(in-package :pepper-demo)

(defvar *onto* nil)
(defvar *list-greeting* nil)
(defvar *list-task* nil)
(defvar *list-explanation* nil)
(defvar *list-please-take* nil)
(defvar *list-wrong-cube* nil)
(defvar *list-end* nil)
(defvar *list-help* nil)
(defvar *list-congrate* nil)
(defvar *list-scan* nil)
(defvar *list-rescan* nil)
(defvar *list-discover* nil)
(defvar *list-waiting* nil)
(defvar *list-point-good-cube* nil)
(defvar *list-no-cube-take* nil)
(defvar *list-continue* nil)
(defvar *list-designate-cube* nil)
(defvar *list-not-understand* nil)
(defvar *list-question* nil)
(defvar *list-impossible-take* nil)

(defun init-onto (onto)
    (setq *onto* onto)
    (list-discourse)
    (princ (hello)))

(defun list-discourse (&optional (word ""))
 (setq *list-greeting* 
     (list "Hello i am pepper" "Hello my name is pepper"))
 (setq *list-task*
           (list "We will do a task together" "I hope you are willing to help me" "I count on you to help me")
           (setq *list-explanation*)
           (list "I'm going to ask you to remove {} cubes and put them in the pink box." "I'll describe you {} cubes to put in the pink box" "We\"ll put {} the cubes in the pink box. I\"ll describe them to you"))
 (setq *list-explanation*
           (list (format nil "I'm going to ask you to remove ~a cubes and put them in the pink box." "I'll describe you ~a cubes to put in the pink box" "We'll put ~a the cubes in the pink box. I'll describe them to you" word)))
 (setq *list-please-take*
           (list (format nil "Can you remove ~a" "Remove ~a" "Take ~a" word)))
 (setq *list-wrong-cube*
           (list "I think you picked the wrong cube." "It seems to me that it is not this cube" "I wasn't thinking about this cube"))
 (setq *list-end*
          (list "Congratulations to you! Thank you for helping me. See you soon" "Great! Thanks for helping me. See you soon" "Well done  we did it. Thank you and see you soon"))
 (setq *list-help*
            (list (format nil "~a can you help us?" "can ~a you help us?" word))) 
 (setq *list-congrate*
            (list "Bravo  it was the one" "Very good  it was this cube" "super it was him"))
 (setq *list-cancel*
            (list "We will finish another time"))
 (setq *list-scan*
            (list "Give me some time to look at what's in the boxes" "Let's look at the objects there."))
 (setq *list-rescan*
            (list "Thank you  I will check what has moved" "Let's see what has moved"))
 (setq *list-discover*
            (list (format nil "I saw a ~a" "There is a ~a" "Oh  a ~a" word)))
 (setq *list-waiting*
            (list "Did you take it?" "I think the cube is still there"))
 (setq *list-point-good-cube*
            (list "I was thinking more like this one" "I wanted to talk about this cube"))
 (setq *list-no-cube-take*
            (list "For me the cube is always here" "I have the impression that the cube is still here"))
 (setq *list-continue*
             (list "Let's go to the next one" "Let's go on"))

 (setq *list-designate_cube*
             (list "I think you mean this one" "you want to talk about this cube" "here is the cube you are talking about"))

 (setq *list-not_understand*
     (list "I didn't quite understand"  "I'm not sure I understood"  "Sorry  can you repeat that"))

 (setq *list-question*
     (list "Which one do you want to enter " "Is that what you mean " "Do you mean  "))

 (setq *list-impossible-take*
     (list "I can't catch anything but I'll show it to you"  "I'll show it to you instead because I can't catch it"  "Since I can't catch it  I'll show it to you")))    
      
(defun hello ()
 (let ((n (+ 1 (random (length *list-greeting*)))))
      (nth (- n 1) *list-greeting*)))

(defun wrong-cube ()
       (let ((n (+ 1 (random (length *list-wrong-cube*)))))
        (nth (- n 1) *list-wrong-cube*)))

(defun goodbye ()
    (let ((n (+ 1 (random (length *list-end*)))))
     (nth (- n 1) *list-end*)))

(defun continueTask ()
    (let ((n (+ 1 (random (length *list-continue*)))))
     (nth (- n 1) *list-continue*)))

(defun congrate ()
    (let ((n (+ 1 (random (length *list-congrate*)))))
     (nth (- n 1) *list-congrate*)))

(defun cancel ()
    (let ((n (+ 1 (random (length *list-cancel*)))))
     (nth (- n 1) *list-cancel*)))

(defun scan ()
    (let ((n (+ 1 (random (length *list-scan*)))))
     (nth (- n 1) *list-scan*)))

(defun rescan ()
    (let ((n (+ 1 (random (length *list-rescan*)))))
     (nth (- n 1) *list-rescan*)))

(defun waiting ()
    (let ((n (+ 1 (random (length *list-waiting*)))))
     (nth (- n 1) *list-waiting*)))

(defun pointGood-cube ()
    (let ((n (+ 1 (random (length *list-point-good-cube*)))))
     (nth (- n 1) *list-point-good-cube*)))

(defun no-cubeTake ()
    (let ((n (+ 1 (random (length *list-no-cube-take*)))))
     (nth (- n 1) *list-no-cube-take*)))

(defun designate-cube ()
    (let ((n (+ 1 (random (length *list-designate-cube*)))))
     (nth (- n 1) *list-designate-cube*)))

(defun notUnderstand ()
    (let ((n (+ 1 (random (length *list-not-understand*)))))
     (nth (- n 1) *list-not-understand*)))

(defun question ()
    (let ((n (+ 1 (random (length *list-question*)))))
     (nth (- n 1) *list-question*)))

(defun impossible-take ()
    (let ((n (+ 1 (random (length *list-impossible-take*)))))
     (nth (- n 1) *list-impossible-take*)))

(defun discover-cube (cube)
        (list-discourse :word cube)
        (let ((n (+ 1 (random (length *list-discover*)))))
         (nth (- n 1) *list-discover*)))
 
(defun help (name)
    (list-discourse :word name)
    (let ((n (+ 1 (random (length *list-help*)))))
     (nth (- n 1) *list-help*)))

(defun explain (nb)
    (list-discourse :word nb)
    (let ((n (+ 1 (random (length *list-explanation*)))))
     (nth (- n 1) *list-explanation*)))

(defun take-cube (cube)
    (list-discourse :word cube)
    (let ((n (+ 1 (random (length *list-please-take*)))))
     (nth (- n 1) *list-please-take*)))