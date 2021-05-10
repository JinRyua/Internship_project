;Header and description

(define (domain splendor)

;remove requirements that are not needed
(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    player ai field -character
    nobility level1 level2 level3 -card
    token
    action
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
    (have-card ?ch -character ?ca -card)
    (fold ?ca -card)
    (s-color ?ca -card ?to -token)
)


(:functions ;todo: define numeric functions here
    (need-token ?ca -card ?to -token)
    (s-point ?ca -card)
    (have-token ?ch -character ?to -token)
)
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
