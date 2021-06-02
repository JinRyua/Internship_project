;Header and description

(define (domain mahjong)

;remove requirements that are not needed
(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    player ai field -character
    man tong sak east west north south white bal jung -card
    direction
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
    
    (fold ?ca -card)
    (s-color ?ca -card ?to -token)

    (is-dahai ?ca -card ?ch -character)
    (oya ?ch -character)
    (is-red-dora ?ca -card)
    (is-direction ?ch -character ?dir -direction)
    (have-card ?ca -card ?ch -character)
    (is-pong ?ca -card ?ch ?from -character)
    (is-chi ?ca -card ?ch ?from -character)
    (is-kakan ?ca -card ?ch ?from -character)
    (is-ankan ?ca -card ?ch ?from -character)
    (is-d ?ca -card ?ch ?from -character)
)


(:functions ;todo: define numeric functions here
    (need-token ?ca -card ?to -token)
    (s-point ?ca -card)
    (have-token ?ch -character ?to -token)

    (have-score ?ch -character)
    (kyoku)	;국
    (kyotaku)	;입금 스틱
    (honba) 	;본장
    (haiyama)	;남은 패
    (bakaze)	;바람(동풍,남풍)
)


;action
(:durative-action tsumo
    :parameters ()
    :duration (= ?duration 1)
    :condition (and 
        
    )
    :effect (and 
        
    )
)
(:durative-action dahai
    :parameters (?ca -card)
    :duration (= ?duration 1)
    :condition (and 
        
    )
    :effect (and 
        
    )
)
(:durative-action kakan
    :parameters (?ca -card)
    :duration (= ?duration 1)
    :condition (and 
        
    )
    :effect (and 
        
    )
)
(:durative-action ankan
    :parameters (?ca -card)
    :duration (= ?duration 1)
    :condition (and 
        
    )
    :effect (and 
        
    )
)
(:durative-action daiminkan
    :parameters (?ca -card)
    :duration (= ?duration 1)
    :condition (and 
        
    )
    :effect (and 
        
    )
)
(:durative-action reach
    :parameters (?ca -card)
    :duration (= ?duration 1)
    :condition (and 
        
    )
    :effect (and 
        
    )
)
(:durative-action chi
    :parameters (?dahai ?ca1 ?ca2 -card)
    :duration (= ?duration 1)
    :condition (and 
        
    )
    :effect (and 
        
    )
)
(:durative-action pon
    :parameters (?ca -card)
    :duration (= ?duration 1)
    :condition (and 
        
    )
    :effect (and 
        
    )
)


)
