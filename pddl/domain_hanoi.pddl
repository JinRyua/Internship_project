;Header and description

(define (domain hanoi)

;remove requirements that are not needed
(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    block ground - ring
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
    (at-block ?x -block ?y -ground)
    (low_attached ?x -block ?y - ring)
    (bigger ?smaller -block ?bigger)
    (ontop ?x -block ?y -ground)
    ;(empty ?y - ground)
    
    
)




;define actions here
(:action move
    :parameters (?x -block ?from ?to - ground ?y ?low)
    :precondition (and 
    (at-block ?x ?from)
    (ontop ?x ?from)
    (at-block ?y ?to)
    (ontop ?y ?to)
    (bigger ?x ?y))
    (low_attached ?x ?low)

    :effect (and
    (at-block ?x ?to)
    (not(at-block ?x ?from))
    (ontop ?x ?to)
    (not(ontop ?y ?to))
    
    (not(ontop ?x ?from))
    (ontop()))
)


)