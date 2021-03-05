(define (problem problem_eight) (:domain eight)
(:objects 
    p11 p12 p13 p21 p22 p23 p31 p32 p33 - point
    n1 n2 n3 n4 n5 n6 n7 n8 - num
    route1 - route
)

(:init
    ; (at-point n1 p21)(at-point n2 p11)(at-point n3 p13)(at-point n4 p32)(at-point n5 p33)(at-point n6 p22)(at-point n7 p23)(at-point n8 p31)
    ; (at-point n1 p33)(at-point n2 p22)(at-point n3 p31)(at-point n4 p13)(at-point n5 p32)(at-point n6 p11)(at-point n7 p12)(at-point n8 p21)
    (at-point n1 p11)(at-point n2 p12)(at-point n3 p13)(at-point n4 p21)(at-point n5 p32)(at-point n6 p23)(at-point n7 p31)(at-point n8 p33)

    (empty p22)

    (side p11 p12)(side p11 p21)
    (side p12 p11)(side p12 p13)(side p12 p22)
    (side p13 p12)(side p13 p23)
    (side p21 p11)(side p21 p22)(side p21 p31)
    (side p22 p12)(side p22 p21)(side p22 p23)(side p22 p32)
    (side p23 p13)(side p23 p22)(side p23 p33)
    (side p31 p21)(side p31 p32)
    (side p32 p22)(side p32 p31)(side p32 p33)
    (side p33 p23)(side p33 p32)

    (= (distance route1) 1)
    ;todo: put the initial state's facts and numeric values here
)

(:goal (and
    (at-point n1 p11)
    (at-point n2 p12)
    (at-point n3 p13)
    (at-point n4 p21)
    (at-point n5 p22)
    (at-point n6 p23)
    (at-point n7 p31)
    (at-point n8 p32)
    ;todo: put the goal condition here
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
