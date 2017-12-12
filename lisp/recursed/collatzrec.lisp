#!/usr/bin/sbcl --script
#||
Mark Gomes
CSC 330
Assignment 3 - Collatz Conjecture
||#

(defvar num 5000000000)
(defvar n)
(defvar steps 0)
(defvar minsteps 0)
(defvar MC)
(setf MC (make-array '(10 2)))
(defvar Temp)
(setf Temp (make-array '(10 2)))
(defvar index)
(defvar diff)
(defvar mode)
(defvar maxval)

;;; Zero the array
(dotimes(i 10)
    (dotimes(j 2)
        (setf(aref MC i j) 0)
    )
)

(defun recstep (n)
    (if (= n 1)
        (return-from recstep 0)    ;;;end recursion
      (if (= (mod n 2) 0)
          (return-from recstep (+ 1 (recstep(/ n 2))))
        (return-from recstep (+ 1 (recstep(+ (* n 3) 1))))
      )
    )
)

(defun updatearray ()
    (setf index -1)
    (setf diff 0)
    (setf minsteps steps)
    
    (dotimes(i 10)
        (if (< (aref MC i 1) minsteps)                ;;; Stores the lowest count in the array
            (setf minsteps (aref MC i 1))
        )
        (if (> (- steps (aref MC i 1)) diff)          ;;; Keeps track of index that produces the largest difference between counts
            (progn
            (setf diff (- steps (aref MC i 1)))
            (setf index i))
        )
    )
    (if (/= index -1)
        (progn
        (setf (aref MC index 0) num)
        (setf (aref MC index 1) steps))
    )
)

(defun arraysort (mode)       ;;; Mode: [1]Sort by step number; [2]Sort by number magnitude
    (setf steps 0)
    (setf num 0)
    (setf index 0)
    (setf maxval 0)

    ;;; Zero the array
    (dotimes(i 10)
        (dotimes(j 2)
            (setf(aref Temp i j) 0)
        )
    )
    
    (dotimes(i 10)
        (dotimes(j 10)
            (if (>= (aref MC j mode) maxval)
                (progn
                (setf maxval (aref MC j mode))
                (setf steps (aref MC j 1))
                (setf num (aref MC j 0))
                (setf index j))
            )
        )
        (setf (aref Temp i 0) num)
        (setf (aref Temp i 1) steps)
        (setf (aref MC index 0) 0)
        (setf (aref MC index 1) 0)
        (setf maxval 0)
    )
    (dotimes(i 10)
        (dotimes(j 2)
            (setf (aref MC i j) (aref Temp i j))
        )
    )
)

(loop              ;;; Preform the collatz algorithm
    (setf n num)
    (setf steps (recstep n))
    ;(format t "Number: ~a    Steps : ~a ~%" num steps)
    (if (> steps minsteps)
        (updatearray)
    )
    (setf num (- num 1))
    (setf steps 0)
    (when (= num 1) (return num))
)

;;; Sorted by step length
(format t "***Sorted by Step Length*** ~%")
(arraysort 1)
(dotimes(i 10)
    (format t "Number: ~a    Steps : ~a ~%" (aref MC i 0) (aref MC i 1))
)

;;; Sorted by number magnitude
(format t "***Sorted by Number Magnitude*** ~%")
(arraysort 0)
(dotimes(i 10)
    (format t "Number: ~a    Steps : ~a ~%" (aref MC i 0) (aref MC i 1))
)