;Header and description

(define (domain fire)

;remove requirements that are not needed
(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    firecar resque -car
    firest hosp accident -building
    route
    
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
    (at-building ?c -car ?bulid - building)
    (moving ?c -car)
    (acting ?c -car)
    (not-acting ?c -car)
    
    (exist-injure ?ac -accident)
    (not-injure ?ac -building)
    (injure-resque ?res -resque)
    (empty-car ?c -car)
    (my-hospital ?res - resque ?hos -hosp)

    (ing-fire ?ac -accident)
    (not-fire ?ac - building)
    (route-between ?r -route ?from ?to - building)
)


(:functions ;todo: define numeric functions here
    (distance ?r - route)
    (fire-size ?ac -accident)
    (fire1)
    (total)
)


; (:action extinguish
;     :parameters (?x -firecar ?bd -accident)
;     :precondition (and 
;         (at-building ?x ?bd)
;         (ing-fire ?bd)
;     )
;     :effect (and 
;         (not-fire ?bd)
;         (not(ing-fire ?bd))
;     )
; )

(:durative-action extinguish
    :parameters (?x -firecar ?ac -accident)
    :duration (= ?duration 1);(fire-size ?ac))
    :condition (and 
        (at start (and 
            (at-building ?x ?ac)
            (ing-fire ?ac)
            (not-acting ?x)
            (>(fire-size ?ac)1)
        ))
        ; (at end (and 
        ; ))
    )
    :effect (and 
        (at start (and 
            (acting ?x)
            (not(not-acting ?x))
            (decrease (fire-size ?ac) 1)
        ))
        (at end (and 
            (not(acting ?x))
            (not-acting ?x)
            ;(not-fire ?ac)
            ;(not(ing-fire ?ac))
        ))
    )
)

(:durative-action extinguish_finish
    :parameters (?x -firecar ?ac -accident)
    :duration (= ?duration 1);(fire-size ?ac))
    :condition (and 
        (at start (and 
            (at-building ?x ?ac)
            (ing-fire ?ac)
            (not-acting ?x)
            (=(fire-size ?ac)1)
        ))
        ; (at end (and 
        ; ))
    )
    :effect (and 
        (at start (and 
            (acting ?x)
            (not(not-acting ?x))
            (decrease (fire-size ?ac) 1)
        ))
        (at end (and 
            (not(acting ?x))
            (not-acting ?x)
            (not-fire ?ac)
            (not(ing-fire ?ac))
        ))
    )
)

(:durative-action resque_human
    :parameters (?x -resque ?bd -accident)
    :duration (= ?duration 0.001)
    :condition (and 
        (at start (and 
            (at-building ?x ?bd)
            (exist-injure ?bd)
            (empty-car ?x)
            (not-acting ?x)
        ))
    )
    :effect (and 
        (at start (and 
            (acting ?x)
            (not(not-acting ?x))
        ))
        (at end (and 
            (not(acting ?x))
            (not-acting ?x)
            (not(exist-injure ?bd))
            (not-injure ?bd)
            (injure-resque ?x)
            (not(empty-car ?x))  
        ))
    )
)

(:durative-action put_human
    :parameters (?x - resque ?bd -hosp)
    :duration (= ?duration 0.001)
    :condition (and 
        (at start (and 
            (at-building ?x ?bd)
            (injure-resque ?x)
            (my-hospital ?x ?bd)
            (not-acting ?x)
        ))
    )
    :effect (and 
        (at start (and 
            (acting ?x)
            (not(not-acting ?x))
        ))
        (at end (and 
            (not(acting ?x))
            (not-acting ?x)
            (not(injure-resque ?x))
            (empty-car ?x)
        ))
    )
)


;define actions here
(:durative-action move
    :parameters (?r - route ?c -car ?from ?to - building)
    :duration (= ?duration (distance ?r))
    :condition (and 
        (at start (and 
            (at-building ?c ?from)
            (route-between ?r ?from ?to)
            (not-acting ?c)
        ))
        ; (at end (and 
        ; ))
    )
    :effect (and 
        (at start (and 
            (not(at-building ?c ?from))
            (acting ?c)
            (not(not-acting ?c))
        ))
        (at end (and 
            (at-building ?c ?to)
            (not(acting ?c))
            (not-acting ?c)
        ))
    )
)


)
