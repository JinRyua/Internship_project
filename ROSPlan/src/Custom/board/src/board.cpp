#include "board/board.h"
#include "rosplan_knowledge_msgs/GetInstanceService.h"
#include "rosplan_knowledge_msgs/GetAttributeService.h"
#include "rosplan_knowledge_msgs/KnowledgeUpdateServiceArray.h"
#include "board/display_info.h"
#include "board/game_state_msg.h"
#include "board/set_ai_msg.h"
#include "board/change_state_msg.h"
#include "board/reset_ai_msg.h"
#include "diagnostic_msgs/KeyValue.h"


#include <iostream>
#include <string>
#include <chrono>
#include <algorithm>
#include <cmath>
#include <signal.h>

using namespace std;
void print_log(string node_name, string func,string str);


namespace Custom{
    Board::Board(ros::NodeHandle &nh)   //생성자
    {
        node_handle = &nh;  //get node handle

        game_state = IN_GAME; //init_state = select menu

        selecting_menu = MENU_START; //init_button = start button

        life = 3;           //game life
        score = 0;          //game score
        in_grid = true;     //start is in_grid
        ghost_time = 5;     //ghost_time
        ghost_timer = (double)(10000)*(double)(1000000000);    //ghost_timer

        //set client srv
        std::stringstream ss;
        ss.str("");
        ss << "/rosplan_knowledge_base/update_array";
        update_knowledge_client = node_handle->serviceClient<rosplan_knowledge_msgs::KnowledgeUpdateServiceArray>(ss.str());
        
        //set publisher
        std::string display_topic = "/board/display";
        nh.getParam("display_name", display_topic);
        display_pub = nh.advertise<board::display_info>(display_topic, 1000);

        std::string set_player_topic = "/player/set_player";
        nh.getParam("set_player_name", set_player_topic);
        set_player_pub = nh.advertise<board::set_ai_loc_msg>(set_player_topic, 1000);


        std::string state_response_topic = "/board/state_response";
        nh.getParam("state_response_name", state_response_topic);
        state_response_pub = nh.advertise<board::game_state_msg>(state_response_topic, 1000);

        std::string exit_call_topic = "/board/exit_call";
        nh.getParam("exit_call_name", exit_call_topic);
        exit_call_pub = nh.advertise<std_msgs::Empty>(exit_call_topic, 1000);

        std::string reset_AI_pub_topic = "/board/reset_ai";
        nh.getParam("reset_ai_name", reset_AI_pub_topic);
        reset_AI_pub = nh.advertise<board::reset_ai_msg>(reset_AI_pub_topic, 1000);

        

        std::string change_state_pub_topic = "/board/change_state";
        nh.getParam("change_state_name", change_state_pub_topic);
        change_state_pub = nh.advertise<board::change_state_msg>(change_state_pub_topic, 1000);

        kb = "/rosplan_knowledge_base/"; // "knowledge_base name";
        nh.getParam("knowledge_base", kb);


        //map_row, col get from kb
        ss.str("");
        ss << kb << "state/functions";
        ros::service::waitForService(ss.str(), ros::Duration(20));
        ros::ServiceClient row_client = nh.serviceClient<rosplan_knowledge_msgs::GetAttributeService>(ss.str());
        rosplan_knowledge_msgs::GetAttributeService row_srv;
        row_srv.request.predicate_name = "row";
        vector<rosplan_knowledge_msgs::KnowledgeItem> row_temp;     //get row
        if (row_client.call(row_srv)){
            row_temp = row_srv.response.attributes;
            map_row = row_temp[0].function_value;
        }
        else{
        }
        row_srv.request.predicate_name = "col";         //get col
        if (row_client.call(row_srv)){
            row_temp = row_srv.response.attributes;
            map_col = row_temp[0].function_value;
        }
        else{
        }


        //make map space
        init_map.resize(map_row);
        menu.resize(map_row);
    
        for (int i = 0; i < map_row; i++)           
        {   for (int j = 0; j < map_col + 1; j++)   //add \n in tail for making string after 
            {
                init_map[i].push_back(" ");
                menu[i].push_back(" ");
            }
            init_map[i][map_col] = "\n";
            menu[i][map_col] = "\n";
        }
        map = init_map; //set map to init_map

        //agents name and count get
        ss.str("");
        ss << kb << "state/instances";
        ros::service::waitForService(ss.str(), ros::Duration(20));
        ros::ServiceClient client = nh.serviceClient<rosplan_knowledge_msgs::GetInstanceService>(ss.str());
        rosplan_knowledge_msgs::GetInstanceService srv;
        srv.request.type_name = "agent";
        if (client.call(srv)){
            agent_names = srv.response.instances;
        }
        else{
        }

        for(int i = 0; i < agent_names.size(); i++){        //set agents' pub (set_ai)
            std::string set_ai_topic = "/board/set_ai/to_" + agent_names[i];
            ros::Publisher set_AI_pub_temp = nh.advertise<board::set_ai_msg>(set_ai_topic, 1000);
            set_AI_pub.push_back(set_AI_pub_temp);
        }

        // std::string set_ai_topic = "/board/set_ai";
        // nh.getParam("set_ai_name", set_ai_topic);
        // ros::Publisher set_AI_pub = nh.advertise<board::set_ai_msg>(set_ai_topic, 1000);

        ss.str("");     //get player and agent 's init_loc
        ss << kb << "state/propositions";
        ros::service::waitForService(ss.str(), ros::Duration(20));
        row_client = nh.serviceClient<rosplan_knowledge_msgs::GetAttributeService>(ss.str());
        row_srv.request.predicate_name = "in-block";
        vector<rosplan_knowledge_msgs::KnowledgeItem> play_agent_temp;
        if (row_client.call(row_srv)){
            play_agent_temp = row_srv.response.attributes;
        }
        else{
        }

        for(int i = 0; i < play_agent_temp.size(); i++){    //init player and agent 's loc
            string name;
            custom_msgs::axis ax;
            for(int j = 0; j < play_agent_temp[i].values.size(); j++){
                if(play_agent_temp[i].values[j].key == "c"){        //get 
                    name = play_agent_temp[i].values[j].value;
                }
                else if(play_agent_temp[i].values[j].key == "p"){       //get name
                    string temp_str = play_agent_temp[i].values[j].value;
                    int temp_point = temp_str.find("_");
                    ax.row = stoi(temp_str.substr(5, temp_point - 5));
                    ax.col = stoi(temp_str.substr(temp_point + 1));
                    ax.direction = 1;
                }
            }
            if(name == "player"){       //if player
                init_player.push_back(ax);
                player = init_player;
            }else{      //if agent
                init_agents.push_back(pair<custom_msgs::axis, bool>(ax, false));
                agents = init_agents;
            }
        }

        ros::service::waitForService(ss.str(), ros::Duration(20));      //get menu's screen (start, end)
        row_srv.request.predicate_name = "is-menu";
        vector<rosplan_knowledge_msgs::KnowledgeItem> menu_temp;
        if (row_client.call(row_srv)){
            menu_temp = row_srv.response.attributes;
        }
        else{
            cout<<"error"<<endl;
        }

        for(int i = 0; i < menu_temp.size(); i++){      //set menu's screen with block
            string name;
            custom_msgs::axis ax;
            if (menu_temp[i].values[0].key == "p"){
                string temp_str = menu_temp[i].values[0].value;
                int temp_point = temp_str.find("_");
                ax.row = stoi(temp_str.substr(5, temp_point - 5));
                ax.col = stoi(temp_str.substr(temp_point + 1));
                menu[ax.row - 1][ax.col - 1] = "■";
            }
        }

        ros::service::waitForService(ss.str(), ros::Duration(20));      //get init game map's block
        row_srv.request.predicate_name = "is-wall";
        vector<rosplan_knowledge_msgs::KnowledgeItem> map_temp;
        map_temp.clear();
        if (row_client.call(row_srv)){
            map_temp = row_srv.response.attributes;
        }
        else{
            cout<<"error"<<endl;
        }

        for(int i = 0; i < map_temp.size(); i++){           //set init game map's block
            string name;
            custom_msgs::axis ax;
            if (map_temp[i].values[0].key == "p"){
                string temp_str = map_temp[i].values[0].value;
                int temp_point = temp_str.find("_");
                ax.row = stoi(temp_str.substr(5, temp_point - 5));
                ax.col = stoi(temp_str.substr(temp_point + 1));
                init_map[ax.row - 1][ax.col - 1] = "■";
                block.push_back(ax);
            }
        }

        ros::service::waitForService(ss.str(), ros::Duration(20));  //get init game's ghost
        row_srv.request.predicate_name = "is-ghost";
        map_temp.clear();
        if (row_client.call(row_srv)){
            map_temp = row_srv.response.attributes;
        }
        else{
            cout<<"error"<<endl;
        }

        for(int i = 0; i < map_temp.size(); i++){       //set init game's ghost
            string name;
            if (map_temp[i].values[0].key == "a"){
                string temp_str = map_temp[i].values[0].value;
                int j;
                for (j = 0; j < agent_names.size(); j++) {
                    if (temp_str == agent_names[j])
                        break;
                }
                if (j < agent_names.size())
                    agents[j].second = true;  //ghost
            }
        }

        ros::service::waitForService(ss.str(), ros::Duration(20));  //get init game map's small cookie
        row_srv.request.predicate_name = "is-scookie";
        map_temp.clear();
        if (row_client.call(row_srv)){
            map_temp = row_srv.response.attributes;
        }
        else{
            cout<<"error"<<endl;
        }

        for(int i = 0; i < map_temp.size(); i++){       //set init game map's small cookie
            string name;
            custom_msgs::axis ax;
            if (map_temp[i].values[0].key == "p"){
                string temp_str = map_temp[i].values[0].value;
                int temp_point = temp_str.find("_");
                ax.row = stoi(temp_str.substr(5, temp_point - 5));
                ax.col = stoi(temp_str.substr(temp_point + 1));
                scookies.push_back(ax);
                init_map[ax.row - 1][ax.col - 1] = "·";
            }
        }

        ros::service::waitForService(ss.str(), ros::Duration(20));      //get init game map's large cookie
        row_srv.request.predicate_name = "is-lcookie";
        map_temp.clear();
        if (row_client.call(row_srv)){
            map_temp = row_srv.response.attributes;
        }
        else{
            cout<<"error"<<endl;
        }

        for(int i = 0; i < map_temp.size(); i++){       //set init game map's large cookie
            string name;
            custom_msgs::axis ax;
            if (map_temp[i].values[0].key == "p"){
                string temp_str = map_temp[i].values[0].value;
                int temp_point = temp_str.find("_");
                ax.row = stoi(temp_str.substr(5, temp_point - 5));
                ax.col = stoi(temp_str.substr(temp_point + 1));
                lcookies.push_back(ax);
                init_map[ax.row - 1][ax.col - 1] = "●";
            }
        }

        map = init_map;         //init maps
        init_lcookies = lcookies;
        init_scookies = scookies;


        post_knowledge.knowledge_type = 1;   //FACT     //make knowledge player's
        post_knowledge.attribute_name = "in-block";

        vector<diagnostic_msgs::KeyValue> temp;
        diagnostic_msgs::KeyValue value;
        value.key = "c";
        value.value = "player";
        temp.push_back(value);
        value.key = "p";
        value.value = "point" + to_string((int)(player[0].row)) + "_" + to_string((int)(player[0].col));
        temp.push_back(value);

        post_knowledge.values = temp;
        knowledge = post_knowledge;

        string path = "firefox /home/jylee/jylee/ROSPlan/src/a.html &";
        system(path.c_str());      //exec display
    }

    Board::~Board() 
    {   
    }
    
    void Board::check_timer(){
        double now_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
        if(ghost_timer <= now_time ){    //run out ghost timer
            for(int i = 0; i < agents.size(); i++){ //norm  every agent
                agents[i].second = false;
                board::set_ai_msg temp;
                temp.loc = agents[i].first;
                temp.speed = 2;

                set_AI_pub[i].publish(temp);
            }

            //update KB
            rosplan_knowledge_msgs::KnowledgeItem know;
            vector<diagnostic_msgs::KeyValue> temp_val;
            diagnostic_msgs::KeyValue value;
            vector<unsigned char> type;
            vector<rosplan_knowledge_msgs::KnowledgeItem> knows;  //array

            for (int i = 0; i < agents.size(); i++) {
                //make knowledge    //ghost
                know.knowledge_type = 1;           //FACT
                know.attribute_name = "is-ghost";  //ghost operator

                value.key = "a";
                value.value = agent_names[i];
                temp_val.push_back(value);
                know.values = temp_val;
                temp_val.clear();
                knows.push_back(know);
                type.push_back(2);  //REMOVE_KNOWLEDGE
            }

            rosplan_knowledge_msgs::KnowledgeUpdateServiceArray srv;
            srv.request.update_type = type;
            srv.request.knowledge = knows;

            update_knowledge_client.call(srv);  //call update array

            //publish
            ros::MessageEvent<std_msgs::Empty> temp_call;

            cout<< "call_Replan timer"<<endl;
            ask_state_callback(temp_call);
            ghost_timer = now_time + ((double)(1000)*(1000000000));
        }
    }
    void Board::run_board() {
        board::display_info display_temp;
        vector<custom_msgs::map> map_temp2;
        custom_msgs::map map_temp;
        if (game_state == IN_GAME) {
            
            check_timer();  //timer check
            check_eat_star();
            check_collision();
            //display map
            for (int i = 0; i < map.size(); i++) {
                map_temp.value = map[i];
                map_temp2.push_back(map_temp);
            }
            display_temp.map = map_temp2;
            //display player
            display_temp.player_axis = player;
            //display agent
            std::vector<custom_msgs::axis> agent_temp;
            std::vector<int> ghost_temp;
            for (int i = 0; i < agents.size(); i++) {
                agent_temp.push_back(agents[i].first);
                ghost_temp.push_back(agents[i].second);
            }
            display_temp.agents_axis = agent_temp;
            display_temp.ghost = ghost_temp;

            //display wall(block)
            display_temp.block = block;
            //display cookies
            display_temp.scookies_loc = scookies;
            display_temp.lcookies_loc = lcookies;
            //display score
            display_temp.score = score;
            //display life
            display_temp.life = life;
            //display selecting_menu
            display_temp.selecting_menu = selecting_menu;
            //display map_row_col
            display_temp.map_row = map_row;
            display_temp.map_col = map_col;
        } else if (game_state == IN_MENU) {
            //display map
            for (int i = 0; i < map.size(); i++) {
                map_temp.value = menu[i];
                map_temp2.push_back(map_temp);
            }
            display_temp.map = map_temp2;
            display_temp.selecting_menu = selecting_menu;
        }
        //publish to display
        display_pub.publish(display_temp);
        ros::spinOnce();
    }
    void Board::check_eat_star(){
        if(in_grid == true){
            custom_msgs::axis temp;
            temp.row = round(player[0].row);
            temp.col = round(player[0].col);

            auto s_it = find(scookies.begin(), scookies.end(), temp);
            if(s_it != scookies.end()){ //eat small cookie
                scookies.erase(s_it);   //erase small_cookie
                map[(int)(temp.row - 1)][(int)(temp.col - 1)] = " ";
                
                //update score
                score ++;

                //update KB
                rosplan_knowledge_msgs::KnowledgeItem know;
                know.knowledge_type = 1;  //FACT     //make knowledge player's
                know.attribute_name = "is-scookie";

                vector<diagnostic_msgs::KeyValue> temp_val;
                diagnostic_msgs::KeyValue value;
                value.key = "p";
                value.value = "point" + to_string((int)(temp.row)) + "_" + to_string((int)(temp.col));
                temp_val.push_back(value);
                know.values = temp_val;
                vector<unsigned char> type;  //update KB
                vector<rosplan_knowledge_msgs::KnowledgeItem> knows;

                type.push_back(2);  //remove present
                knows.push_back(know);
                rosplan_knowledge_msgs::KnowledgeUpdateServiceArray srv;
                srv.request.update_type = type;
                srv.request.knowledge = knows;

                update_knowledge_client.call(srv);                   //call update array

            }
            else{
                auto l_it = find(lcookies.begin(), lcookies.end(), temp);
                if(l_it != lcookies.end()){ //eat large cookie
                    lcookies.erase(l_it);   //erase large cookie
                    map[(int)(temp.row - 1)][(int)(temp.col - 1)] = " ";
                    //update score and ghost
                    score = score + 5;
                    for(int i = 0; i < agents.size(); i++){
                        agents[i].second = true;    //set ghost all
                        board::set_ai_msg temp;
                        temp.loc = agents[i].first;
                        temp.speed = 1.5;
                        set_AI_pub[i].publish(temp);
                    }

                    //update KB
                    rosplan_knowledge_msgs::KnowledgeItem know;     
                    know.knowledge_type = 1;  //FACT     //make knowledge lcookie's
                    know.attribute_name = "is-lcookie";

                    vector<diagnostic_msgs::KeyValue> temp_val;
                    diagnostic_msgs::KeyValue value;
                    value.key = "p";
                    value.value = "point" + to_string((int)(temp.row)) + "_" + to_string((int)(temp.col));
                    temp_val.push_back(value);
                    know.values = temp_val;

                    vector<unsigned char> type;  
                    vector<rosplan_knowledge_msgs::KnowledgeItem> knows;       //array

                    type.push_back(2);  //remove present
                    knows.push_back(know);
                    temp_val.clear();

                    for (int i = 0; i < agents.size(); i++) {
                        //make knowledge    //ghost
                        know.knowledge_type = 1;           //FACT
                        know.attribute_name = "is-ghost";  //ghost operator

                        value.key = "a";
                        value.value = agent_names[i];
                        temp_val.push_back(value);
                        know.values = temp_val;
                        temp_val.clear();
                        knows.push_back(know);

                        if (agents[i].second == true) {  //set type
                            type.push_back(0);   //ADD_KNOWLEDGE
                        } else {
                            type.push_back(2);  //REMOVE_KNOWLEDGE
                        }
                    }

                    rosplan_knowledge_msgs::KnowledgeUpdateServiceArray srv;
                    srv.request.update_type = type;
                    srv.request.knowledge = knows;

                    update_knowledge_client.call(srv);  //call update array

                    //publish
                    ros::MessageEvent<std_msgs::Empty> temp_call;
                    ask_state_callback(temp_call);

                    board::change_state_msg tm;  //player stay
                    tm.state = "wait";
                    change_state_pub.publish(tm);
                    cout<< "call_Replan"<<endl;

                    //ghost timer
                    ghost_timer = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
                    ghost_timer += ghost_time * 1000000000; //일정 시간만큼

                }
                
            }
           
        }
    }
    void Board::check_collision(){
        float player_row = player[0].row;
        float player_col = player[0].col;

        for(int i = 0; i < agents.size(); i++){ //every agent
            float agent_left = agents[i].first.col - 0.5;       //one grid from agent's loc
            float agent_right = agents[i].first.col + 0.5;
            float agent_top = agents[i].first.row - 0.5;
            float agent_bottom = agents[i].first.row + 0.5;

            if(player_row >= agent_top && player_row <= agent_bottom)       //collision
                if(player_col >= agent_left && player_col <= agent_right){
                    do_collision(agents[i], i);
                }
        }
    }

    void Board::do_collision(pair<custom_msgs::axis, bool>& agent, int i){
        if(agent.second == true){   //eat ghost
            print_log("board", __func__, "eat ghost");
            score = score + 3;
            //need init
            
            agents[i].second = false; //not ghost
            board::set_ai_msg temp;
            agents[i] = init_agents[i];
            temp.loc = init_agents[i].first;
            temp.speed = 2;
            set_AI_pub[i].publish(temp);


            //update KB
            vector<unsigned char> type;
            vector<rosplan_knowledge_msgs::KnowledgeItem> knows;  //array
            rosplan_knowledge_msgs::KnowledgeItem know;
            vector<diagnostic_msgs::KeyValue> temp_val;
            diagnostic_msgs::KeyValue value;

            type.push_back(2);  //remove present
            knows.push_back(know);
            temp_val.clear();

            //make knowledge    //ghost
            know.knowledge_type = 1;           //FACT
            know.attribute_name = "is-ghost";  //ghost operator

            value.key = "a";
            value.value = agent_names[i];
            temp_val.push_back(value);
            know.values = temp_val;
            knows.push_back(know);

            type.push_back(2);  //REMOVE_KNOWLEDGE

            rosplan_knowledge_msgs::KnowledgeUpdateServiceArray srv;
            srv.request.update_type = type;
            srv.request.knowledge = knows;

            update_knowledge_client.call(srv);  //call update array

            board::change_state_msg tm;      //player stay
            tm.state = "wait";
            change_state_pub.publish(tm);

            ros::MessageEvent<std_msgs::Empty> temp_call;
            ask_state_callback(temp_call);  //call replan
        }
        else{   //eat player
            print_log("board", __func__, "ghost eat player");
            board::reset_ai_msg temp;
            agents = init_agents;
            temp.loc = init_agents[0].first;
            reset_AI_pub.publish(temp);

            board::set_ai_loc_msg temp2;
            player = init_player;
            temp2.loc = init_player[0];
            cout<<init_player[0].direction<<endl;
            set_player_pub.publish(temp2);

            vector<unsigned char> type;         //update KB
            vector<rosplan_knowledge_msgs::KnowledgeItem> know;

            type.push_back(2);  //remove present
            know.push_back(post_knowledge);
            rosplan_knowledge_msgs::KnowledgeUpdateServiceArray srv;

            type.push_back(0);                                   //ADD present(next GRID)
            for (int i = 0; i < knowledge.values.size(); i++) {  //make knowledge
                if (knowledge.values[i].key == "p") {
                    knowledge.values[i].value = "point" + to_string((int)(player[0].row)) + "_" + to_string((int)(player[0].col));
                    break;
                }
            }
            know.push_back(knowledge);
            srv.request.update_type = type;
            srv.request.knowledge = know;

            post_knowledge = knowledge;

            update_knowledge_client.call(srv);  //call update array

            board::change_state_msg tm;      //player stay
            tm.state = "wait";
            change_state_pub.publish(tm);

            ros::MessageEvent<std_msgs::Empty> temp_call;
            ask_state_callback(temp_call);  //call replan

            life--;
            cout<<life<<endl;
            if(life == 0){
                cout<<"game end => score : "<<score <<endl;
                std_msgs::Empty exit_temp;
                exit_call_pub.publish(exit_temp);
                exit(0);
            }
            //need init
        }
    }
    
    //service callback 들 
    bool Board::ask_map_size_callback(board::ask_map_size::Request& req, board::ask_map_size::Response& res){
        res.row = map_row;
        res.col = map_col;
    }
    bool Board::ask_agent_srv_callback(board::ask_agent_srv::Request &req, board::ask_agent_srv::Response &res){
        //return agent_names
        res.agents_name = agent_names;
        return true;
    }
    bool Board::move_check_srv_callback(board::move_check_srv::Request &req, board::move_check_srv::Response &res){
        //move check
        if((player[0].direction + req.want_direction) % 2 != 0){
            if(in_grid == false){
                res.direction = player[0].direction;
                return true;
            }
            else if(in_grid == true){
                int player_row = round(player[0].row);
                int player_col = round(player[0].col);
                if(req.want_direction == LEFT){ player_col--;}
                else if(req.want_direction == RIGHT){ player_col++;}
                else if(req.want_direction == UP){ player_row--;}
                else if(req.want_direction == DOWN){ player_row++;}

                if(map[player_row-1][player_col-1] == "■"){
                    int player_row = round(player[0].row);
                    int player_col = round(player[0].col);
                    if(player[0].direction == LEFT){ player_col--;}
                    else if(player[0].direction == RIGHT){ player_col++;}
                    else if(player[0].direction == UP){ player_row--;}
                    else if(player[0].direction == DOWN){ player_row++;}
                    if(map[player_row-1][player_col-1] == "■"){
                        int direction_left = player[0].direction - 1;
                        if (direction_left == 0)
                            direction_left = 4;
                        int player_row = round(player[0].row);
                        int player_col = round(player[0].col);
                        if(direction_left == LEFT){ player_col--;}
                        else if(direction_left == RIGHT){ player_col++;}
                        else if(direction_left == UP){ player_row--;}
                        else if(direction_left == DOWN){ player_row++;}
                        if(map[player_row-1][player_col-1] == "■"){
                            int direction_right = player[0].direction +1;
                            if (direction_right == 5)
                                direction_right = 1;
                            int player_row = round(player[0].row);
                            int player_col = round(player[0].col);
                            if(direction_right == LEFT){ player_col--;}
                            else if(direction_right == RIGHT){ player_col++;}
                            else if(direction_right == UP){ player_row--;}
                            else if(direction_right == DOWN){ player_row++;}
                            if(map[player_row-1][player_col-1] == "■"){return false;}
                            else{
                                res.direction = direction_right;
                                return true;
                            }
                        }
                        else{
                            res.direction = direction_left;
                            return true;
                        }
                    }
                    else{
                        res.direction = player[0].direction;
                        return true;
                    }

                }
                else{
                    res.direction = req.want_direction;
                    return true;
                }

            }
        }
        else if(player[0].direction != req.want_direction){
            res.direction = req.want_direction;
            return true;
        }
        else if(in_grid == true){
            int player_row = round(player[0].row);
            int player_col = round(player[0].col);
            if(player[0].direction == LEFT){ player_col--;}
            else if(player[0].direction == RIGHT){ player_col++;}
            else if(player[0].direction == UP){ player_row--;}
            else if(player[0].direction == DOWN){ player_row++;}

            if(map[player_row-1][player_col-1] == "■"){
                player_row = round(player[0].row);
                player_col = round(player[0].col);
                int direction_left = player[0].direction - 1;
                if (direction_left == 0)
                    direction_left = 4;

                if (direction_left == LEFT){
                    player_col--;
                }
                else if (direction_left == RIGHT){
                    player_col++;
                }
                else if (direction_left == UP){
                    player_row--;
                }
                else if (direction_left == DOWN){
                    player_row++;
                }

                if (map[player_row - 1][player_col - 1] != "■"){
                    res.direction = direction_left;
                    return true;
                }
                else{
                    player_row = round(player[0].row);
                    player_col = round(player[0].col);
                    int direction_right = player[0].direction + 1;
                    if (direction_right == 5)
                        direction_right = 1;

                    if (direction_right == LEFT){
                        player_col--;
                    }
                    else if (direction_right == RIGHT){
                        player_col++;
                    }
                    else if (direction_right == UP){
                        player_row--;
                    }
                    else if (direction_right == DOWN){
                        player_row++;
                    }

                    if (map[player_row - 1][player_col - 1] != "■"){
                        res.direction = direction_right;
                        return true;
                    }
                    else{
                        return false;
                    }
                }
            }
            else{
                res.direction = req.want_direction;
                return true;
            }  
        }
        else if(in_grid == false){
            res.direction = player[0].direction;
            return true;
        }
        
        return false;
    }
    bool Board::player_action_callback(board::player_act_srv::Request& req, board::player_act_srv::Response& res){

        custom_msgs::axis loc = req.loc;
        int point_row = (int)(max(loc.row, player[0].row));
        int point_col = (int)(max(loc.col, player[0].col));
        
        //cout<<in_grid<<endl;
        // if((loc.row >= point_row && point_row > player[0].row) ||
        //     (loc.row < point_row && point_row <= player[0].row) ||
        //     (loc.col >= point_col && point_col > player[0].col) ||
        //     (loc.col < point_col && point_col <= player[0].col) )
        if(in_grid == false && (abs(ceil(loc.row) - ceil(player[0].row))!=0 ||
            abs(ceil(loc.col) - ceil(player[0].col))!=0))
            {
                //cout<<"grid "<<loc.row<<" "<<loc.col<<" "<<player[0].row<<" "<<player[0].col<<endl;
            in_grid = true;

            float point_row = loc.row;
            float point_col = loc.col;
            if(req.loc.direction == LEFT)
                point_col = floor(player[0].col);
            else if(req.loc.direction == UP)
                point_row = floor(player[0].row);
            else if(req.loc.direction == RIGHT)
                point_col = ceil(player[0].col);
            else if(req.loc.direction == DOWN)
                point_row = ceil(player[0].row);
                


            res.result.row = point_row;
            res.result.col = point_col;
            res.result.direction = req.loc.direction;

            player[0] = res.result;

            vector<unsigned char> type;         //update KB
            vector<rosplan_knowledge_msgs::KnowledgeItem> know;

            type.push_back(2);  //remove present
            know.push_back(post_knowledge);
            rosplan_knowledge_msgs::KnowledgeUpdateServiceArray srv;

            type.push_back(0);                                   //ADD present
            for (int i = 0; i < knowledge.values.size(); i++) {  //make knowledge
                if (knowledge.values[i].key == "p") {
                    knowledge.values[i].value = "point" + to_string((int)(player[0].row)) + "_" + to_string((int)(player[0].col));
                    break;
                }
            }
            know.push_back(knowledge);
            srv.request.update_type = type;
            srv.request.knowledge = know;

            post_knowledge = knowledge;

            update_knowledge_client.call(srv);  //call update array

            return true;
        }
        else{
            in_grid = false;
            //TODO:

            res.result = req.loc;       //across map
            if(req.loc.col <= 0.5){
                res.result.col = map_col + 0.5 - req.loc.col;
            }
            else if(req.loc.col > map_col + 0.5 )
                res.result.col = req.loc.col - map_col - 0.5;

            player[0] = res.result;
            return true;
        }
        return false;
    }
    bool Board::ask_player_stat_srv_callback(board::ask_player_stat_srv::Request& req, board::ask_player_stat_srv::Response& res){
        res.player = init_player;
        return true;
    }

    //sub callback
    void Board::ask_state_callback(const ros::MessageEvent<std_msgs::Empty>& msg){
        //const std::string& publisher_name = msg.getPublisherName(); //get publisher name
        board::game_state_msg temp;
        temp.player_axis = player;
        temp.lcookies_loc = lcookies;

        vector<custom_msgs::map> map_temp2;
        custom_msgs::map map_temp;
        //make map -> custom_msgs/map
        for (int i = 0; i < map.size(); i++){
            map_temp.value = map[i];
            map_temp2.push_back(map_temp);
        }
        temp.map = map_temp2;
        //make agent
        std::vector<custom_msgs::axis> agent_temp;
        std::vector<int> ghost_temp;
        for (int i = 0; i < agents.size(); i++){
            agent_temp.push_back(agents[i].first);
            ghost_temp.push_back(agents[i].second);
        }
        temp.agents_axis = agent_temp;
        temp.ghost = ghost_temp;
        for(int i =0 ;i<ghost_temp.size();i++){
            //cout<<ghost_temp[i]<<" "<<agents[i].second<<endl;
        }

        state_response_pub.publish(temp);

        return;
    }
    void Board::select_menu_callback(const board::select_menu_msg& msg){
        if(msg.action == "select"){
            if(selecting_menu == MENU_START){
                
            }
            else if(selecting_menu == MENU_END){
                std_msgs::Empty e;
                exit_call_pub.publish(e);
                exit(0);
            }
        }
        else if(msg.action == "move"){
            selecting_menu++;
            if(selecting_menu > MENU_END)
                selecting_menu = MENU_START;
        }
        return;
    }
    
    void Board::set_ai_loc_callback(const ros::MessageEvent<board::set_ai_loc_msg>& msg){
        std::string publisher_name = msg.getPublisherName(); //get publisher name
        const board::set_ai_loc_msg::ConstPtr& data = msg.getMessage();
        int point = publisher_name.find("/");
        publisher_name = publisher_name.substr(point+1);
        int i = 0;
        for(i = 0; i < agent_names.size(); i++){
            if(agent_names[i] == publisher_name){
                break;
            }
        }

        if(i < agent_names.size()){
            agents[i].first = data->loc;
        }

        //for (int i = 0; i < agent_names.size(); i++) {
            //cout<<publisher_name<<" "<< agents[i].first.row<<", "<<agents[i].first.col<<endl;
        //}
        return;
    }

    bool Board::ask_map_callback(board::ask_map_srv::Request& req, board::ask_map_srv::Response& res){
        vector<custom_msgs::map> map_temp;
        for(int i = 0; i < map.size(); i++){
            custom_msgs::map temp;
            temp.value = map[i];
            map_temp.push_back(temp);
        }
        res.map = map_temp;
        return true;
    }
    void Board::exit_callback(const std_msgs::Empty& msg){
        exit(0);

    }
}//close namespace

int main(int argc, char **argv)
{
    ros::init(argc, argv, "board");//,  ros::init_options::NoSigintHandler);
    ros::NodeHandle nh("~");
    //signal(SIGINT, my_handler);
    Custom::Board bi(nh);
    //b = &bi;

    //service
    ros::ServiceServer ask_map_size = nh.advertiseService("/board/ask_map_size", &Custom::Board::ask_map_size_callback, dynamic_cast<Custom::Board *>(&bi));
    ros::ServiceServer move_check = nh.advertiseService("/board/move_check", &Custom::Board::move_check_srv_callback, dynamic_cast<Custom::Board *>(&bi));
    ros::ServiceServer player_action_srv = nh.advertiseService("/board/player_action", &Custom::Board::player_action_callback, dynamic_cast<Custom::Board *>(&bi));
    ros::ServiceServer aks_agent_srv = nh.advertiseService("/board/ask_agent", &Custom::Board::ask_agent_srv_callback, dynamic_cast<Custom::Board *>(&bi));
    ros::ServiceServer aks_player_stat_srv = nh.advertiseService("/board/ask_player_stat", &Custom::Board::ask_player_stat_srv_callback, dynamic_cast<Custom::Board *>(&bi));
    ros::ServiceServer aks_map_srv = nh.advertiseService("/board/ask_map", &Custom::Board::ask_map_callback, dynamic_cast<Custom::Board *>(&bi));
    

    //subscriber
    ros::Subscriber ask_state_sub = nh.subscribe("/board/ask_state", 1, &Custom::Board::ask_state_callback, dynamic_cast<Custom::Board *>(&bi));
    ros::Subscriber select_menu_sub = nh.subscribe("/board/select_menu", 100, &Custom::Board::select_menu_callback, dynamic_cast<Custom::Board *>(&bi));
    ros::Subscriber set_ai_loc_sub = nh.subscribe("/board/set_ai_loc", 10000, &Custom::Board::set_ai_loc_callback, dynamic_cast<Custom::Board *>(&bi));
    ros::Subscriber exit_sub = nh.subscribe("/board/exit_call", 1, &Custom::Board::exit_callback, dynamic_cast<Custom::Board *>(&bi));
    

    std::cout<<"ready to run board"<<std::endl;
    // ROS_INFO("Custom: (%s) Ready to receive", ros::this_node::getName().c_str());
    double act_time = 0.04;
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