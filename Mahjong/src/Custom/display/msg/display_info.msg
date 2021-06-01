#display info
custom_msgs/coin player_coin
custom_msgs/coin ai_coin
custom_msgs/coin field_coin

custom_msgs/card_holder[] player_card
custom_msgs/card_holder[] ai_card

custom_msgs/card[] nobility_open
custom_msgs/card[] level1_open
int32 level1_fold			#not use fold card only count
custom_msgs/card[] level2_open
int32 level2_fold
custom_msgs/card[] level3_open
int32 level3_fold

int32 player_score
int32 ai_score

int32 game_state	#who's turn


