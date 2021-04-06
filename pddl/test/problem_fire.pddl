(define (problem problem_test) (:domain test)
(:objects 
    p -player
    c -agent
    a1 a2 a3 -point
)

(:init
    (at-point c a2)
    (at-point p a1)
    (route a1 a2)(route a2 a1)
    (route a2 a3)(route a3 a2)
    (route a3 a1)(route a1 a3)
    (=(count)0)
    (=(time)0)
    ;todo: put the initial state's facts and numeric values here
)

(:goal (and
    (at-point p a3)
    ;todo: put the goal condition here
))

;un-comment the following line if metric is needed
;(:metric maximize (count))
)
