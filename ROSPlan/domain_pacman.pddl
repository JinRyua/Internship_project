;Header and description

(define (domain pacman)

;remove requirements that are not needed
(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    player agent -character
    point
    action
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
    (is-wall ?p -point)
    (is-blank ?p -point)
    (is-scookie ?p -point)
    (is-lcookie ?p -point)
    (is-ghost ?a -agent)
    (is-menu ?p -point)
    (in-block ?c -character ?p -point)
    (is-start ?p -point)
    (is-end ?p -point)
)


(:functions ;todo: define numeric functions here
    (timer)
    (row)
    (col)
    (direction ?c -character)
)

; (:action do_action
;     :parameters (?agent ?from ?to)
;     :precondition (and 
;     )
;     :effect (and 

;     )
; )
(:durative-action move
    :parameters (?a -agent ?to -point)
    :duration (= ?duration 1)
    :condition (and 
        ;(at start (and 
            ;(in-block ?a ?from)
        ;))
    )
    :effect (and 
        ;(at start (and 
            ;(not(in-block ?a ?from))
        ;))
        ;(at end (and 
            ;(in-block ?a ?to)
        ;))
    )
)

)
