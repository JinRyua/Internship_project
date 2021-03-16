(define (problem grapper_problem) (:domain grapper)
(:objects 
    ball1 ball2 ball3 ball4 - ball
    rooma roomb -room
)

(:init
    (at-ball ball1 rooma)
    (at-ball ball2 rooma)
    (at-ball ball3 rooma)
    (at-ball ball4 rooma)

    ;todo: put the initial state's facts and numeric values here
)

(:goal (and
    (at-ball ball1 roomb)
    (at-ball ball2 roomb)
    (at-ball ball3 roomb)
    (at-ball ball4 roomb)
    ;todo: put the goal condition here
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
