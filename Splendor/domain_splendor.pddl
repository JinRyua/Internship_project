;Header and description

(define (domain splendor)

;remove requirements that are not needed
(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    player ai field -character
    nobility level1 level2 level3 -card
    token
    buylevel
    order
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
    (have-score ?ch -character)
)
(:durative-action three_coin
    :parameters (?get_arg1 ?get_arg2 ?get_arg3 ?abandon_arg1 ?abandon_arg2 ?abandon_arg3 -token)
    :duration (= ?duration 1)
    :condition (and 
        
    )
    :effect (and 
        
    )
)
(:durative-action two_coin
    :parameters (?get_arg1 -token)
    :duration (= ?duration 1)
    :condition (and 
        
    )
    :effect (and 
        
    )
)
(:durative-action buy
    :parameters (?get_arg1 -buylevel ?get_arg2 -order)
    :duration (= ?duration 1)
    :condition (and 
        
    )
    :effect (and 
        
    )
)


)
