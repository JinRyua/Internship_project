#include "ros/ros.h"

#include "board/ask_map_size.h"
#include "board/ask_agent_srv.h"
#include "board/move_check_srv.h"
#include "board/set_ai_loc_msg.h"
#include "board/player_act_srv.h"
#include "board/select_menu_msg.h"
#include "board/ask_player_stat_srv.h"
#include "board/ask_map_srv.h"
#include "std_msgs/Empty.h"
#include "rosplan_knowledge_msgs/KnowledgeItem.h"

#include "custom_msgs/card.h"
#include "custom_msgs/coin.h"
#include "board/do_action_srv.h"



#include <utility>
#include <set>
#include <string>
#include <vector>

#ifndef BOARD
#define BOARD

#define LEVEL1 0
#define LEVEL2 1
#define LEVEL3 2

#define THREE_COIN 0
#define TWO_COIN 1
#define BUY_CARD 2

#define PLAYER_TURN 0
#define AI_TURN 1
#define WAIT 2

#define WHITE 0
#define BLUE 1
#define GREEN 2
#define RED 3
#define BLACK 4
#define NOBILITY 5

namespace Custom
{
    class Board
    {
    private:
        ros::NodeHandle *node_handle;

        /* params */
        std::string kb;

        int game_state;     //게임 상태

        std::vector<std::string> player_names;

        std::vector<std::vector<custom_msgs::card>> player_card;  //player's card  order = white, blue, green, red, black, nobility
        custom_msgs::coin player_coin;               //player's coin

        std::vector<std::vector<custom_msgs::card>> ai_card;  //ai's card
        custom_msgs::coin ai_coin;     //ai's coin

        std::vector<custom_msgs::card> nobility_open;
        std::vector<custom_msgs::card> nobility_fold;

        std::vector<custom_msgs::card> level1_fold; //fold cards
        std::vector<custom_msgs::card> level2_fold;
        std::vector<custom_msgs::card> level3_fold;

        std::vector<custom_msgs::card> level1_open; //open cards
        std::vector<custom_msgs::card> level2_open;
        std::vector<custom_msgs::card> level3_open;

        custom_msgs::coin field_coin;  //field's coin

        int player_score;
        int ai_score;
        
        
        rosplan_knowledge_msgs::KnowledgeItem post_knowledge;   //player's post knowledge
        rosplan_knowledge_msgs::KnowledgeItem knowledge;

        double timer;       //start timer




    public:
        Board(ros::NodeHandle &nh);
        ~Board();

        custom_msgs::coin* select_coin_vector();           //select coin vector
        std::vector<custom_msgs::card>* select_vector(std::string& n);  //select vector from name
        int* select_color(custom_msgs::card& at, std::string& n);       //select color pointer from vector and color
        int& select_coin(custom_msgs::coin* at, int& n);                //select coin
        std::vector<custom_msgs::card>* select_level(const int& n);                //select level
        std::vector<std::vector<custom_msgs::card>>* select_card_vector();           //select player,ai card 
        int& select_color_from_card(custom_msgs::card* at, int& n);
        std::string convert_to_color_from_int(const int color);                 //convert to color form int

        void make_know_array_for_coin(std::vector<rosplan_knowledge_msgs::KnowledgeItem>& updator, std::vector<unsigned char>& type,
                                const int function_value, const std::string name, const int color);     //make know array for coin update   )
        void make_know_array_for_card_move(std::vector<rosplan_knowledge_msgs::KnowledgeItem>& updator, std::vector<unsigned char>& type,
                                const std::string card_name, const std::string from, const std::string to);     //make know array for card move update   )
        void make_know_array_for_card_open(std::vector<rosplan_knowledge_msgs::KnowledgeItem>& updator, std::vector<unsigned char>& type,
                                const std::string card_name);     //make know array for card open update   )
        void make_know_array_for_score(std::vector<rosplan_knowledge_msgs::KnowledgeItem>& updator, std::vector<unsigned char>& type,
                                const int function_value, const std::string name);     //make know array for score update   )

        void run_board();   //run board
        void display();
        void change_state();

        bool three_coin(std::vector<int>& details, std::vector<int>& abandon);        //action list
        bool two_coin(std::vector<int>& details);
        bool buy_card(std::vector<int>& details);

       
        //service client
        ros::ServiceClient update_knowledge_client;
        ros::ServiceClient ai_call_plan_client;
        ros::ServiceClient player_call_plan_client;

        // //publisher
        ros::Publisher display_pub;  //display 정보를 주는 display/display
        ros::Publisher log_pub;      //log 정보를 주는 log/log
        

        // //service
        bool do_action_callback(board::do_action_srv::Request& req, board::do_action_srv::Response& res);
       
        // //sub callback
        // void exit_callback(const std_msgs::Empty& msg);

    };
}   //close namespace

#endif