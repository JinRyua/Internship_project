(define (problem problem_fire) (:domain fire)
(:objects 
    acc1 acc2 acc3 -accident
    fst1 fst2 -firest
    hos1 hos2 -hosp
    firecar1 firecar2 -firecar
    rescar1 rescar2 -resque
    route12 route13 route14 route15 route16 route17 - route
    route23 route24 route25 route26 route27 -route
    route34 route35 route36 route37 - route
    route45 route46 route47 -route
    route56 route57 - route
    route67 - route
)

(:init
    (at-building firecar1 fst1)
    (at-building rescar1 hos1)
    (at-building firecar2 fst2)
    (at-building rescar2 hos2)

    (empty-car rescar1)
    (empty-car rescar2)
    (my-hospital rescar1 hos1)
    (my-hospital rescar2 hos2)
    
    
    (not-acting firecar1)
    (not-acting rescar1)
    (not-acting firecar2)
    (not-acting rescar2)

    (=(fire-size acc1)8)
    (=(fire-size acc2)4)
    (=(fire-size acc3)2)

    (ing-fire acc1)
    (ing-fire acc2)
    (ing-fire acc3)
    
    ;(not-fire acc2)
    ;(not-fire acc3)
    (not-fire fst1)
    (not-fire hos1)
    (not-fire fst2)
    (not-fire hos2)

    (exist-injure acc1)
    (exist-injure acc2)
    (exist-injure acc3)
    
    (not-injure fst1)
    (not-injure hos1)
    (not-injure fst2)
    (not-injure hos2)

    (=(distance route12)1)(=(distance route13)1)(=(distance route14)3)(=(distance route15)2)(=(distance route16)4)(=(distance route17)5)
    (=(distance route23)1)(=(distance route24)2)(=(distance route25)4)(=(distance route26)4)(=(distance route27)3)
    (=(distance route34)2)(=(distance route35)3)(=(distance route36)2)(=(distance route37)5)
    (=(distance route45)2)(=(distance route46)3)(=(distance route47)2)
    (=(distance route56)2)(=(distance route57)1)
    (=(distance route67)1)


    (route-between route12 fst1 hos1)(route-between route12 hos1 fst1)
    (route-between route13 fst1 acc1)(route-between route13 acc1 fst1)
    (route-between route14 fst1 acc2)(route-between route14 acc2 fst1)
    (route-between route15 fst1 acc3)(route-between route15 acc3 fst1)
    (route-between route16 fst1 fst2)(route-between route16 fst2 fst1)
    (route-between route17 fst1 hos2)(route-between route17 hos2 fst1)

    (route-between route23 hos1 acc1)(route-between route23 acc1 hos1)
    (route-between route24 hos1 acc2)(route-between route24 acc2 hos1)
    (route-between route25 hos1 acc3)(route-between route25 acc3 hos1)
    (route-between route26 hos1 fst2)(route-between route16 fst2 hos1)
    (route-between route27 hos1 hos2)(route-between route17 hos2 hos1)

    (route-between route34 acc1 acc2)(route-between route34 acc2 acc1)
    (route-between route35 acc1 acc3)(route-between route35 acc3 acc1)
    (route-between route36 acc1 fst2)(route-between route36 fst2 acc1)
    (route-between route37 acc1 hos2)(route-between route37 hos2 acc1)

    (route-between route45 acc2 acc3)(route-between route45 acc3 acc2)
    (route-between route46 acc2 fst2)(route-between route46 fst2 acc2)
    (route-between route47 acc2 hos2)(route-between route47 hos2 acc2)

    (route-between route56 acc3 fst2)(route-between route56 fst2 acc3)
    (route-between route57 acc3 hos2)(route-between route57 hos2 acc3)

    (route-between route67 fst2 hos2)(route-between route67 hos2 fst2)
    
    ;todo: put the initial state's facts and numeric values here
)

(:goal (and
    (at-building firecar1 fst1)
    (at-building firecar2 fst2)
    (at-building rescar1 hos1)
    (at-building rescar2 hos2)
    
    (not-fire acc1)(not-injure acc1)
    (not-fire acc2)(not-injure acc2)
    (not-fire acc3)(not-injure acc3)

    
    (empty-car rescar1)
    (empty-car rescar2)
    ;todo: put the goal condition here
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
