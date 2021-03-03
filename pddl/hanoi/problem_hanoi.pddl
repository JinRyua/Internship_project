(define (problem problem_hanoi) (:domain hanoi)
(:objects 
    g1 g2 g3 -ground
    block1 block2 block3 -block
    p1 p2 p3 -pillar
)

(:init
    (low_attached block1 block2)
    (low_attached block2 block3)
    (low_attached block3 g1)
    (at-block g1 p1)
    (at-block g2 p2)
    (at-block g3 p3)
    (at-block block1 p1)
    (at-block block2 p1)
    (at-block block3 p1)
    (ontop block1 p1)
    (ontop g2 p2)
    (ontop g3 p3)
    (bigger block1 g1)
    (bigger block1 g2)
    (bigger block1 g3)
    (bigger block2 g1)
    (bigger block2 g2)
    (bigger block2 g3)
    (bigger block3 g1)
    (bigger block3 g2)
    (bigger block3 g3)
    (bigger block1 block2)
    (bigger block2 block3)
    (bigger block1 block3)
    
    ;todo: put the initial state's facts and numeric values here
)

(:goal (and
    (at-block block1 p2)
    (at-block block2 p2)
    (at-block block3 p2)
    
    (low_attached block1 block2)
    (low_attached block2 block3)
    (low_attached block3 g2)

    (ontop block1 p2)

    ;todo: put the goal condition here
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
