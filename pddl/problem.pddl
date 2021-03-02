(define (problem puzzle_problem) (:domain puzzle)
(:objects 
    rooma roomb - room
    ball1 - ball
)

(:init
    ;todo: put the initial state's facts and numeric values here
    (at ball1 rooma)
)

(:goal (and
    ;todo: put the goal condition here
    (at ball1 roomb)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
