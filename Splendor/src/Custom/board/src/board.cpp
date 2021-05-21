#include "board/board.h"
#include "rosplan_knowledge_msgs/GetInstanceService.h"
#include "rosplan_knowledge_msgs/GetAttributeService.h"
#include "rosplan_knowledge_msgs/KnowledgeUpdateServiceArray.h"
#include "display/display_info.h"
#include "custom_msgs/card_holder.h"
#include "log_display/log_msg.h"
#include "diagnostic_msgs/KeyValue.h"
#include "std_srvs/Empty.h"




#include <iostream>
#include <string>
#include <chrono>
#include <algorithm>
#include <cmath>
#include <signal.h>
#include <cstdlib>
#include <ctime>

using namespace std;
void print_log(string node_name, string func,string str);


namespace Custom{
    Board::Board(ros::NodeHandle &nh)   //생성자
    {
        node_handle = &nh;  //get node handle

        game_state = PLAYER_TURN; //init_state = select menu
        player_score = 0;
        ai_score = 0;
        player_names.push_back("/player");
        player_names.push_back("/ai1");


        player_card.resize(6);  //init player, ai card 
        ai_card.resize(6);      //6 => nobility card        

        kb = "/rosplan_knowledge_base/"; // "knowledge_base name";
        nh.getParam("knowledge_base", kb);

        //set updator
        stringstream ss;
        ss.str("");
        ss << "/rosplan_problem_interface/problem_generation_server";
        ai_call_plan_client = node_handle->serviceClient<std_srvs::Empty>(ss.str());     

        ss.str("");
        ss << "/rosplan_problem_interface2/problem_generation_server";
        player_call_plan_client = node_handle->serviceClient<std_srvs::Empty>(ss.str());  

        ss.str("");
        ss << "/rosplan_knowledge_base/update_array";
        update_knowledge_client = node_handle->serviceClient<rosplan_knowledge_msgs::KnowledgeUpdateServiceArray>(ss.str());    

        //set publisher
        std::string display_topic = "/display/display";     //display topic
        nh.getParam("display_name", display_topic);
        display_pub = nh.advertise<display::display_info>(display_topic, 1000);

        //set publisher
        std::string log_topic = "/log_display/log";     //display topic
        nh.getParam("log_name", log_topic);
        log_pub = nh.advertise<log_display::log_msg>(log_topic, 1000);

        //get info from kb
        ss.str("");
        ss << kb << "state/instances";
        ros::service::waitForService(ss.str(), ros::Duration(20));
        ros::ServiceClient client = nh.serviceClient<rosplan_knowledge_msgs::GetInstanceService>(ss.str());
        rosplan_knowledge_msgs::GetInstanceService srv;
        srv.request.type_name = "nobility";
        vector<string> temp;     //get name
        if (client.call(srv)){
            temp = srv.response.instances;
            for(int i = 0;i<temp.size();i++){
                custom_msgs::card temp_card;
                temp_card.name = temp[i];
                nobility_fold.push_back(temp_card);
            }
        }
        srv.request.type_name = "level1";   //level1
        if (client.call(srv)){
            temp = srv.response.instances;
            for(int i = 0;i<temp.size();i++){
                custom_msgs::card temp_card;
                temp_card.name = temp[i];
                level1_fold.push_back(temp_card);
            }
        }

        srv.request.type_name = "level2";   //level1
        if (client.call(srv)){
            temp = srv.response.instances;
            for(int i = 0;i<temp.size();i++){
                custom_msgs::card temp_card;
                temp_card.name = temp[i];
                level2_fold.push_back(temp_card);
            }
        }

        srv.request.type_name = "level3";   //level1
        if (client.call(srv)){
            temp = srv.response.instances;
            for(int i = 0;i<temp.size();i++){
                custom_msgs::card temp_card;
                temp_card.name = temp[i];
                level3_fold.push_back(temp_card);
            }
        }

        ss.str("");
        ss << kb << "state/functions";
        ros::service::waitForService(ss.str(), ros::Duration(20));
        client = nh.serviceClient<rosplan_knowledge_msgs::GetAttributeService>(ss.str());
        rosplan_knowledge_msgs::GetAttributeService info_srv;
        info_srv.request.predicate_name = "s-point";
        vector<rosplan_knowledge_msgs::KnowledgeItem> temp_item;        //get s-point for card
        if (client.call(info_srv)) {
            temp_item = info_srv.response.attributes;
            for (int i = 0; i < temp_item.size(); i++) {  //get card name
                vector<diagnostic_msgs::KeyValue> name = temp_item[i].values;
                string n = "";  //nobility or level1 or ....
                for (int j = 0; j < name.size(); j++) {
                    if (name[j].key == "ca") {
                        n = name[j].value;
                        break;
                    }
                }

                std::vector<custom_msgs::card> *find_vector = select_vector(n);  //select find vector
                
                for (int j = 0; j < find_vector->size(); j++) { //find name and save point
                    if(find_vector->at(j).name == n){
                        find_vector->at(j).point = (int)(temp_item[i].function_value);
                        break;
                    }
                }
            }
        }

        info_srv.request.predicate_name = "need-token";     //get need-token for card
        if (client.call(info_srv)) {
            temp_item = info_srv.response.attributes;
            for (int i = 0; i < temp_item.size(); i++) {  //get card name
                vector<diagnostic_msgs::KeyValue> name = temp_item[i].values;
                string n = "";  //nobility or level1 or ....
                string token_color = "";    //card's need token color
                for (int j = 0; j < name.size(); j++) {
                    if (name[j].key == "ca") {
                        n = name[j].value;
                    }
                    else if(name[j].key == "to"){
                        token_color = name[j].value;
                    }
                }
                std::vector<custom_msgs::card> *find_vector = select_vector(n);  //select find vector
                for (int j = 0; j < find_vector->size(); j++) { //find name and save point
                    if(find_vector->at(j).name == n){
                        int* find_color = select_color(find_vector->at(j), token_color);
                        *find_color = (int)(temp_item[i].function_value);       //save color value
                        break;
                    }
                }
            }
        }

        info_srv.request.predicate_name = "have-token";     //get have-token for field
        if (client.call(info_srv)) {
            temp_item = info_srv.response.attributes;
            for (int i = 0; i < temp_item.size(); i++) {  //get card name
                vector<diagnostic_msgs::KeyValue> name = temp_item[i].values;
                string n = "";  //filed
                string token_color = "";    //have token color
                for (int j = 0; j < name.size(); j++) {
                    if (name[j].key == "ch") {
                        n = name[j].value;
                    }
                    else if(name[j].key == "to"){
                        token_color = name[j].value;
                    }
                }

                custom_msgs::coin* coin_vector;  //find coin vector
                if (n == "field")
                    coin_vector = &field_coin;
                else if (n == "ai1")
                    coin_vector = &ai_coin;
                else if (n == "player1")
                    coin_vector = &player_coin;


                if (token_color == "white")  //save coin
                    coin_vector->white = (int)(temp_item[i].function_value);
                else if (token_color == "blue")
                    coin_vector->blue = (int)(temp_item[i].function_value);
                else if (token_color == "green")
                    coin_vector->green = (int)(temp_item[i].function_value);
                else if (token_color == "red")
                    coin_vector->red = (int)(temp_item[i].function_value);
                else if (token_color == "black")
                    coin_vector->black = (int)(temp_item[i].function_value);
            }
        }

        ss.str("");
        ss << kb << "state/propositions";       
        ros::service::waitForService(ss.str(), ros::Duration(20));
        client = nh.serviceClient<rosplan_knowledge_msgs::GetAttributeService>(ss.str());
        info_srv.request.predicate_name = "s-color";    //get token's-color for card
        if (client.call(info_srv)) {
            temp_item = info_srv.response.attributes;
            for (int i = 0; i < temp_item.size(); i++) {  //get card name
                vector<diagnostic_msgs::KeyValue> name = temp_item[i].values;
                string n = "";  //nobility or level1 or ....
                string token_color = "";    //card's token color
                for (int j = 0; j < name.size(); j++) {
                    if (name[j].key == "ca") {
                        n = name[j].value;
                    }
                    else if(name[j].key == "to"){
                        token_color = name[j].value;
                    }
                }

                std::vector<custom_msgs::card> *find_vector = select_vector(n);  //select find vector

                for (int j = 0; j < find_vector->size(); j++) { //find name and save token color
                    if(find_vector->at(j).name == n){
                        find_vector->at(j).token = token_color;
                        break;
                    }
                }
            }
        }

        vector<rosplan_knowledge_msgs::KnowledgeItem> updator;
        vector<unsigned char> type;
        for (int i = LEVEL1; i <= LEVEL3; i++) {  //init field card
            vector<custom_msgs::card>* level_vector = select_level(i);
            std::vector<custom_msgs::card>* fold_vector;
            int k = 0;  //no random
            while (level_vector->size() < 4) {
                if (i == LEVEL1)
                    fold_vector = &level1_fold;
                else if (i == LEVEL2)
                    fold_vector = &level2_fold;
                else if (i == LEVEL3)
                    fold_vector = &level3_fold;
                if (!fold_vector->empty()) {
                    //int rand_num = rand() % fold_vector->size();
                    int rand_num = k;
                    level_vector->push_back(fold_vector->at(rand_num));
                    fold_vector->erase(fold_vector->begin() + rand_num);
                    make_know_array_for_card_open(updator, type, level_vector->back().name);
                    k++;
                }
            }
        }
        for (int i = 0; i < 3; i++) {  //init field nobility
            int rand_num = rand() % nobility_fold.size();
            nobility_open.push_back(nobility_fold[rand_num]);
            nobility_fold.erase(nobility_fold.begin() + rand_num);
            make_know_array_for_card_open(updator, type, nobility_open.back().name);
        }

        rosplan_knowledge_msgs::KnowledgeUpdateServiceArray update_srv;
        update_srv.request.update_type = type;
        update_srv.request.knowledge = updator;
        update_knowledge_client.call(update_srv);  //call update array
        //test
        // player_coin.white=1;
        // player_coin.blue=1;
        // player_coin.black=0;
        // player_coin.green=0;
        // // player_coin.red=1;
        // ai_coin.white = 10;
        // ai_coin.blue = 10;
        // ai_coin.black = 10;
        // ai_coin.green = 10;
        // ai_coin.red = 10;
    }

    custom_msgs::coin* Board::select_coin_vector() { //select find vector by name
        if (game_state == PLAYER_TURN)
            return &player_coin;
        else if (game_state == AI_TURN)
            return &ai_coin;
    }
    std::vector<custom_msgs::card>* Board::select_vector(string &n) { //select find vector by name
        if (n.find("nobility") != -1)
            return &nobility_fold;
        else if (n.find("level1") != -1)
            return &level1_fold;
        else if (n.find("level2") != -1)
            return &level2_fold;
        else if (n.find("level3") != -1)
            return &level3_fold;
    }
    int* Board::select_color(custom_msgs::card& at, string& n){ //find name and save point
        if (n == "white")
            return &at.white;
        else if (n == "blue")
            return &at.blue;
        else if (n == "green")
            return &at.green;
        else if (n == "red")
            return &at.red;
        else if (n == "black")
            return &at.black;
    }

    int& Board::select_coin(custom_msgs::coin* at, int& n){ //find name and save point
        if (n == WHITE)
            return at->white;
        else if (n == BLUE)
            return at->blue;
        else if (n == GREEN)
            return at->green;
        else if (n == RED)
            return at->red;
        else if (n == BLACK)
            return at->black;
    }

    std::vector<custom_msgs::card>* Board::select_level(const int& n) {  //select level
        if (n == LEVEL1)
            return &level1_open;
        else if (n == LEVEL2)
            return &level2_open;
        else if (n == LEVEL3)
            return &level3_open;
    }

    std::vector<std::vector<custom_msgs::card>>* Board::select_card_vector(){
        if(game_state == PLAYER_TURN){
            return &player_card;
        }  
        else if(game_state == AI_TURN){
            return &ai_card;
        }

    }

    int& Board::select_color_from_card(custom_msgs::card* at, int& n){
        if (n == WHITE)
            return at->white;
        else if (n == BLUE)
            return at->blue;
        else if (n == GREEN)
            return at->green;
        else if (n == RED)
            return at->red;
        else if (n == BLACK)
            return at->black;
    }

    string Board::convert_to_color_from_int(const int color){
        if(color == WHITE)
            return "white";
        else if(color == BLUE)
            return "blue";
        else if(color == GREEN)
            return "green";
        else if(color == RED)
            return "red";
        else if(color == BLACK)
            return "black";
        
    }

    Board::~Board() 
    {   
    }
    
    void Board::run_board(){
        display();
    }

    void Board::display(){

        display::display_info msg;      //make display msg
        msg.player_coin = player_coin;
        msg.ai_coin = ai_coin;
        msg.field_coin = field_coin;
        msg.nobility_open = nobility_open;
        msg.level1_open = level1_open;
        msg.level2_open = level2_open;
        msg.level3_open = level3_open;
        msg.level1_fold = level1_fold.size();
        msg.level2_fold = level2_fold.size();
        msg.level3_fold = level3_fold.size();
        msg.player_score = player_score;
        msg.ai_score = ai_score;
        msg.game_state = game_state;
        

        vector<custom_msgs::card_holder> player_holder; //convert to msg
        vector<custom_msgs::card_holder> ai_holder;
        custom_msgs::card_holder temp;
        for(int i = 0; i < player_card.size(); i++){
            temp.holder = player_card[i];
            player_holder.push_back(temp);
            temp.holder = ai_card[i];
            ai_holder.push_back(temp);
        }
        msg.player_card = player_holder;
        msg.ai_card = ai_holder;
        
        display_pub.publish(msg);
    }
    
    void Board::change_state(){
        if (game_state == PLAYER_TURN){
            game_state = AI_TURN;
            std_srvs::Empty temp;
            ai_call_plan_client.call(temp);
        }
        else if (game_state == AI_TURN){
            game_state = PLAYER_TURN;
            std_srvs::Empty temp;
            player_call_plan_client.call(temp);
        }
    }

    bool Board::do_action_callback(board::do_action_srv::Request& req, board::do_action_srv::Response& res){
        log_display::log_msg temp;
        temp.log_str = "do_action" + req.name;
        log_pub.publish(temp);
        
        cout<<req.name<<" "<<req.action<<" [";
        for(int i =0;i<req.details.size();i++){
            cout<<req.details[i]<<", ";
        }
        cout<<"] [";
        for(int i =0;i<req.abandon.size();i++){
            cout<<req.abandon[i]<<", ";
        }
        cout<<"]"<<endl;


        if (game_state != WAIT) {   //TODO: add state change
            if (player_names[game_state] == req.name) {
                if (req.action == THREE_COIN) {
                    res.success = three_coin(req.details, req.abandon);
                    if(res.success == true){
                        change_state();
                        display();
                        //TODO: need to replan
                        temp.log_str = "return true";
                    } else
                        temp.log_str = "return false";
                    log_pub.publish(temp);
                    return true;
                } else if (req.action == TWO_COIN) {
                    res.success = two_coin(req.details);
                    if(res.success == true){
                        change_state();
                        display();
                        temp.log_str = "return true";
                    } else
                        temp.log_str = "return false";
                    log_pub.publish(temp);
                    return true;
                } else if (req.action == BUY_CARD) {
                    res.success = buy_card(req.details);
                    if(res.success == true){
                        change_state();
                        display();
                        temp.log_str = "return true";
                    }
                    else temp.log_str = "return false";
                    log_pub.publish(temp);
                    
                    return true;
                } else {
                    res.success = false;
                    temp.log_str = "return false";
                    log_pub.publish(temp);
                    return true;
                }
            }
            else{
                res.success = false;
                temp.log_str = "return false";
                    log_pub.publish(temp);
                return true;
            }
        }
        else{
                res.success = false;
                temp.log_str = "return false";
                    log_pub.publish(temp);
                return true;
        }
    }

    void Board::make_know_array_for_coin(std::vector<rosplan_knowledge_msgs::KnowledgeItem>& updator, std::vector<unsigned char>& type,
                                         const int function_value, const std::string name, const int color) {
        //update
        rosplan_knowledge_msgs::KnowledgeItem know;
        know.knowledge_type = 2;                                     //FUNCTION
        know.attribute_name = "have-token";                          //token
        know.function_value = function_value;  //player's
        vector<diagnostic_msgs::KeyValue> temp;
        diagnostic_msgs::KeyValue value;
        
        value.key = "ch";
        value.value = name;
        temp.push_back(value);

        value.key = "to";
        value.value = convert_to_color_from_int(color);
        temp.push_back(value);
        know.values = temp;

        updator.push_back(know);    //add knowledge
        type.push_back(0);  //add_knowledge type
    }
    void Board::make_know_array_for_score(std::vector<rosplan_knowledge_msgs::KnowledgeItem>& updator, std::vector<unsigned char>& type,
                                         const int function_value, const std::string name) {
        //update
        rosplan_knowledge_msgs::KnowledgeItem know;
        know.knowledge_type = 2;               //FUNCTION
        know.attribute_name = "have-score";    //score
        know.function_value = function_value;  //value
        vector<diagnostic_msgs::KeyValue> temp;
        diagnostic_msgs::KeyValue value;

        value.key = "ch";
        value.value = name;
        temp.push_back(value);
        know.values = temp;

        updator.push_back(know);  //add knowledge
        type.push_back(0);        //add_knowledge type
    }
    void Board::make_know_array_for_card_move(std::vector<rosplan_knowledge_msgs::KnowledgeItem>& updator, std::vector<unsigned char>& type,
                                const std::string card_name, const std::string from, const std::string to){             //update
        rosplan_knowledge_msgs::KnowledgeItem know;
        know.knowledge_type = 1;               //FACT
        know.attribute_name = "have-card";     //card
        vector<diagnostic_msgs::KeyValue> temp;
        diagnostic_msgs::KeyValue value;

        value.key = "ch";       //make value for remove from field
        value.value = from;
        temp.push_back(value);
        value.key = "ca";
        value.value = card_name;
        temp.push_back(value);
        know.values = temp;

        updator.push_back(know);  //add knowledge
        type.push_back(2);        //remove_knowledge type
        temp.clear();

        value.key = "ch";       //make value for add to player or ai
        value.value = to;
        temp.push_back(value);
        value.key = "ca";
        value.value = card_name;
        temp.push_back(value);
        know.values = temp;

        updator.push_back(know);  //add knowledge
        type.push_back(0);        //add_knowledge type
        
    }
    void Board::make_know_array_for_card_open(std::vector<rosplan_knowledge_msgs::KnowledgeItem>& updator, std::vector<unsigned char>& type,
                                              const std::string card_name) {
        rosplan_knowledge_msgs::KnowledgeItem know;
        know.knowledge_type = 1;            //FACT
        know.attribute_name = "fold";  //card
        vector<diagnostic_msgs::KeyValue> temp;
        diagnostic_msgs::KeyValue value;

        //make value for remove from fold
        value.key = "ca";
        value.value = card_name;
        temp.push_back(value);
        know.values = temp;

        updator.push_back(know);  //add knowledge
        type.push_back(2);        //remove_knowledge type
        temp.clear();

        //make value for add to player or ai
        know.knowledge_type = 1;            //FACT
        know.attribute_name = "have-card";  //card
        value.key = "ch";       //make value for add to field
        value.value = "field";
        temp.push_back(value);
        value.key = "ca";
        value.value = card_name;
        temp.push_back(value);
        know.values = temp;

        updator.push_back(know);  //add knowledge
        type.push_back(0);        //add_knowledge type
    }

    bool Board::three_coin(std::vector<int>& details, std::vector<int>& abandon) {
        vector<int> d = details;
        sort(d.begin(), d.end());
        d.erase(unique(d.begin(),d.end()),d.end()); //중복 제거

        if (d.size() == details.size() && details.size() <= 3) {  //3개 종류 이하 일때만
            for (int i = 0; i < details.size(); i++) {
                if (details[i] < WHITE || details[i] > BLACK) { //허용된 코인 체크
                    return false;
                }
            }

            custom_msgs::coin* coin_vector = select_coin_vector();
            int sum = 0;
            for (int i = 0; i < 5; i++) {
                sum += select_coin(coin_vector, i);
            }
            if (sum + details.size() - abandon.size() > 10)
                return false;

            vector<rosplan_knowledge_msgs::KnowledgeItem> updator;
            vector<unsigned char> type;
            for (int i = 0; i < details.size(); i++) {   
                if (select_coin(&field_coin, details[i]) > 0) {  //코인이 field에 있으면
                    select_coin(coin_vector, details[i])++;
                    select_coin(&field_coin, details[i])--;
                }
            }
            for (int i = 0; i < abandon.size(); i++) {  //abandon coin
                if (select_coin(coin_vector, abandon[i]) > 0){
                    select_coin(coin_vector, abandon[i])--;
                    select_coin(&field_coin, abandon[i])++;
                }
                else{
                    for(int j = 0; j<5;j++){    //잘못된 버리기면 무작위로 버림
                        if(select_coin(coin_vector,j)>0){
                            select_coin(coin_vector, j)--;
                            break;
                        }
                    }
                }
            }

            string name = "";
            if (game_state == PLAYER_TURN)
                name = "player1";
            else
                name = "ai1";
            for (int i = 0; i < 5; i++) {
                //make array for update coin
                make_know_array_for_coin(updator, type, select_coin(coin_vector, i),
                                         name, i);
                make_know_array_for_coin(updator, type, select_coin(&field_coin, i),
                                         "field", i);
            }

            rosplan_knowledge_msgs::KnowledgeUpdateServiceArray srv;
            srv.request.update_type = type;
            srv.request.knowledge = updator;
            update_knowledge_client.call(srv);  //call update array
            return true;

        } else {
            return false;
        }
    }

    bool Board::two_coin(std::vector<int>& details){
        sort(details.begin(), details.end());
        details.erase(unique(details.begin(),details.end()),details.end()); //중복 제거

        if (details.size() == 1) {  //3개 종류 일때만
            int i = 0;
            if (details[i] < WHITE || details[i] > BLACK) {  //허용된 코인 체크
                return false;
            }
            if (select_coin(&field_coin, details[i]) < 4) {  //field 코인 체크
                return false;
            }
            custom_msgs::coin* coin_vector = select_coin_vector();
            select_coin(coin_vector, details[i]) += 2;
            select_coin(&field_coin, details[i]) -= 2;

            //update KB
            vector<rosplan_knowledge_msgs::KnowledgeItem> updator;
            vector<unsigned char> type;

            string name = "";
            if (game_state == PLAYER_TURN)
                name = "player1";
            else
                name = "ai1";

            //make array for update coin
            make_know_array_for_coin(updator, type, select_coin(coin_vector, details[i]),
                                     name, details[i]);
            make_know_array_for_coin(updator, type, select_coin(&field_coin, details[i]),
                                     "field", details[i]);

            rosplan_knowledge_msgs::KnowledgeUpdateServiceArray srv;
            srv.request.update_type = type;
            srv.request.knowledge = updator;
            update_knowledge_client.call(srv);  //call update array

            return true;

        } else {
            return false;
        }
    }

    bool Board::buy_card(std::vector<int>& details){
        if (details.size() == 2) {  //2개 level, order 일때만
            if(details[0] < LEVEL1 || details[0] > LEVEL3){
                return false;
            }

            vector<custom_msgs::card>* level_vector = select_level(details[0]);

            if(details[1] < 0 || details[1] >= level_vector->size()){    //카드 수만큼 없으면
                return false;
            }

            custom_msgs::coin* coin_vector = select_coin_vector();  //코인 살 수 있는지 체크
            vector<vector<custom_msgs::card>>* card_vector = select_card_vector();
            for(int i =0;i<5;i++){ 
                if(select_color_from_card(&level_vector->at(details[1]), i) > select_coin(coin_vector, i) + card_vector->at(i).size()){
                    return false;
                }
            }
            
            vector<rosplan_knowledge_msgs::KnowledgeItem> updator;
            vector<unsigned char> type;

            string name = "";       //make name for update
            if (game_state == PLAYER_TURN)
                name = "player1";
            else
                name = "ai1";

            //buy card
            for (int i = 0; i < 5; i++) {   //move coin to field
                int coin = select_color_from_card(&level_vector->at(details[1]), i) - card_vector->at(i).size();
                if (coin < 0)
                    coin = 0;
                select_coin(coin_vector, i) -= coin;
                select_coin(&field_coin, i) += coin;

                //make array for update coin
                make_know_array_for_coin(updator, type, select_coin(coin_vector, i),
                                         name, i);
                make_know_array_for_coin(updator, type, select_coin(&field_coin, i),
                                         "field", i);
            }


            int buy_number = details[1];
            string token = level_vector->at(buy_number).token;
            int coin_color = 0;
            if(token == "white")
                coin_color = WHITE;
            else if(token =="blue")
                coin_color = BLUE;
            else if(token =="green")
                coin_color = GREEN;
            else if(token =="red")
                coin_color = RED;
            else if(token =="black")
                coin_color = BLACK;

            //card score
            int score = level_vector->at(buy_number).point;
            cout<<score<<endl;
            if (game_state == PLAYER_TURN)
                player_score += score;
            else if (game_state == AI_TURN)
                ai_score += score;
            
            //move card 
            card_vector->at(coin_color).push_back(level_vector->at(buy_number));
            level_vector->erase(level_vector->begin() + (buy_number));

            //card update move
            make_know_array_for_card_move(updator, type, card_vector->at(coin_color).back().name, "field", name);
            
            //charge card
            std::vector<custom_msgs::card>* fold_vector;
            if (details[0] == LEVEL1)
                fold_vector = &level1_fold;
            else if (details[0] == LEVEL2)
                fold_vector = &level2_fold;
            else if (details[0] == LEVEL3)
                fold_vector = &level3_fold;
            if (!fold_vector->empty()) {
                int rand_num = rand() % fold_vector->size();
                level_vector->push_back(fold_vector->at(rand_num));
                fold_vector->erase(fold_vector->begin() + rand_num);
            }
            make_know_array_for_card_open(updator, type, level_vector->back().name);


            //TODO: check nobility
            vector<int> check;
            for (int i = 0; i < nobility_open.size(); i++) {
                int j = 0;
                for (j = 0; j < 5; j++) {  //check nobility
                    if (select_color_from_card(&nobility_open[i], j) > card_vector->at(j).size())
                        break;
                }

                if (j == 5) {  //get and save nobility
                    check.push_back(i);
                    card_vector->at(5).push_back(nobility_open[i]);
                    score = nobility_open[i].point;
                    if (game_state == PLAYER_TURN)
                        player_score += score;
                    else if (game_state == AI_TURN)
                        ai_score += score;

                    //update KB nobility
                    //card update move
                    make_know_array_for_card_move(updator, type, card_vector->at(5).back().name, "field", name);
                }
            }
            //remove nobility from field
            for (int i = nobility_open.size() - 1; i >= 0; i--) {
                if (find(check.begin(), check.end(), i) != check.end()) {
                    nobility_open.erase(nobility_open.begin() + i);
                }
            }

            int final_score = 0;
            if (game_state == PLAYER_TURN)
                final_score = player_score;
            else if (game_state == AI_TURN)
                final_score = ai_score;

            make_know_array_for_score(updator, type, final_score, name);

            rosplan_knowledge_msgs::KnowledgeUpdateServiceArray srv;
            srv.request.update_type = type;
            srv.request.knowledge = updator;
            update_knowledge_client.call(srv);  //call update array


            if(final_score >= 15){
                if(game_state == PLAYER_TURN)
                {
                    cout<<"player win"<<endl;
                }
                else{
                    cout<<"ai win"<<endl;
                }
                game_state=WAIT;
            }
            return true;

        } else {
            return false;
        }
    }



}
//close namespace

int main(int argc, char **argv)
{
    ros::init(argc, argv, "board");//,  ros::init_options::NoSigintHandler);
    ros::NodeHandle nh("~");
    srand((unsigned int)time(NULL));        //set random seed
    //signal(SIGINT, my_handler);
    Custom::Board bi(nh);
    //b = &bi;

    //service
    ros::ServiceServer do_action = nh.advertiseService("/board/do_action", &Custom::Board::do_action_callback, dynamic_cast<Custom::Board *>(&bi));

    //subscriber
    

    std::cout<<"ready to run board"<<std::endl;
    ROS_INFO("Custom: (%s) Ready to receive", ros::this_node::getName().c_str());
    double act_time = 2;
    while (ros::ok())
    {
        sleep(0);
        double start_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
        ros::spinOnce();    //check sub and pub and srv

        bi.run_board(); //run_board and display


        double finish_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
        double rate = (double)(act_time * 1000000000 - (finish_time - start_time)) / 1000000000;
        if (rate > 0){
            ros::Rate wait = 1 / rate;
            wait.sleep();
        }
    }

        
    return 0;
}

void print_log(string node_name, string func,string str){
	cout<< "[";
	cout.width(9);cout.fill(' ');cout<<fixed;cout.precision(3);
	cout<<std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::now().time_since_epoch()).count()/1000.0<<"][";
	cout.width(13);cout.fill(' ');
	cout<<node_name<<"][";
	cout.width(17);cout.fill(' ');
	cout<<func<<"] ( "<<str<<" )"<<endl;
}