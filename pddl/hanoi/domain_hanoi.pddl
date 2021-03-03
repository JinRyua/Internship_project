;Header and description

(define (domain hanoi)

;remove requirements that are not needed
(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    block ground - ring
    pillar
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
    (at-block ?x -ring ?y -pillar)
    (low_attached ?x -block ?y - ring)
    (bigger ?smaller ?bigger -ring)
    (ontop ?x -ring ?y -pillar)
    ;(empty ?y - ground)
    
    
)




;define actions here
(:action move
    :parameters (?x -block ?y ?low -ring ?from ?to -pillar)
    :precondition (and 
    (at-block ?x ?from)
    (ontop ?x ?from)
    (at-block ?y ?to)
    (ontop ?y ?to)
    (bigger ?x ?y)
    (low_attached ?x ?low))

    :effect (and
    (at-block ?x ?to)
    (not(at-block ?x ?from))
    (ontop ?x ?to)
    (not(ontop ?y ?to))
    (low_attached ?x ?y)
    (not(low_attached ?x ?low))
    (not(ontop ?x ?from))
    (ontop ?low ?from))
)


)