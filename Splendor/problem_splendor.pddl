(define (problem problem_splendor) (:domain splendor)
(:objects
player1 -player
ai1 -ai
white blue green red black none -token
nobility_0 nobility_1 nobility_2 nobility_3 nobility_4 nobility_5 nobility_6 nobility_7 nobility_8 nobility_9 -nobility
level1_0 level1_1 level1_2 level1_3 level1_4 level1_5 level1_6 level1_7 level1_8 level1_9 level1_10 level1_11 level1_12 level1_13 level1_14 level1_15 level1_16 level1_17 level1_18 level1_19 level1_20 level1_21 level1_22 level1_23 level1_24 level1_25 level1_26 level1_27 level1_28 level1_29 level1_30 level1_31 level1_32 level1_33 level1_34 level1_35 level1_36 level1_37 level1_38 level1_39 -level1
level2_0 level2_1 level2_2 level2_3 level2_4 level2_5 level2_6 level2_7 level2_8 level2_9 level2_10 level2_11 level2_12 level2_13 level2_14 level2_15 level2_16 level2_17 level2_18 level2_19 level2_20 level2_21 level2_22 level2_23 level2_24 level2_25 level2_26 level2_27 level2_28 level2_29 -level2
level3_0 level3_1 level3_2 level3_3 level3_4 level3_5 level3_6 level3_7 level3_8 level3_9 level3_10 level3_11 level3_12 level3_13 level3_14 level3_15 level3_16 level3_17 level3_18 level3_19 -level3
order1 order2 order3 order4 -order
buy_level1 buy_level2 buy_level3 -buylevel
)
(:init
(fold nobility_0)
(=(s-point nobility_0) 3)
(=(need-token nobility_0 white) 0)
(=(need-token nobility_0 blue) 0)
(=(need-token nobility_0 green) 4)
(=(need-token nobility_0 red) 4)
(=(need-token nobility_0 black) 0)
(fold nobility_1)
(=(s-point nobility_1) 3)
(=(need-token nobility_1 white) 3)
(=(need-token nobility_1 blue) 0)
(=(need-token nobility_1 green) 0)
(=(need-token nobility_1 red) 3)
(=(need-token nobility_1 black) 3)
(fold nobility_2)
(=(s-point nobility_2) 3)
(=(need-token nobility_2 white) 4)
(=(need-token nobility_2 blue) 4)
(=(need-token nobility_2 green) 0)
(=(need-token nobility_2 red) 0)
(=(need-token nobility_2 black) 0)
(fold nobility_3)
(=(s-point nobility_3) 3)
(=(need-token nobility_3 white) 4)
(=(need-token nobility_3 blue) 0)
(=(need-token nobility_3 green) 0)
(=(need-token nobility_3 red) 0)
(=(need-token nobility_3 black) 4)
(fold nobility_4)
(=(s-point nobility_4) 3)
(=(need-token nobility_4 white) 0)
(=(need-token nobility_4 blue) 4)
(=(need-token nobility_4 green) 4)
(=(need-token nobility_4 red) 0)
(=(need-token nobility_4 black) 0)
(fold nobility_5)
(=(s-point nobility_5) 3)
(=(need-token nobility_5 white) 0)
(=(need-token nobility_5 blue) 3)
(=(need-token nobility_5 green) 3)
(=(need-token nobility_5 red) 3)
(=(need-token nobility_5 black) 0)
(fold nobility_6)
(=(s-point nobility_6) 3)
(=(need-token nobility_6 white) 3)
(=(need-token nobility_6 blue) 3)
(=(need-token nobility_6 green) 3)
(=(need-token nobility_6 red) 0)
(=(need-token nobility_6 black) 0)
(fold nobility_7)
(=(s-point nobility_7) 3)
(=(need-token nobility_7 white) 0)
(=(need-token nobility_7 blue) 0)
(=(need-token nobility_7 green) 0)
(=(need-token nobility_7 red) 4)
(=(need-token nobility_7 black) 4)
(fold nobility_8)
(=(s-point nobility_8) 3)
(=(need-token nobility_8 white) 3)
(=(need-token nobility_8 blue) 3)
(=(need-token nobility_8 green) 0)
(=(need-token nobility_8 red) 0)
(=(need-token nobility_8 black) 3)
(fold nobility_9)
(=(s-point nobility_9) 3)
(=(need-token nobility_9 white) 0)
(=(need-token nobility_9 blue) 0)
(=(need-token nobility_9 green) 3)
(=(need-token nobility_9 red) 3)
(=(need-token nobility_9 black) 3)
(fold level1_0)
(s-color level1_0 black)
(=(s-point level1_0) 0)
(=(need-token level1_0 white) 1)
(=(need-token level1_0 blue) 1)
(=(need-token level1_0 green) 1)
(=(need-token level1_0 red) 1)
(=(need-token level1_0 black) 0)
(fold level1_1)
(s-color level1_1 black)
(=(s-point level1_1) 0)
(=(need-token level1_1 white) 1)
(=(need-token level1_1 blue) 2)
(=(need-token level1_1 green) 1)
(=(need-token level1_1 red) 1)
(=(need-token level1_1 black) 0)
(fold level1_2)
(s-color level1_2 black)
(=(s-point level1_2) 0)
(=(need-token level1_2 white) 2)
(=(need-token level1_2 blue) 2)
(=(need-token level1_2 green) 0)
(=(need-token level1_2 red) 1)
(=(need-token level1_2 black) 0)
(fold level1_3)
(s-color level1_3 black)
(=(s-point level1_3) 0)
(=(need-token level1_3 white) 0)
(=(need-token level1_3 blue) 0)
(=(need-token level1_3 green) 1)
(=(need-token level1_3 red) 3)
(=(need-token level1_3 black) 1)
(fold level1_4)
(s-color level1_4 black)
(=(s-point level1_4) 0)
(=(need-token level1_4 white) 0)
(=(need-token level1_4 blue) 0)
(=(need-token level1_4 green) 2)
(=(need-token level1_4 red) 1)
(=(need-token level1_4 black) 0)
(fold level1_5)
(s-color level1_5 black)
(=(s-point level1_5) 0)
(=(need-token level1_5 white) 2)
(=(need-token level1_5 blue) 0)
(=(need-token level1_5 green) 2)
(=(need-token level1_5 red) 0)
(=(need-token level1_5 black) 0)
(fold level1_6)
(s-color level1_6 black)
(=(s-point level1_6) 0)
(=(need-token level1_6 white) 0)
(=(need-token level1_6 blue) 0)
(=(need-token level1_6 green) 3)
(=(need-token level1_6 red) 0)
(=(need-token level1_6 black) 0)
(fold level1_7)
(s-color level1_7 black)
(=(s-point level1_7) 1)
(=(need-token level1_7 white) 0)
(=(need-token level1_7 blue) 4)
(=(need-token level1_7 green) 0)
(=(need-token level1_7 red) 0)
(=(need-token level1_7 black) 0)
(fold level1_8)
(s-color level1_8 blue)
(=(s-point level1_8) 0)
(=(need-token level1_8 white) 1)
(=(need-token level1_8 blue) 0)
(=(need-token level1_8 green) 1)
(=(need-token level1_8 red) 1)
(=(need-token level1_8 black) 1)
(fold level1_9)
(s-color level1_9 blue)
(=(s-point level1_9) 0)
(=(need-token level1_9 white) 1)
(=(need-token level1_9 blue) 0)
(=(need-token level1_9 green) 1)
(=(need-token level1_9 red) 2)
(=(need-token level1_9 black) 1)
(fold level1_10)
(s-color level1_10 blue)
(=(s-point level1_10) 0)
(=(need-token level1_10 white) 1)
(=(need-token level1_10 blue) 0)
(=(need-token level1_10 green) 2)
(=(need-token level1_10 red) 2)
(=(need-token level1_10 black) 0)
(fold level1_11)
(s-color level1_11 blue)
(=(s-point level1_11) 0)
(=(need-token level1_11 white) 0)
(=(need-token level1_11 blue) 1)
(=(need-token level1_11 green) 3)
(=(need-token level1_11 red) 1)
(=(need-token level1_11 black) 0)
(fold level1_12)
(s-color level1_12 blue)
(=(s-point level1_12) 0)
(=(need-token level1_12 white) 1)
(=(need-token level1_12 blue) 0)
(=(need-token level1_12 green) 0)
(=(need-token level1_12 red) 0)
(=(need-token level1_12 black) 2)
(fold level1_13)
(s-color level1_13 blue)
(=(s-point level1_13) 0)
(=(need-token level1_13 white) 0)
(=(need-token level1_13 blue) 0)
(=(need-token level1_13 green) 2)
(=(need-token level1_13 red) 0)
(=(need-token level1_13 black) 2)
(fold level1_14)
(s-color level1_14 blue)
(=(s-point level1_14) 0)
(=(need-token level1_14 white) 0)
(=(need-token level1_14 blue) 0)
(=(need-token level1_14 green) 0)
(=(need-token level1_14 red) 0)
(=(need-token level1_14 black) 3)
(fold level1_15)
(s-color level1_15 blue)
(=(s-point level1_15) 1)
(=(need-token level1_15 white) 0)
(=(need-token level1_15 blue) 0)
(=(need-token level1_15 green) 0)
(=(need-token level1_15 red) 4)
(=(need-token level1_15 black) 0)
(fold level1_16)
(s-color level1_16 white)
(=(s-point level1_16) 0)
(=(need-token level1_16 white) 0)
(=(need-token level1_16 blue) 1)
(=(need-token level1_16 green) 1)
(=(need-token level1_16 red) 1)
(=(need-token level1_16 black) 1)
(fold level1_17)
(s-color level1_17 white)
(=(s-point level1_17) 0)
(=(need-token level1_17 white) 0)
(=(need-token level1_17 blue) 1)
(=(need-token level1_17 green) 2)
(=(need-token level1_17 red) 1)
(=(need-token level1_17 black) 1)
(fold level1_18)
(s-color level1_18 white)
(=(s-point level1_18) 0)
(=(need-token level1_18 white) 0)
(=(need-token level1_18 blue) 2)
(=(need-token level1_18 green) 2)
(=(need-token level1_18 red) 0)
(=(need-token level1_18 black) 1)
(fold level1_19)
(s-color level1_19 white)
(=(s-point level1_19) 0)
(=(need-token level1_19 white) 3)
(=(need-token level1_19 blue) 1)
(=(need-token level1_19 green) 0)
(=(need-token level1_19 red) 0)
(=(need-token level1_19 black) 1)
(fold level1_20)
(s-color level1_20 white)
(=(s-point level1_20) 0)
(=(need-token level1_20 white) 0)
(=(need-token level1_20 blue) 0)
(=(need-token level1_20 green) 0)
(=(need-token level1_20 red) 2)
(=(need-token level1_20 black) 1)
(fold level1_21)
(s-color level1_21 white)
(=(s-point level1_21) 0)
(=(need-token level1_21 white) 0)
(=(need-token level1_21 blue) 2)
(=(need-token level1_21 green) 0)
(=(need-token level1_21 red) 0)
(=(need-token level1_21 black) 2)
(fold level1_22)
(s-color level1_22 white)
(=(s-point level1_22) 0)
(=(need-token level1_22 white) 0)
(=(need-token level1_22 blue) 3)
(=(need-token level1_22 green) 0)
(=(need-token level1_22 red) 0)
(=(need-token level1_22 black) 0)
(fold level1_23)
(s-color level1_23 white)
(=(s-point level1_23) 1)
(=(need-token level1_23 white) 0)
(=(need-token level1_23 blue) 0)
(=(need-token level1_23 green) 4)
(=(need-token level1_23 red) 0)
(=(need-token level1_23 black) 0)
(fold level1_24)
(s-color level1_24 green)
(=(s-point level1_24) 0)
(=(need-token level1_24 white) 1)
(=(need-token level1_24 blue) 1)
(=(need-token level1_24 green) 0)
(=(need-token level1_24 red) 1)
(=(need-token level1_24 black) 1)
(fold level1_25)
(s-color level1_25 green)
(=(s-point level1_25) 0)
(=(need-token level1_25 white) 1)
(=(need-token level1_25 blue) 1)
(=(need-token level1_25 green) 0)
(=(need-token level1_25 red) 1)
(=(need-token level1_25 black) 2)
(fold level1_26)
(s-color level1_26 green)
(=(s-point level1_26) 0)
(=(need-token level1_26 white) 0)
(=(need-token level1_26 blue) 1)
(=(need-token level1_26 green) 0)
(=(need-token level1_26 red) 2)
(=(need-token level1_26 black) 2)
(fold level1_27)
(s-color level1_27 green)
(=(s-point level1_27) 0)
(=(need-token level1_27 white) 1)
(=(need-token level1_27 blue) 3)
(=(need-token level1_27 green) 1)
(=(need-token level1_27 red) 0)
(=(need-token level1_27 black) 0)
(fold level1_28)
(s-color level1_28 green)
(=(s-point level1_28) 0)
(=(need-token level1_28 white) 2)
(=(need-token level1_28 blue) 1)
(=(need-token level1_28 green) 0)
(=(need-token level1_28 red) 0)
(=(need-token level1_28 black) 0)
(fold level1_29)
(s-color level1_29 green)
(=(s-point level1_29) 0)
(=(need-token level1_29 white) 0)
(=(need-token level1_29 blue) 2)
(=(need-token level1_29 green) 0)
(=(need-token level1_29 red) 2)
(=(need-token level1_29 black) 0)
(fold level1_30)
(s-color level1_30 green)
(=(s-point level1_30) 0)
(=(need-token level1_30 white) 0)
(=(need-token level1_30 blue) 0)
(=(need-token level1_30 green) 0)
(=(need-token level1_30 red) 3)
(=(need-token level1_30 black) 0)
(fold level1_31)
(s-color level1_31 green)
(=(s-point level1_31) 1)
(=(need-token level1_31 white) 0)
(=(need-token level1_31 blue) 0)
(=(need-token level1_31 green) 0)
(=(need-token level1_31 red) 0)
(=(need-token level1_31 black) 4)
(fold level1_32)
(s-color level1_32 red)
(=(s-point level1_32) 0)
(=(need-token level1_32 white) 1)
(=(need-token level1_32 blue) 1)
(=(need-token level1_32 green) 1)
(=(need-token level1_32 red) 0)
(=(need-token level1_32 black) 1)
(fold level1_33)
(s-color level1_33 red)
(=(s-point level1_33) 0)
(=(need-token level1_33 white) 2)
(=(need-token level1_33 blue) 1)
(=(need-token level1_33 green) 1)
(=(need-token level1_33 red) 0)
(=(need-token level1_33 black) 1)
(fold level1_34)
(s-color level1_34 red)
(=(s-point level1_34) 0)
(=(need-token level1_34 white) 2)
(=(need-token level1_34 blue) 0)
(=(need-token level1_34 green) 1)
(=(need-token level1_34 red) 0)
(=(need-token level1_34 black) 2)
(fold level1_35)
(s-color level1_35 red)
(=(s-point level1_35) 0)
(=(need-token level1_35 white) 1)
(=(need-token level1_35 blue) 0)
(=(need-token level1_35 green) 0)
(=(need-token level1_35 red) 1)
(=(need-token level1_35 black) 3)
(fold level1_36)
(s-color level1_36 red)
(=(s-point level1_36) 0)
(=(need-token level1_36 white) 0)
(=(need-token level1_36 blue) 2)
(=(need-token level1_36 green) 1)
(=(need-token level1_36 red) 0)
(=(need-token level1_36 black) 0)
(fold level1_37)
(s-color level1_37 red)
(=(s-point level1_37) 0)
(=(need-token level1_37 white) 2)
(=(need-token level1_37 blue) 0)
(=(need-token level1_37 green) 0)
(=(need-token level1_37 red) 2)
(=(need-token level1_37 black) 0)
(fold level1_38)
(s-color level1_38 red)
(=(s-point level1_38) 0)
(=(need-token level1_38 white) 3)
(=(need-token level1_38 blue) 0)
(=(need-token level1_38 green) 0)
(=(need-token level1_38 red) 0)
(=(need-token level1_38 black) 0)
(fold level1_39)
(s-color level1_39 red)
(=(s-point level1_39) 1)
(=(need-token level1_39 white) 4)
(=(need-token level1_39 blue) 0)
(=(need-token level1_39 green) 0)
(=(need-token level1_39 red) 0)
(=(need-token level1_39 black) 0)
(fold level2_0)
(s-color level2_0 black)
(=(s-point level2_0) 1)
(=(need-token level2_0 white) 3)
(=(need-token level2_0 blue) 2)
(=(need-token level2_0 green) 2)
(=(need-token level2_0 red) 0)
(=(need-token level2_0 black) 0)
(fold level2_1)
(s-color level2_1 black)
(=(s-point level2_1) 1)
(=(need-token level2_1 white) 3)
(=(need-token level2_1 blue) 0)
(=(need-token level2_1 green) 3)
(=(need-token level2_1 red) 0)
(=(need-token level2_1 black) 2)
(fold level2_2)
(s-color level2_2 black)
(=(s-point level2_2) 2)
(=(need-token level2_2 white) 0)
(=(need-token level2_2 blue) 1)
(=(need-token level2_2 green) 4)
(=(need-token level2_2 red) 2)
(=(need-token level2_2 black) 0)
(fold level2_3)
(s-color level2_3 black)
(=(s-point level2_3) 2)
(=(need-token level2_3 white) 0)
(=(need-token level2_3 blue) 0)
(=(need-token level2_3 green) 5)
(=(need-token level2_3 red) 3)
(=(need-token level2_3 black) 0)
(fold level2_4)
(s-color level2_4 black)
(=(s-point level2_4) 2)
(=(need-token level2_4 white) 5)
(=(need-token level2_4 blue) 0)
(=(need-token level2_4 green) 0)
(=(need-token level2_4 red) 0)
(=(need-token level2_4 black) 0)
(fold level2_5)
(s-color level2_5 black)
(=(s-point level2_5) 3)
(=(need-token level2_5 white) 0)
(=(need-token level2_5 blue) 0)
(=(need-token level2_5 green) 0)
(=(need-token level2_5 red) 0)
(=(need-token level2_5 black) 6)
(fold level2_6)
(s-color level2_6 blue)
(=(s-point level2_6) 1)
(=(need-token level2_6 white) 0)
(=(need-token level2_6 blue) 2)
(=(need-token level2_6 green) 2)
(=(need-token level2_6 red) 3)
(=(need-token level2_6 black) 0)
(fold level2_7)
(s-color level2_7 blue)
(=(s-point level2_7) 1)
(=(need-token level2_7 white) 0)
(=(need-token level2_7 blue) 2)
(=(need-token level2_7 green) 3)
(=(need-token level2_7 red) 0)
(=(need-token level2_7 black) 3)
(fold level2_8)
(s-color level2_8 blue)
(=(s-point level2_8) 2)
(=(need-token level2_8 white) 5)
(=(need-token level2_8 blue) 3)
(=(need-token level2_8 green) 0)
(=(need-token level2_8 red) 0)
(=(need-token level2_8 black) 0)
(fold level2_9)
(s-color level2_9 blue)
(=(s-point level2_9) 2)
(=(need-token level2_9 white) 2)
(=(need-token level2_9 blue) 0)
(=(need-token level2_9 green) 0)
(=(need-token level2_9 red) 1)
(=(need-token level2_9 black) 4)
(fold level2_10)
(s-color level2_10 blue)
(=(s-point level2_10) 2)
(=(need-token level2_10 white) 0)
(=(need-token level2_10 blue) 5)
(=(need-token level2_10 green) 0)
(=(need-token level2_10 red) 0)
(=(need-token level2_10 black) 0)
(fold level2_11)
(s-color level2_11 blue)
(=(s-point level2_11) 3)
(=(need-token level2_11 white) 0)
(=(need-token level2_11 blue) 6)
(=(need-token level2_11 green) 0)
(=(need-token level2_11 red) 0)
(=(need-token level2_11 black) 0)
(fold level2_12)
(s-color level2_12 white)
(=(s-point level2_12) 1)
(=(need-token level2_12 white) 0)
(=(need-token level2_12 blue) 0)
(=(need-token level2_12 green) 3)
(=(need-token level2_12 red) 2)
(=(need-token level2_12 black) 2)
(fold level2_13)
(s-color level2_13 white)
(=(s-point level2_13) 1)
(=(need-token level2_13 white) 2)
(=(need-token level2_13 blue) 3)
(=(need-token level2_13 green) 0)
(=(need-token level2_13 red) 3)
(=(need-token level2_13 black) 0)
(fold level2_14)
(s-color level2_14 white)
(=(s-point level2_14) 2)
(=(need-token level2_14 white) 0)
(=(need-token level2_14 blue) 0)
(=(need-token level2_14 green) 1)
(=(need-token level2_14 red) 4)
(=(need-token level2_14 black) 2)
(fold level2_15)
(s-color level2_15 white)
(=(s-point level2_15) 2)
(=(need-token level2_15 white) 0)
(=(need-token level2_15 blue) 0)
(=(need-token level2_15 green) 0)
(=(need-token level2_15 red) 5)
(=(need-token level2_15 black) 3)
(fold level2_16)
(s-color level2_16 white)
(=(s-point level2_16) 2)
(=(need-token level2_16 white) 0)
(=(need-token level2_16 blue) 0)
(=(need-token level2_16 green) 0)
(=(need-token level2_16 red) 5)
(=(need-token level2_16 black) 0)
(fold level2_17)
(s-color level2_17 white)
(=(s-point level2_17) 3)
(=(need-token level2_17 white) 6)
(=(need-token level2_17 blue) 0)
(=(need-token level2_17 green) 0)
(=(need-token level2_17 red) 0)
(=(need-token level2_17 black) 0)
(fold level2_18)
(s-color level2_18 green)
(=(s-point level2_18) 1)
(=(need-token level2_18 white) 3)
(=(need-token level2_18 blue) 0)
(=(need-token level2_18 green) 2)
(=(need-token level2_18 red) 3)
(=(need-token level2_18 black) 0)
(fold level2_19)
(s-color level2_19 green)
(=(s-point level2_19) 1)
(=(need-token level2_19 white) 2)
(=(need-token level2_19 blue) 3)
(=(need-token level2_19 green) 0)
(=(need-token level2_19 red) 0)
(=(need-token level2_19 black) 2)
(fold level2_20)
(s-color level2_20 green)
(=(s-point level2_20) 2)
(=(need-token level2_20 white) 4)
(=(need-token level2_20 blue) 2)
(=(need-token level2_20 green) 0)
(=(need-token level2_20 red) 0)
(=(need-token level2_20 black) 1)
(fold level2_21)
(s-color level2_21 green)
(=(s-point level2_21) 2)
(=(need-token level2_21 white) 0)
(=(need-token level2_21 blue) 5)
(=(need-token level2_21 green) 3)
(=(need-token level2_21 red) 0)
(=(need-token level2_21 black) 0)
(fold level2_22)
(s-color level2_22 green)
(=(s-point level2_22) 2)
(=(need-token level2_22 white) 0)
(=(need-token level2_22 blue) 0)
(=(need-token level2_22 green) 5)
(=(need-token level2_22 red) 0)
(=(need-token level2_22 black) 0)
(fold level2_23)
(s-color level2_23 green)
(=(s-point level2_23) 3)
(=(need-token level2_23 white) 0)
(=(need-token level2_23 blue) 0)
(=(need-token level2_23 green) 6)
(=(need-token level2_23 red) 0)
(=(need-token level2_23 black) 0)
(fold level2_24)
(s-color level2_24 red)
(=(s-point level2_24) 1)
(=(need-token level2_24 white) 2)
(=(need-token level2_24 blue) 0)
(=(need-token level2_24 green) 0)
(=(need-token level2_24 red) 2)
(=(need-token level2_24 black) 3)
(fold level2_25)
(s-color level2_25 red)
(=(s-point level2_25) 1)
(=(need-token level2_25 white) 0)
(=(need-token level2_25 blue) 3)
(=(need-token level2_25 green) 0)
(=(need-token level2_25 red) 2)
(=(need-token level2_25 black) 3)
(fold level2_26)
(s-color level2_26 red)
(=(s-point level2_26) 2)
(=(need-token level2_26 white) 1)
(=(need-token level2_26 blue) 4)
(=(need-token level2_26 green) 2)
(=(need-token level2_26 red) 0)
(=(need-token level2_26 black) 0)
(fold level2_27)
(s-color level2_27 red)
(=(s-point level2_27) 2)
(=(need-token level2_27 white) 3)
(=(need-token level2_27 blue) 0)
(=(need-token level2_27 green) 0)
(=(need-token level2_27 red) 0)
(=(need-token level2_27 black) 5)
(fold level2_28)
(s-color level2_28 red)
(=(s-point level2_28) 2)
(=(need-token level2_28 white) 0)
(=(need-token level2_28 blue) 0)
(=(need-token level2_28 green) 0)
(=(need-token level2_28 red) 0)
(=(need-token level2_28 black) 5)
(fold level2_29)
(s-color level2_29 red)
(=(s-point level2_29) 3)
(=(need-token level2_29 white) 0)
(=(need-token level2_29 blue) 0)
(=(need-token level2_29 green) 0)
(=(need-token level2_29 red) 6)
(=(need-token level2_29 black) 0)
(fold level3_0)
(s-color level3_0 black)
(=(s-point level3_0) 3)
(=(need-token level3_0 white) 3)
(=(need-token level3_0 blue) 3)
(=(need-token level3_0 green) 5)
(=(need-token level3_0 red) 3)
(=(need-token level3_0 black) 0)
(fold level3_1)
(s-color level3_1 black)
(=(s-point level3_1) 4)
(=(need-token level3_1 white) 0)
(=(need-token level3_1 blue) 0)
(=(need-token level3_1 green) 0)
(=(need-token level3_1 red) 7)
(=(need-token level3_1 black) 0)
(fold level3_2)
(s-color level3_2 black)
(=(s-point level3_2) 4)
(=(need-token level3_2 white) 0)
(=(need-token level3_2 blue) 0)
(=(need-token level3_2 green) 3)
(=(need-token level3_2 red) 6)
(=(need-token level3_2 black) 3)
(fold level3_3)
(s-color level3_3 black)
(=(s-point level3_3) 5)
(=(need-token level3_3 white) 0)
(=(need-token level3_3 blue) 0)
(=(need-token level3_3 green) 0)
(=(need-token level3_3 red) 7)
(=(need-token level3_3 black) 3)
(fold level3_4)
(s-color level3_4 blue)
(=(s-point level3_4) 3)
(=(need-token level3_4 white) 3)
(=(need-token level3_4 blue) 0)
(=(need-token level3_4 green) 3)
(=(need-token level3_4 red) 3)
(=(need-token level3_4 black) 5)
(fold level3_5)
(s-color level3_5 blue)
(=(s-point level3_5) 4)
(=(need-token level3_5 white) 7)
(=(need-token level3_5 blue) 0)
(=(need-token level3_5 green) 0)
(=(need-token level3_5 red) 0)
(=(need-token level3_5 black) 0)
(fold level3_6)
(s-color level3_6 blue)
(=(s-point level3_6) 4)
(=(need-token level3_6 white) 6)
(=(need-token level3_6 blue) 3)
(=(need-token level3_6 green) 0)
(=(need-token level3_6 red) 0)
(=(need-token level3_6 black) 3)
(fold level3_7)
(s-color level3_7 blue)
(=(s-point level3_7) 5)
(=(need-token level3_7 white) 7)
(=(need-token level3_7 blue) 3)
(=(need-token level3_7 green) 0)
(=(need-token level3_7 red) 0)
(=(need-token level3_7 black) 0)
(fold level3_8)
(s-color level3_8 white)
(=(s-point level3_8) 3)
(=(need-token level3_8 white) 0)
(=(need-token level3_8 blue) 3)
(=(need-token level3_8 green) 3)
(=(need-token level3_8 red) 5)
(=(need-token level3_8 black) 3)
(fold level3_9)
(s-color level3_9 white)
(=(s-point level3_9) 4)
(=(need-token level3_9 white) 0)
(=(need-token level3_9 blue) 0)
(=(need-token level3_9 green) 0)
(=(need-token level3_9 red) 0)
(=(need-token level3_9 black) 7)
(fold level3_10)
(s-color level3_10 white)
(=(s-point level3_10) 4)
(=(need-token level3_10 white) 3)
(=(need-token level3_10 blue) 0)
(=(need-token level3_10 green) 0)
(=(need-token level3_10 red) 3)
(=(need-token level3_10 black) 6)
(fold level3_11)
(s-color level3_11 white)
(=(s-point level3_11) 5)
(=(need-token level3_11 white) 3)
(=(need-token level3_11 blue) 0)
(=(need-token level3_11 green) 0)
(=(need-token level3_11 red) 0)
(=(need-token level3_11 black) 7)
(fold level3_12)
(s-color level3_12 green)
(=(s-point level3_12) 3)
(=(need-token level3_12 white) 5)
(=(need-token level3_12 blue) 3)
(=(need-token level3_12 green) 0)
(=(need-token level3_12 red) 3)
(=(need-token level3_12 black) 3)
(fold level3_13)
(s-color level3_13 green)
(=(s-point level3_13) 4)
(=(need-token level3_13 white) 0)
(=(need-token level3_13 blue) 7)
(=(need-token level3_13 green) 0)
(=(need-token level3_13 red) 0)
(=(need-token level3_13 black) 0)
(fold level3_14)
(s-color level3_14 green)
(=(s-point level3_14) 4)
(=(need-token level3_14 white) 3)
(=(need-token level3_14 blue) 6)
(=(need-token level3_14 green) 3)
(=(need-token level3_14 red) 0)
(=(need-token level3_14 black) 0)
(fold level3_15)
(s-color level3_15 green)
(=(s-point level3_15) 5)
(=(need-token level3_15 white) 0)
(=(need-token level3_15 blue) 7)
(=(need-token level3_15 green) 3)
(=(need-token level3_15 red) 0)
(=(need-token level3_15 black) 0)
(fold level3_16)
(s-color level3_16 red)
(=(s-point level3_16) 3)
(=(need-token level3_16 white) 3)
(=(need-token level3_16 blue) 5)
(=(need-token level3_16 green) 3)
(=(need-token level3_16 red) 0)
(=(need-token level3_16 black) 3)
(fold level3_17)
(s-color level3_17 red)
(=(s-point level3_17) 4)
(=(need-token level3_17 white) 0)
(=(need-token level3_17 blue) 0)
(=(need-token level3_17 green) 7)
(=(need-token level3_17 red) 0)
(=(need-token level3_17 black) 0)
(fold level3_18)
(s-color level3_18 red)
(=(s-point level3_18) 4)
(=(need-token level3_18 white) 0)
(=(need-token level3_18 blue) 3)
(=(need-token level3_18 green) 6)
(=(need-token level3_18 red) 3)
(=(need-token level3_18 black) 0)
(fold level3_19)
(s-color level3_19 red)
(=(s-point level3_19) 5)
(=(need-token level3_19 white) 0)
(=(need-token level3_19 blue) 0)
(=(need-token level3_19 green) 7)
(=(need-token level3_19 red) 3)
(=(need-token level3_19 black) 0)
(=(have-token field white) 4)
(=(have-token field blue) 4)
(=(have-token field green) 4)
(=(have-token field red) 4)
(=(have-token field black) 4)
(=(have-token ai1 white) 0)
(=(have-token ai1 blue) 0)
(=(have-token ai1 green) 0)
(=(have-token ai1 red) 0)
(=(have-token ai1 black) 0)
(=(have-token player1 white) 0)
(=(have-token player1 blue) 0)
(=(have-token player1 green) 0)
(=(have-token player1 red) 0)
(=(have-token player1 black) 0)
(=(have-score player1) 0) 
(=(have-score ai1) 0)
)
(:goal (and
(=(timer)4)
))
)
