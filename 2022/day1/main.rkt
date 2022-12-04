#lang racket
(require racket
         advent-of-code)

; Get input from AOC
(define calories
  (fetch-aoc-input
   "53616c7465645f5fbc3c25de1e6119930d56fdf25d36f22fae88369b1a95513b8e00519af64e91f07fe22e8c90d63afbc7dbe7da778f1e305014b5193f9b59c6"
   2022
   1))

; Part 1
(apply max
       (map (lambda (x) (apply + x))
            (map (lambda (x) (map string->number (string-split x "\n")))
                 (string-split calories "\n\n"))))

; Part 2
(apply +
       (take (sort (map (lambda (x) (apply + x))
                        (map (lambda (x) (map string->number (string-split x "\n")))
                             (string-split calories "\n\n")))
                   >)
             3))
