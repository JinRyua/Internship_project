(define (problem problem_pacman) (:domain pacman)
(:objects
    p -player
    agent1 agent2 agent3 agent4 -agent
    point1_1 point1_2 point1_3 point1_4 point1_5 point1_6 point1_7 point1_8 point1_9 point1_10 point1_11 point1_12 point1_13 point1_14 point1_15 point1_16 point1_17 point1_18 point1_19 point1_20 point1_21 -point
    point2_1 point2_2 point2_3 point2_4 point2_5 point2_6 point2_7 point2_8 point2_9 point2_10 point2_11 point2_12 point2_13 point2_14 point2_15 point2_16 point2_17 point2_18 point2_19 point2_20 point2_21 -point
    point3_1 point3_2 point3_3 point3_4 point3_5 point3_6 point3_7 point3_8 point3_9 point3_10 point3_11 point3_12 point3_13 point3_14 point3_15 point3_16 point3_17 point3_18 point3_19 point3_20 point3_21 -point
    point4_1 point4_2 point4_3 point4_4 point4_5 point4_6 point4_7 point4_8 point4_9 point4_10 point4_11 point4_12 point4_13 point4_14 point4_15 point4_16 point4_17 point4_18 point4_19 point4_20 point4_21 -point
    point5_1 point5_2 point5_3 point5_4 point5_5 point5_6 point5_7 point5_8 point5_9 point5_10 point5_11 point5_12 point5_13 point5_14 point5_15 point5_16 point5_17 point5_18 point5_19 point5_20 point5_21 -point
    point6_1 point6_2 point6_3 point6_4 point6_5 point6_6 point6_7 point6_8 point6_9 point6_10 point6_11 point6_12 point6_13 point6_14 point6_15 point6_16 point6_17 point6_18 point6_19 point6_20 point6_21 -point
    point7_1 point7_2 point7_3 point7_4 point7_5 point7_6 point7_7 point7_8 point7_9 point7_10 point7_11 point7_12 point7_13 point7_14 point7_15 point7_16 point7_17 point7_18 point7_19 point7_20 point7_21 -point
    point8_1 point8_2 point8_3 point8_4 point8_5 point8_6 point8_7 point8_8 point8_9 point8_10 point8_11 point8_12 point8_13 point8_14 point8_15 point8_16 point8_17 point8_18 point8_19 point8_20 point8_21 -point
    point9_1 point9_2 point9_3 point9_4 point9_5 point9_6 point9_7 point9_8 point9_9 point9_10 point9_11 point9_12 point9_13 point9_14 point9_15 point9_16 point9_17 point9_18 point9_19 point9_20 point9_21 -point
    point10_1 point10_2 point10_3 point10_4 point10_5 point10_6 point10_7 point10_8 point10_9 point10_10 point10_11 point10_12 point10_13 point10_14 point10_15 point10_16 point10_17 point10_18 point10_19 point10_20 point10_21 -point
    point11_1 point11_2 point11_3 point11_4 point11_5 point11_6 point11_7 point11_8 point11_9 point11_10 point11_11 point11_12 point11_13 point11_14 point11_15 point11_16 point11_17 point11_18 point11_19 point11_20 point11_21 -point
    point12_1 point12_2 point12_3 point12_4 point12_5 point12_6 point12_7 point12_8 point12_9 point12_10 point12_11 point12_12 point12_13 point12_14 point12_15 point12_16 point12_17 point12_18 point12_19 point12_20 point12_21 -point
    point13_1 point13_2 point13_3 point13_4 point13_5 point13_6 point13_7 point13_8 point13_9 point13_10 point13_11 point13_12 point13_13 point13_14 point13_15 point13_16 point13_17 point13_18 point13_19 point13_20 point13_21 -point
    point14_1 point14_2 point14_3 point14_4 point14_5 point14_6 point14_7 point14_8 point14_9 point14_10 point14_11 point14_12 point14_13 point14_14 point14_15 point14_16 point14_17 point14_18 point14_19 point14_20 point14_21 -point
    point15_1 point15_2 point15_3 point15_4 point15_5 point15_6 point15_7 point15_8 point15_9 point15_10 point15_11 point15_12 point15_13 point15_14 point15_15 point15_16 point15_17 point15_18 point15_19 point15_20 point15_21 -point
    point16_1 point16_2 point16_3 point16_4 point16_5 point16_6 point16_7 point16_8 point16_9 point16_10 point16_11 point16_12 point16_13 point16_14 point16_15 point16_16 point16_17 point16_18 point16_19 point16_20 point16_21 -point
    point17_1 point17_2 point17_3 point17_4 point17_5 point17_6 point17_7 point17_8 point17_9 point17_10 point17_11 point17_12 point17_13 point17_14 point17_15 point17_16 point17_17 point17_18 point17_19 point17_20 point17_21 -point
    point18_1 point18_2 point18_3 point18_4 point18_5 point18_6 point18_7 point18_8 point18_9 point18_10 point18_11 point18_12 point18_13 point18_14 point18_15 point18_16 point18_17 point18_18 point18_19 point18_20 point18_21 -point
    point19_1 point19_2 point19_3 point19_4 point19_5 point19_6 point19_7 point19_8 point19_9 point19_10 point19_11 point19_12 point19_13 point19_14 point19_15 point19_16 point19_17 point19_18 point19_19 point19_20 point19_21 -point
    point20_1 point20_2 point20_3 point20_4 point20_5 point20_6 point20_7 point20_8 point20_9 point20_10 point20_11 point20_12 point20_13 point20_14 point20_15 point20_16 point20_17 point20_18 point20_19 point20_20 point20_21 -point
    point21_1 point21_2 point21_3 point21_4 point21_5 point21_6 point21_7 point21_8 point21_9 point21_10 point21_11 point21_12 point21_13 point21_14 point21_15 point21_16 point21_17 point21_18 point21_19 point21_20 point21_21 -point
    point22_1 point22_2 point22_3 point22_4 point22_5 point22_6 point22_7 point22_8 point22_9 point22_10 point22_11 point22_12 point22_13 point22_14 point22_15 point22_16 point22_17 point22_18 point22_19 point22_20 point22_21 -point
    point23_1 point23_2 point23_3 point23_4 point23_5 point23_6 point23_7 point23_8 point23_9 point23_10 point23_11 point23_12 point23_13 point23_14 point23_15 point23_16 point23_17 point23_18 point23_19 point23_20 point23_21 -point
    point24_1 point24_2 point24_3 point24_4 point24_5 point24_6 point24_7 point24_8 point24_9 point24_10 point24_11 point24_12 point24_13 point24_14 point24_15 point24_16 point24_17 point24_18 point24_19 point24_20 point24_21 -point
    point25_1 point25_2 point25_3 point25_4 point25_5 point25_6 point25_7 point25_8 point25_9 point25_10 point25_11 point25_12 point25_13 point25_14 point25_15 point25_16 point25_17 point25_18 point25_19 point25_20 point25_21 -point
    point26_1 point26_2 point26_3 point26_4 point26_5 point26_6 point26_7 point26_8 point26_9 point26_10 point26_11 point26_12 point26_13 point26_14 point26_15 point26_16 point26_17 point26_18 point26_19 point26_20 point26_21 -point
    point27_1 point27_2 point27_3 point27_4 point27_5 point27_6 point27_7 point27_8 point27_9 point27_10 point27_11 point27_12 point27_13 point27_14 point27_15 point27_16 point27_17 point27_18 point27_19 point27_20 point27_21 -point  
    act_1 act_2 act_3 act_4 act_5 -action
)

(:init
( in-block player point21_11 )
(=(direction player)1 )
( in-block agent1 point11_11 )
(=(direction agent1)1)
( in-block agent2 point11_11 )
(=(direction agent2)1)
( in-block agent3 point11_11 )
(=(direction agent3)1)
( in-block agent4 point11_11 )
(=(direction agent4)1)
(=(row)27)
(=(col)21)
(=(timer)3)
(is-wall point1_1 )
(is-wall point1_2 )
(is-wall point1_3 )
(is-wall point1_4 )
(is-wall point1_5 )
(is-wall point1_6 )
(is-wall point1_7 )
(is-wall point1_8 )
(is-wall point1_9 )
(is-wall point1_10 )
(is-wall point1_11 )
(is-wall point1_12 )
(is-wall point1_13 )
(is-wall point1_14 )
(is-wall point1_15 )
(is-wall point1_16 )
(is-wall point1_17 )
(is-wall point1_18 )
(is-wall point1_19 )
(is-wall point1_20 )
(is-wall point1_21 )
(is-wall point2_1 )
(is-wall point2_11 )
(is-wall point2_21 )
(is-wall point3_1 )
(is-wall point3_3 )
(is-wall point3_4 )
(is-wall point3_5 )
(is-wall point3_7 )
(is-wall point3_8 )
(is-wall point3_9 )
(is-wall point3_11 )
(is-wall point3_13 )
(is-wall point3_14 )
(is-wall point3_15 )
(is-wall point3_17 )
(is-wall point3_18 )
(is-wall point3_19 )
(is-wall point3_21 )
(is-wall point4_1 )
(is-wall point4_3 )
(is-wall point4_4 )
(is-wall point4_5 )
(is-wall point4_7 )
(is-wall point4_8 )
(is-wall point4_9 )
(is-wall point4_11 )
(is-wall point4_13 )
(is-wall point4_14 )
(is-wall point4_15 )
(is-wall point4_17 )
(is-wall point4_18 )
(is-wall point4_19 )
(is-wall point4_21 )
(is-wall point5_1 )
(is-wall point5_3 )
(is-wall point5_4 )
(is-wall point5_5 )
(is-wall point5_7 )
(is-wall point5_8 )
(is-wall point5_9 )
(is-wall point5_11 )
(is-wall point5_13 )
(is-wall point5_14 )
(is-wall point5_15 )
(is-wall point5_17 )
(is-wall point5_18 )
(is-wall point5_19 )
(is-wall point5_21 )
(is-wall point6_1 )
(is-wall point6_21 )
(is-wall point7_1 )
(is-wall point7_3 )
(is-wall point7_4 )
(is-wall point7_5 )
(is-wall point7_7 )
(is-wall point7_9 )
(is-wall point7_10 )
(is-wall point7_11 )
(is-wall point7_12 )
(is-wall point7_13 )
(is-wall point7_15 )
(is-wall point7_17 )
(is-wall point7_18 )
(is-wall point7_19 )
(is-wall point7_21 )
(is-wall point8_1 )
(is-wall point8_3 )
(is-wall point8_4 )
(is-wall point8_5 )
(is-wall point8_7 )
(is-wall point8_9 )
(is-wall point8_10 )
(is-wall point8_11 )
(is-wall point8_12 )
(is-wall point8_13 )
(is-wall point8_15 )
(is-wall point8_17 )
(is-wall point8_18 )
(is-wall point8_19 )
(is-wall point8_21 )
(is-wall point9_1 )
(is-wall point9_7 )
(is-wall point9_11 )
(is-wall point9_15 )
(is-wall point9_21 )
(is-wall point10_1 )
(is-wall point10_2 )
(is-wall point10_3 )
(is-wall point10_4 )
(is-wall point10_5 )
(is-wall point10_7 )
(is-wall point10_8 )
(is-wall point10_9 )
(is-wall point10_11 )
(is-wall point10_13 )
(is-wall point10_14 )
(is-wall point10_15 )
(is-wall point10_17 )
(is-wall point10_18 )
(is-wall point10_19 )
(is-wall point10_20 )
(is-wall point10_21 )
(is-wall point11_1 )
(is-wall point11_2 )
(is-wall point11_3 )
(is-wall point11_4 )
(is-wall point11_5 )
(is-wall point11_7 )
(is-wall point11_15 )
(is-wall point11_17 )
(is-wall point11_18 )
(is-wall point11_19 )
(is-wall point11_20 )
(is-wall point11_21 )
(is-wall point12_1 )
(is-wall point12_2 )
(is-wall point12_3 )
(is-wall point12_4 )
(is-wall point12_5 )
(is-wall point12_7 )
(is-wall point12_9 )
(is-wall point12_10 )
(is-wall point12_11 )
(is-wall point12_12 )
(is-wall point12_13 )
(is-wall point12_15 )
(is-wall point12_17 )
(is-wall point12_18 )
(is-wall point12_19 )
(is-wall point12_20 )
(is-wall point12_21 )
(is-wall point13_1 )
(is-wall point13_2 )
(is-wall point13_3 )
(is-wall point13_4 )
(is-wall point13_5 )
(is-wall point13_7 )
(is-wall point13_9 )
(is-wall point13_10 )
(is-wall point13_11 )
(is-wall point13_12 )
(is-wall point13_13 )
(is-wall point13_15 )
(is-wall point13_17 )
(is-wall point13_18 )
(is-wall point13_19 )
(is-wall point13_20 )
(is-wall point13_21 )
(is-wall point14_9 )
(is-wall point14_10 )
(is-wall point14_11 )
(is-wall point14_12 )
(is-wall point14_13 )
(is-wall point15_1 )
(is-wall point15_2 )
(is-wall point15_3 )
(is-wall point15_4 )
(is-wall point15_5 )
(is-wall point15_7 )
(is-wall point15_9 )
(is-wall point15_10 )
(is-wall point15_11 )
(is-wall point15_12 )
(is-wall point15_13 )
(is-wall point15_15 )
(is-wall point15_17 )
(is-wall point15_18 )
(is-wall point15_19 )
(is-wall point15_20 )
(is-wall point15_21 )
(is-wall point16_1 )
(is-wall point16_2 )
(is-wall point16_3 )
(is-wall point16_4 )
(is-wall point16_5 )
(is-wall point16_7 )
(is-wall point16_15 )
(is-wall point16_17 )
(is-wall point16_18 )
(is-wall point16_19 )
(is-wall point16_20 )
(is-wall point16_21 )
(is-wall point17_1 )
(is-wall point17_2 )
(is-wall point17_3 )
(is-wall point17_4 )
(is-wall point17_5 )
(is-wall point17_7 )
(is-wall point17_9 )
(is-wall point17_10 )
(is-wall point17_11 )
(is-wall point17_12 )
(is-wall point17_13 )
(is-wall point17_15 )
(is-wall point17_17 )
(is-wall point17_18 )
(is-wall point17_19 )
(is-wall point17_20 )
(is-wall point17_21 )
(is-wall point18_1 )
(is-wall point18_2 )
(is-wall point18_3 )
(is-wall point18_4 )
(is-wall point18_5 )
(is-wall point18_7 )
(is-wall point18_9 )
(is-wall point18_10 )
(is-wall point18_11 )
(is-wall point18_12 )
(is-wall point18_13 )
(is-wall point18_15 )
(is-wall point18_17 )
(is-wall point18_18 )
(is-wall point18_19 )
(is-wall point18_20 )
(is-wall point18_21 )
(is-wall point19_1 )
(is-wall point19_11 )
(is-wall point19_21 )
(is-wall point20_1 )
(is-wall point20_3 )
(is-wall point20_4 )
(is-wall point20_5 )
(is-wall point20_7 )
(is-wall point20_8 )
(is-wall point20_9 )
(is-wall point20_11 )
(is-wall point20_13 )
(is-wall point20_14 )
(is-wall point20_15 )
(is-wall point20_17 )
(is-wall point20_18 )
(is-wall point20_19 )
(is-wall point20_21 )
(is-wall point21_1 )
(is-wall point21_5 )
(is-wall point21_17 )
(is-wall point21_21 )
(is-wall point22_1 )
(is-wall point22_2 )
(is-wall point22_3 )
(is-wall point22_5 )
(is-wall point22_7 )
(is-wall point22_9 )
(is-wall point22_10 )
(is-wall point22_11 )
(is-wall point22_12 )
(is-wall point22_13 )
(is-wall point22_15 )
(is-wall point22_17 )
(is-wall point22_19 )
(is-wall point22_20 )
(is-wall point22_21 )
(is-wall point23_1 )
(is-wall point23_2 )
(is-wall point23_3 )
(is-wall point23_5 )
(is-wall point23_7 )
(is-wall point23_9 )
(is-wall point23_10 )
(is-wall point23_11 )
(is-wall point23_12 )
(is-wall point23_13 )
(is-wall point23_15 )
(is-wall point23_17 )
(is-wall point23_19 )
(is-wall point23_20 )
(is-wall point23_21 )
(is-wall point24_1 )
(is-wall point24_7 )
(is-wall point24_11 )
(is-wall point24_15 )
(is-wall point24_21 )
(is-wall point25_1 )
(is-wall point25_3 )
(is-wall point25_4 )
(is-wall point25_5 )
(is-wall point25_6 )
(is-wall point25_7 )
(is-wall point25_8 )
(is-wall point25_9 )
(is-wall point25_11 )
(is-wall point25_13 )
(is-wall point25_14 )
(is-wall point25_15 )
(is-wall point25_16 )
(is-wall point25_17 )
(is-wall point25_18 )
(is-wall point25_19 )
(is-wall point25_21 )
(is-wall point26_1 )
(is-wall point26_21 )
(is-wall point27_1 )
(is-wall point27_2 )
(is-wall point27_3 )
(is-wall point27_4 )
(is-wall point27_5 )
(is-wall point27_6 )
(is-wall point27_7 )
(is-wall point27_8 )
(is-wall point27_9 )
(is-wall point27_10 )
(is-wall point27_11 )
(is-wall point27_12 )
(is-wall point27_13 )
(is-wall point27_14 )
(is-wall point27_15 )
(is-wall point27_16 )
(is-wall point27_17 )
(is-wall point27_18 )
(is-wall point27_19 )
(is-wall point27_20 )
(is-wall point27_21 )
(is-blank point10_10 )
(is-blank point10_12 )
(is-blank point11_8 )
(is-blank point11_9 )
(is-blank point11_10 )
(is-blank point11_11 )
(is-blank point11_12 )
(is-blank point11_13 )
(is-blank point11_14 )
(is-blank point12_8 )
(is-blank point12_14 )
(is-blank point13_8 )
(is-blank point13_14 )
(is-blank point14_1 )
(is-blank point14_2 )
(is-blank point14_3 )
(is-blank point14_4 )
(is-blank point14_5 )
(is-blank point14_7 )
(is-blank point14_8 )
(is-blank point14_14 )
(is-blank point14_15 )
(is-blank point14_17 )
(is-blank point14_18 )
(is-blank point14_19 )
(is-blank point14_20 )
(is-blank point14_21 )
(is-blank point15_8 )
(is-blank point15_14 )
(is-blank point16_8 )
(is-blank point16_9 )
(is-blank point16_10 )
(is-blank point16_11 )
(is-blank point16_12 )
(is-blank point16_13 )
(is-blank point16_14 )
(is-blank point17_8 )
(is-blank point17_14 )
(is-blank point18_8 )
(is-blank point18_14 )
(is-blank point21_11 )
(is-scookie point2_2 )
(is-scookie point2_3 )
(is-scookie point2_4 )
(is-scookie point2_5 )
(is-scookie point2_6 )
(is-scookie point2_7 )
(is-scookie point2_8 )
(is-scookie point2_9 )
(is-scookie point2_10 )
(is-scookie point2_12 )
(is-scookie point2_13 )
(is-scookie point2_14 )
(is-scookie point2_15 )
(is-scookie point2_16 )
(is-scookie point2_17 )
(is-scookie point2_18 )
(is-scookie point2_19 )
(is-scookie point2_20 )
(is-scookie point3_2 )
(is-scookie point3_6 )
(is-scookie point3_10 )
(is-scookie point3_12 )
(is-scookie point3_16 )
(is-scookie point3_20 )
(is-scookie point4_6 )
(is-scookie point4_10 )
(is-scookie point4_12 )
(is-scookie point4_16 )
(is-scookie point5_2 )
(is-scookie point5_6 )
(is-scookie point5_10 )
(is-scookie point5_12 )
(is-scookie point5_16 )
(is-scookie point5_20 )
(is-scookie point6_2 )
(is-scookie point6_3 )
(is-scookie point6_4 )
(is-scookie point6_5 )
(is-scookie point6_6 )
(is-scookie point6_7 )
(is-scookie point6_8 )
(is-scookie point6_9 )
(is-scookie point6_10 )
(is-scookie point6_11 )
(is-scookie point6_12 )
(is-scookie point6_13 )
(is-scookie point6_14 )
(is-scookie point6_15 )
(is-scookie point6_16 )
(is-scookie point6_17 )
(is-scookie point6_18 )
(is-scookie point6_19 )
(is-scookie point6_20 )
(is-scookie point7_2 )
(is-scookie point7_6 )
(is-scookie point7_8 )
(is-scookie point7_14 )
(is-scookie point7_16 )
(is-scookie point7_20 )
(is-scookie point8_2 )
(is-scookie point8_6 )
(is-scookie point8_8 )
(is-scookie point8_14 )
(is-scookie point8_16 )
(is-scookie point8_20 )
(is-scookie point9_2 )
(is-scookie point9_3 )
(is-scookie point9_4 )
(is-scookie point9_5 )
(is-scookie point9_6 )
(is-scookie point9_8 )
(is-scookie point9_9 )
(is-scookie point9_10 )
(is-scookie point9_12 )
(is-scookie point9_13 )
(is-scookie point9_14 )
(is-scookie point9_16 )
(is-scookie point9_17 )
(is-scookie point9_18 )
(is-scookie point9_19 )
(is-scookie point9_20 )
(is-scookie point10_6 )
(is-scookie point10_16 )
(is-scookie point11_6 )
(is-scookie point11_16 )
(is-scookie point12_6 )
(is-scookie point12_16 )
(is-scookie point13_6 )
(is-scookie point13_16 )
(is-scookie point14_6 )
(is-scookie point14_16 )
(is-scookie point15_6 )
(is-scookie point15_16 )
(is-scookie point16_6 )
(is-scookie point16_16 )
(is-scookie point17_6 )
(is-scookie point17_16 )
(is-scookie point18_6 )
(is-scookie point18_16 )
(is-scookie point19_2 )
(is-scookie point19_3 )
(is-scookie point19_4 )
(is-scookie point19_5 )
(is-scookie point19_6 )
(is-scookie point19_7 )
(is-scookie point19_8 )
(is-scookie point19_9 )
(is-scookie point19_10 )
(is-scookie point19_12 )
(is-scookie point19_13 )
(is-scookie point19_14 )
(is-scookie point19_15 )
(is-scookie point19_16 )
(is-scookie point19_17 )
(is-scookie point19_18 )
(is-scookie point19_19 )
(is-scookie point19_20 )
(is-scookie point20_2 )
(is-scookie point20_6 )
(is-scookie point20_10 )
(is-scookie point20_12 )
(is-scookie point20_16 )
(is-scookie point20_20 )
(is-scookie point21_3 )
(is-scookie point21_4 )
(is-scookie point21_6 )
(is-scookie point21_7 )
(is-scookie point21_8 )
(is-scookie point21_9 )
(is-scookie point21_10 )
(is-scookie point21_12 )
(is-scookie point21_13 )
(is-scookie point21_14 )
(is-scookie point21_15 )
(is-scookie point21_16 )
(is-scookie point21_18 )
(is-scookie point21_19 )
(is-scookie point22_4 )
(is-scookie point22_6 )
(is-scookie point22_8 )
(is-scookie point22_14 )
(is-scookie point22_16 )
(is-scookie point22_18 )
(is-scookie point23_4 )
(is-scookie point23_6 )
(is-scookie point23_8 )
(is-scookie point23_14 )
(is-scookie point23_16 )
(is-scookie point23_18 )
(is-scookie point24_2 )
(is-scookie point24_3 )
(is-scookie point24_4 )
(is-scookie point24_5 )
(is-scookie point24_6 )
(is-scookie point24_8 )
(is-scookie point24_9 )
(is-scookie point24_10 )
(is-scookie point24_12 )
(is-scookie point24_13 )
(is-scookie point24_14 )
(is-scookie point24_16 )
(is-scookie point24_17 )
(is-scookie point24_18 )
(is-scookie point24_19 )
(is-scookie point24_20 )
(is-scookie point25_2 )
(is-scookie point25_10 )
(is-scookie point25_12 )
(is-scookie point25_20 )
(is-scookie point26_2 )
(is-scookie point26_3 )
(is-scookie point26_4 )
(is-scookie point26_5 )
(is-scookie point26_6 )
(is-scookie point26_7 )
(is-scookie point26_8 )
(is-scookie point26_9 )
(is-scookie point26_10 )
(is-scookie point26_11 )
(is-scookie point26_12 )
(is-scookie point26_13 )
(is-scookie point26_14 )
(is-scookie point26_15 )
(is-scookie point26_16 )
(is-scookie point26_17 )
(is-scookie point26_18 )
(is-scookie point26_19 )
(is-scookie point26_20 )
(is-lcookie point4_2 )
(is-lcookie point4_20 )
(is-lcookie point21_2 )
(is-lcookie point21_20 )
(is-menu point1_3 )
(is-menu point1_4 )
(is-menu point1_5 )
(is-menu point1_6 )
(is-menu point1_7 )
(is-menu point1_9 )
(is-menu point1_10 )
(is-menu point1_11 )
(is-menu point1_12 )
(is-menu point1_13 )
(is-menu point1_15 )
(is-menu point1_16 )
(is-menu point1_17 )
(is-menu point1_18 )
(is-menu point1_19 )
(is-menu point2_3 )
(is-menu point2_7 )
(is-menu point2_9 )
(is-menu point2_13 )
(is-menu point2_15 )
(is-menu point3_3 )
(is-menu point3_7 )
(is-menu point3_9 )
(is-menu point3_13 )
(is-menu point3_15 )
(is-menu point4_3 )
(is-menu point4_4 )
(is-menu point4_5 )
(is-menu point4_6 )
(is-menu point4_7 )
(is-menu point4_9 )
(is-menu point4_10 )
(is-menu point4_11 )
(is-menu point4_12 )
(is-menu point4_13 )
(is-menu point4_15 )
(is-menu point5_3 )
(is-menu point5_9 )
(is-menu point5_13 )
(is-menu point5_15 )
(is-menu point6_3 )
(is-menu point6_9 )
(is-menu point6_13 )
(is-menu point6_15 )
(is-menu point7_3 )
(is-menu point7_9 )
(is-menu point7_13 )
(is-menu point7_15 )
(is-menu point7_16 )
(is-menu point7_17 )
(is-menu point7_18 )
(is-menu point7_19 )
(is-menu point9_3 )
(is-menu point9_7 )
(is-menu point9_9 )
(is-menu point9_10 )
(is-menu point9_11 )
(is-menu point9_12 )
(is-menu point9_13 )
(is-menu point9_15 )
(is-menu point9_19 )
(is-menu point10_3 )
(is-menu point10_4 )
(is-menu point10_6 )
(is-menu point10_7 )
(is-menu point10_9 )
(is-menu point10_13 )
(is-menu point10_15 )
(is-menu point10_16 )
(is-menu point10_19 )
(is-menu point11_3 )
(is-menu point11_5 )
(is-menu point11_7 )
(is-menu point11_9 )
(is-menu point11_13 )
(is-menu point11_15 )
(is-menu point11_16 )
(is-menu point11_19 )
(is-menu point12_3 )
(is-menu point12_7 )
(is-menu point12_9 )
(is-menu point12_10 )
(is-menu point12_11 )
(is-menu point12_12 )
(is-menu point12_13 )
(is-menu point12_15 )
(is-menu point12_17 )
(is-menu point12_19 )
(is-menu point13_3 )
(is-menu point13_7 )
(is-menu point13_9 )
(is-menu point13_13 )
(is-menu point13_15 )
(is-menu point13_18 )
(is-menu point13_19 )
(is-menu point14_3 )
(is-menu point14_7 )
(is-menu point14_9 )
(is-menu point14_13 )
(is-menu point14_15 )
(is-menu point14_18 )
(is-menu point14_19 )
(is-menu point15_3 )
(is-menu point15_7 )
(is-menu point15_9 )
(is-menu point15_13 )
(is-menu point15_15 )
(is-menu point15_19 )
(is-start point22_5 )
(is-end point22_17 )
    ;todo: put the initial state's facts and numeric values here
)

(:goal (and
    (=(timer)4)
    ;todo: put the goal condition here
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
