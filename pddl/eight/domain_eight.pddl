;Header and description

(define (domain eight)

;remove requirements that are not needed
(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    point
    num
    route
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
    (at-point ?x -num ?y - point)
    (empty ?x -point)
    (side ?x ?y -point)
)

(:functions
    (distance ?r - route)
)
;define actions here
(:action move
    :parameters ( ?x - num ?from ?to - point)
    :precondition (and
    (at-point ?x ?from)
    (empty ?to)
    (side ?from ?to)
    )
    :effect (and
    (at-point ?x ?to)
    (not (at-point ?x ?from))
    (empty ?from)
    (not(empty ?to))
    )
)




)