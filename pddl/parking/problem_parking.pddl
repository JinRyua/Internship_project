(define (problem problem_parking) (:domain parking)
(:objects 
    car1 car2 car3 car4 car5 -car
    entrance1 entrance2 entrance3 entrance4 -entrance
    exit -exit
    park11 park12 park13 park21 park22 park23 park31 park32 park33 -park
)

(:init
    
    (stop car1)
    (stop car2)
    (stop car3)
    (stop car4)
    (stop car5)
    ;(at 3(stop car5))

    (not-in-park car1)
    (not-in-park car2)
    (not-in-park car3)
    (not-in-park car4)
    ;(in-park car1)
    (in-park car5)

    (at-block car1 entrance1)
    (at-block car2 entrance2)
    (at-block car3 entrance3)
    (at-block car4 entrance4)
    (at-block car5 park23)
    ;(at-block car1 park22)
    
    ;(not-in-block entrance1)
    ;(not-in-block entrance2)
    ;(not-in-block entrance3)
    ;(not-in-block entrance4)
    (not-in-block exit)
    (not-in-block park11)
    (not-in-block park12)
    (not-in-block park13)
    (not-in-block park21)
    (not-in-block park22)
    ;(not-in-block park23)
    (not-in-block park31)
    (not-in-block park32)
    (not-in-block park33)

    (attached entrance1 entrance2)(attached entrance1 park31)
    (attached entrance2 entrance1)(attached entrance2 entrance3)
    (attached entrance3 entrance2)(attached entrance3 entrance4)
    (attached entrance4 entrance3)
    (attached exit park32)
    
    (attached park11 park12)(attached park11 park21)
    (attached park12 park13)(attached park12 park11)(attached park12 park22)
    (attached park13 park12)(attached park13 park23)
    (attached park21 park11)(attached park21 park22)(attached park21 park31)
    (attached park22 park21)(attached park22 park12)(attached park22 park23)(attached park22 park32)
    (attached park23 park13)(attached park23 park22)(attached park23 park33)
    (attached park31 park21)(attached park31 entrance1)
    (attached park32 park22)(attached park32 exit)(attached park32 park33)
    (attached park33 park32)(attached park33 park23)
    ;todo: put the initial state's facts and numeric values here
)

(:goal (and
    ;todo: put the goal condition here
    (in-park car1)
    (at-block car1 park13)
    (in-park car2)
    (at-block car2 park23)
    (in-park car3)
    (at-block car3 park33)
    (in-park car4)
    (not-in-park car5)
    ;(at-block car1 park23)
    ;(at-block car5 park22)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
