;Header and description

(define (domain test)

;remove requirements that are not needed
(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    agent player -car
    point
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
    (route ?p1 ?p2 - point)
    (at-point ?c -car ?p - point)
    (acting ?c -car)
    (not-acting ?c -player)

)


(:functions ;todo: define numeric functions here
    (count)
    (time)
)


(:durative-action move
    :parameters (?c -agent ?from ?to -point)
    :duration (= ?duration 1);(fire-size ?ac))
    :condition (and 
        (at start (and 
            (at-point ?c ?from)
            (route ?from ?to)
            (not(acting ?c))
        ))
        ; (at end (and 
        ; ))
    )
    :effect (and 
        (at start (and 
            (acting ?c)
            ;(not(at-point ?c ?from))
        ))
        (at end (and 
            (not(acting ?c))
            (not(at-point ?c ?from))
            (at-point ?c ?to)
            (increase (time) 1)
            
        ))
    )
)

(:durative-action cat
    :parameters (?p -player ?c -agent ?from -point)
    :duration (= ?duration 0.1);(fire-size ?ac))
    :condition (and 
        (at start (and 
            (at-point ?c ?from)
            (at-point ?p ?from)
        ))
        ; (at end (and 
        ; ))
    )
    :effect (and 
        (at end (and 
            (increase (count) 1)
            (increase (time) 0.1)
        ))
    )
)

(:durative-action pmove
    :parameters (?c -player ?from ?to -point)
    :duration (= ?duration 0.1);(fire-size ?ac))
    :condition (and 
        (at start (and 
            (at-point ?c ?from)
            (route ?from ?to)
            (not-acting ?c))
        ))
        ; (at end (and 
        ; ))
    
    :effect (and 
        (at start (and 
            (acting ?c)
            (not(not-acting ?c))
            ;(not(at-point ?c ?from))
        ))
        (at end (and 
            (not-acting ?c)
            (not(acting ?c))
            (not(at-point ?c ?from))
            (at-point ?c ?to)
            (increase (time) 0.5)
        ))
    )
)

)
