(define (problem puzzle_problem) (:domain puzzle)
(:objects
	room1 room2 room3 room4 room5 room6 room7 room8 room9 - room
	num1 num2 num3 num4 num5 num6 num7 num8 - num
)

(:init
	(at num6 room1) (at num3 room2) (at num8 room3) 
	(at num2 room4) (at num7 room5) (at num4 room6) 
	(at num5 room7) (at num1 room8) 
	(empty room9)

	(adjacent room1 room2) (adjacent room1 room4) 
	(adjacent room2 room1) (adjacent room2 room3) (adjacent room2 room5) 
	(adjacent room3 room2) (adjacent room3 room6) 
	(adjacent room4 room1) (adjacent room4 room5) (adjacent room4 room7) 
	(adjacent room5 room2) (adjacent room5 room4) (adjacent room5 room6) (adjacent room5 room8) 
	(adjacent room6 room3) (adjacent room6 room5) (adjacent room6 room9) 
	(adjacent room7 room4) (adjacent room7 room8) 
	(adjacent room8 room5) (adjacent room8 room7) (adjacent room8 room9) 
	(adjacent room9 room6) (adjacent room9 room8) 
)

(:goal (and
	(at num1 room1) (at num2 room2) (at num3 room3) 
	(at num4 room4) (at num5 room5) (at num6 room6) 
	(at num7 room7) (at num8 room8) (empty room9)
))

)