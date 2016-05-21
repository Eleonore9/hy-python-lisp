#! /usr/bin/env hy

;; For loop:

(for [i (range 6)]
  (print (+ "i equals " (str i))))


;; If/else statement:

(if (= 3 (+ 1 2))
  (print "This is true")
  (print "This is false"))


;; Cond statement:
;; (when you need to use elif)
(setv number 42)

(cond
 [(> number 40) (print "My number is more than 40.")]
 [(> number 20) (print "My number is more than 20.")]
 [(< number 10) (print "My number is less than 10.")])


;; Fizzbuzz:

(defn fizzbuzz [num]
  (for [n (range 1 num)]
    (cond
     [(= 0 (% n 15)) (print n "fizzbuzz")]
     [(= 0 (% n 3)) (print n "fizz")]
     [(= 0 (% n 5)) (print n "buzz")])))
