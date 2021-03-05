;Header and description

(define (domain parking)

;remove requirements that are not needed
(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    car
    entrance exit park -block
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
    (stop ?c -car)
    (in-park ?c -car)
    (not-in-park ?c -car)
    (at-block ?c -car ?b -block)
    (not-in-block ?b - block)
    (attached ?from ?to - block)
)


(:functions ;todo: define numeric functions here
)

;define actions here
(:durative-action move
    :parameters (?c -car ?from ?to -block)
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
            (not-in-block ?to)
            (at-block ?c ?from)
            (stop ?c)
            (attached ?from ?to)

        ))

    )
    :effect (and 
        (at start (and 
            (not(stop ?c))
            (at-block ?c ?to)
            (not(at-block ?c ?from))
            (not-in-block ?from)
            (not(not-in-block ?to))
        ))
        (at end (and 
            (stop ?c)
        ))
    )
)

(:action go_in
    :parameters (?c -car ?p -park)
    :precondition (and 
        (not-in-park ?c)
        (stop ?c)
        (at-block ?c ?p)
    )
    :effect (and 
        (not(not-in-park ?c))
        (in-park ?c)
    )
)

(:action go_out
    :parameters (?c -car ?e -exit)
    :precondition (and 
        (in-park ?c)
        (stop ?c)
        (at-block ?c ?e)
    )
    :effect (and 
        (not(in-park ?c))
        (not(at-block ?c ?e))
        (not-in-park ?c)
    )
)



)