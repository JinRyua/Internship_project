;Header and description

(define (domain puzzle)

;remove requirements that are not needed
(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    room
    ball
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
    (at ?x - ball ?y - room)
)

;define actions here
(:action move
    :parameters (?x - ball ?from ?to - room)
    :precondition (and 
        (at ?x ?from)
    )
    :effect (and 
        (at ?x ?to)
        (not (at ?x ?from))
    )
)


)