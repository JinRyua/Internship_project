#include "rosplan_planning_system/PlannerInterface/MINIMAXPlannerInterface.h"
#include "rosplan_knowledge_msgs/GetDomainOperatorService.h"
#include "rosplan_knowledge_msgs/GetInstanceService.h"
#include "rosplan_knowledge_msgs/GetAttributeService.h"
#include "rosplan_knowledge_msgs/DomainFormula.h"
#include "diagnostic_msgs/KeyValue.h"
#include "log_display/log_msg.h"

using namespace std;

std::vector<std::string> split(std::string input, char delimiter);

namespace KCL_rosplan {

	/*-------------*/
	/* constructor */
	/*-------------*/

	MINIMAXPlannerInterface::MINIMAXPlannerInterface(ros::NodeHandle& nh)
	{
		node_handle = &nh;

		plan_server = new actionlib::SimpleActionServer<rosplan_dispatch_msgs::PlanAction>((*node_handle), "start_planning", boost::bind(&PlannerInterface::runPlanningServerAction, this, _1), false);

		// publishing raw planner output
		std::string plannerTopic = "planner_output";
		node_handle->getParam("planner_topic", plannerTopic);
		plan_publisher = node_handle->advertise<std_msgs::String>(plannerTopic, 1, true);

        std::string log_topic = "/log_display/log";
		log_display_pub = node_handle->advertise<log_display::log_msg>(log_topic, 1, true);

        name = "ai1";
        node_handle->getParam("planner_name", name);
        cout<<"node_name : "<<name<<endl;

		// start planning action server
		plan_server->start();

        //set hyper parameter
        hyper_game = 10;
        hyper_level = 1;
        hyper_nobility = 2;
        hyper_card = 40;
        planning_depth = DEPTH; //1

        double value = -1;
        node_handle->getParam("hyper_nobility", value);
        if(value != -1)
            hyper_nobility = value;
        
        value = -1;
        node_handle->getParam("hyper_level", value);
        if(value != -1)
            hyper_level = value;

        value = -1;
        node_handle->getParam("planning_depth", value);
        if (value != -1)
            planning_depth = value;
        cout<<"!!"<<planning_depth<<hyper_nobility<<hyper_level<<endl;
        cout<<"node_name : "<<name<<endl;

		
	}
	
	MINIMAXPlannerInterface::~MINIMAXPlannerInterface()
	{
		delete plan_server;
	}

	/**
	 * Runs external commands
	 */
	std::string MINIMAXPlannerInterface::runCommand(std::string cmd) {
		std::string data;
		FILE *stream;
		char buffer[1000];
		stream = popen(cmd.c_str(), "r");
		while ( fgets(buffer, 1000, stream) != NULL )
			data.append(buffer);
		pclose(stream);
		return data;
	}

	/*------------------*/
	/* Plan and process */
	/*------------------*/

	/**
	 * passes the problem to the Planner; the plan to post-processing.
	 */
	bool MINIMAXPlannerInterface::runPlanner() {

        cout<<"go planner"<<endl;

        string kb = "/rosplan_knowledge_base/"; // "knowledge_base name";
        node_handle->getParam("knowledge_base", kb);

        problem_info problem;
        problem.player_names.push_back("/player");
        problem.player_names.push_back("/ai1");

        std::vector<std::string> player_names;
        player_names.push_back("/player");
        player_names.push_back("/ai1");

        problem.player_card.resize(6);
        problem.ai_card.resize(6);

		//make new problem for csp
        make_problem_for_csp(problem_instance, problem);
        double a = minimax(problem, true, 0, name, MAX_INFINITE, MIN_INFINITE);
        //cout<<"hi"<<endl;
        // std_msgs::String planMsg;
        make_plan(planner_output, problem);
        // planMsg.data = planner_output;
        bool solved = true;
        //plan_publisher.publish(planMsg);

		if(!solved) ROS_INFO("KCL: (%s) (%s) Plan was unsolvable.", ros::this_node::getName().c_str(), problem_name.c_str());
		else{ ROS_INFO("KCL: (%s) (%s) Plan was solved.", ros::this_node::getName().c_str(), problem_name.c_str());
			
            make_pddl_from_csp(planner_output, data_path + "plan.pddl");
            std_msgs::String planMsg;
            planMsg.data = planner_output;  //publish
            plan_publisher.publish(planMsg);
            cout << "pub plan" << endl;
        }
		// make_plan();

		// 

		return solved;
	}

    void MINIMAXPlannerInterface::make_problem_for_csp(string& problem_instance, problem_info& problem){
        ROS_INFO("KCL: (%s) (%s) start to make problem for csp.", ros::this_node::getName().c_str(), problem_name.c_str());
        std::string new_str = "";
        int point = problem_instance.find("- nobility");  //nobility check
        int temp_point = problem_instance.find("- ai");
        std::string str = problem_instance.substr(temp_point + 4, point - (temp_point + 4));
        std::vector<std::string> nobility;
        nobility = split(str, ' ');
        nobility.erase(nobility.begin());  //erase \n
        for(int i = 0;i<nobility.size();i++){
            custom_msgs::card temp;
            temp.name = nobility[i];
            problem.nobility_fold.push_back(temp);
        }

        temp_point = point;
        point = problem_instance.find("- level1");  //level1 check
        str = problem_instance.substr(temp_point + 10, point - (temp_point + 10));
        std::vector<std::string> level1;
        level1 = split(str, ' ');
        level1.erase(level1.begin());  //erase \n
        for(int i = 0;i<level1.size();i++){
            custom_msgs::card temp;
            temp.name = level1[i];
            problem.level1_fold.push_back(temp);
        }

        temp_point = point;
        point = problem_instance.find("- level2");  //level2 check
        str = problem_instance.substr(temp_point + 8, point - (temp_point + 8));
        std::vector<std::string> level2;
        level2 = split(str, ' ');
        level2.erase(level2.begin());  //erase \n
        for(int i = 0;i<level2.size();i++){
            custom_msgs::card temp;
            temp.name = level2[i];
            problem.level2_fold.push_back(temp);
        }

        temp_point = point;
        point = problem_instance.find("- level3");  //level3 check
        str = problem_instance.substr(temp_point + 8, point - (temp_point + 8));
        std::vector<std::string> level3;
        level3 = split(str, ' ');
        level3.erase(level3.begin());  //erase \n
        for(int i = 0;i<level3.size();i++){
            custom_msgs::card temp;
            temp.name = level3[i];
            problem.level3_fold.push_back(temp);
        }
        cout<<"finish card name"<<endl;

        point = 0;
        while (1) { //card color check
            point = problem_instance.find("s-color", point + 1);    
            if(point == -1) break;
            temp_point = problem_instance.find(")", point + 1);
            str = problem_instance.substr(point + 7, temp_point - (point + 7));
            vector<string> temp = split(str, ' ');
            vector<custom_msgs::card>& temp_vector = select_vector(temp[0], problem.level1_fold, problem.level2_fold, problem.level3_fold, problem.nobility_fold);
            
            int i = 0;
            for (i = 0; i < temp_vector.size(); i++) {
                if (temp_vector[i].name == temp[0])
                    break;
            }
            custom_msgs::card& card = temp_vector[i];
            card.token = temp[1];
        }

        cout<<"finish save card color from problem"<<endl;
        point = 0;
        while (1) { //card need token check
            point = problem_instance.find("need-token", point + 1);  
            if (point == -1) break;
            temp_point = problem_instance.find(")", point + 1);
            int temp_point2 = problem_instance.find(")", temp_point + 1);
            str = problem_instance.substr(point + 10, temp_point - (point + 10));
            string str2 = problem_instance.substr(temp_point + 1, temp_point2 - (temp_point + 1));
            vector<string> temp = split(str, ' ');
            vector<string> temp2 = split(str2, ' ');
            vector<custom_msgs::card>& temp_vector = select_vector(temp[0], problem.level1_fold, problem.level2_fold, problem.level3_fold, problem.nobility_fold);
            int i = 0;
            for (i = 0; i < temp_vector.size(); i++) {
                if (temp_vector[i].name == temp[0])
                    break;
            }
            custom_msgs::card& card = temp_vector[i];
            select_color(card, temp[1]) = stoi(temp2[0]);
        }

        cout<<"finish save need token from problem"<<endl;

        point = 0;
        while (1) { //card point check
            point = problem_instance.find("s-point", point + 1);  
            if (point == -1) break;
            temp_point = problem_instance.find(")", point + 1);
            int temp_point2 = problem_instance.find(")", temp_point + 1);
            str = problem_instance.substr(point + 7, temp_point - (point + 7));
            string str2 = problem_instance.substr(temp_point + 1, temp_point2 - (temp_point + 1));
            vector<string> temp = split(str, ' ');
            vector<string> temp2 = split(str2, ' ');
            vector<custom_msgs::card>& temp_vector = select_vector(temp[0], problem.level1_fold, problem.level2_fold, problem.level3_fold, problem.nobility_fold);
            int i = 0;
            for (i = 0; i < temp_vector.size(); i++) {
                if (temp_vector[i].name == temp[0])
                    break;
            }
            custom_msgs::card& card = temp_vector[i];
            card.point = stoi(temp2[0]);
        }

        cout<<"finish card point check from problem"<<endl;

        for (int i = 0; i < problem.level1_fold.size(); i++) {
            int need_token = problem.level1_fold[i].white + problem.level1_fold[i].blue + problem.level1_fold[i].green + problem.level1_fold[i].red + problem.level1_fold[i].black;
            int card_score = (problem.level1_fold[i].point * 10) + 10 - (need_token*2);
            problem.card_expected_value.insert(pair<string, int>(problem.level1_fold[i].name, card_score));
        }
        for(int i = 0;i<problem.level2_fold.size();i++){
            int need_token = problem.level2_fold[i].white + problem.level2_fold[i].blue + problem.level2_fold[i].green
                                + problem.level2_fold[i].red + problem.level2_fold[i].black; 
            int card_score = (problem.level2_fold[i].point * 10) + 10 - (need_token*2);
            problem.card_expected_value.insert(pair<string, int>(problem.level2_fold[i].name, card_score));
        }
        for(int i = 0;i<problem.level3_fold.size();i++){
            int need_token = problem.level3_fold[i].white + problem.level3_fold[i].blue + problem.level3_fold[i].green
                                + problem.level3_fold[i].red + problem.level3_fold[i].black; 
            int card_score = (problem.level3_fold[i].point * 10) + 10 - (need_token*2);
            problem.card_expected_value.insert(pair<string, int>(problem.level3_fold[i].name, card_score));
        }

        cout<<"finish calc card_expected_score"<<endl;
        point = 0;
        while (1) { //card card holder check
            point = problem_instance.find("have-card", point + 1);  
            if (point == -1) break;
            temp_point = problem_instance.find(")", point + 1);
            str = problem_instance.substr(point + 9, temp_point - (point + 9));
            vector<string> temp = split(str, ' ');
            vector<custom_msgs::card>& temp_vector = select_vector(temp[1], problem.level1_fold, problem.level2_fold, problem.level3_fold, problem.nobility_fold);
            int i = 0;
            for (i = 0; i < temp_vector.size(); i++) {
                if (temp_vector[i].name == temp[1])
                    break;
            }
            if(temp[0] == "field"){    //field
                vector<custom_msgs::card>& dest_vector = select_vector(temp[1], problem.level1_open, problem.level2_open, problem.level3_open, problem.nobility_open);
                dest_vector.push_back(temp_vector[i]);
                temp_vector.erase(temp_vector.begin() + i);
            }
            else{
                vector<vector<custom_msgs::card>>* temp_holder; //player or ai
                if(temp[0] == "player1"){
                    temp_holder = &problem.player_card;
                }
                else if(temp[0] == "ai1"){
                    temp_holder = &problem.ai_card;
                }

                int card_spec;
                if(temp_vector[i].name.find("nobility") != -1)
                    card_spec = 5;
                else if(temp_vector[i].token == "white")
                    card_spec = 0;
                else if(temp_vector[i].token == "blue")
                    card_spec = 1;
                else if(temp_vector[i].token == "green")
                    card_spec = 2;
                else if(temp_vector[i].token == "red")
                    card_spec = 3;
                else if(temp_vector[i].token == "black")
                    card_spec = 4;
                
                vector<custom_msgs::card>& dest_vector = temp_holder->at(card_spec);
                dest_vector.push_back(temp_vector[i]);
                temp_vector.erase(temp_vector.begin() + i);
            }
            
        }

        cout << "finish save holder from problem" << endl;
        point = 0;
        while (1) {  //token check
            point = problem_instance.find("have-token", point + 1);
            if (point == -1) break;
            temp_point = problem_instance.find(")", point + 1);
            int temp_point2 = problem_instance.find(")", temp_point + 1);
            str = problem_instance.substr(point + 10, temp_point - (point + 10));
            string str2 = problem_instance.substr(temp_point + 1, temp_point2 - (temp_point + 1));
            vector<string> temp = split(str, ' ');
            vector<string> temp2 = split(str2, ' ');
            custom_msgs::coin* dest_coin;
            if (temp[0] == "player1") {
                if (temp[1] == "white")
                    problem.player_coin.white = stoi(temp2[0]);
                else if (temp[1] == "blue")
                    problem.player_coin.blue = stoi(temp2[0]);
                else if (temp[1] == "green")
                    problem.player_coin.green = stoi(temp2[0]);
                else if (temp[1] == "red")
                    problem.player_coin.red = stoi(temp2[0]);
                else if (temp[1] == "black")
                    problem.player_coin.black = stoi(temp2[0]);
            } else if (temp[0] == "ai1") {
                if (temp[1] == "white")
                    problem.ai_coin.white = stoi(temp2[0]);
                else if (temp[1] == "blue")
                    problem.ai_coin.blue = stoi(temp2[0]);
                else if (temp[1] == "green")
                    problem.ai_coin.green = stoi(temp2[0]);
                else if (temp[1] == "red")
                    problem.ai_coin.red = stoi(temp2[0]);
                else if (temp[1] == "black")
                    problem.ai_coin.black = stoi(temp2[0]);
            } else if (temp[0] == "field") {
                if (temp[1] == "white")
                    problem.field_coin.white = stoi(temp2[0]);
                else if (temp[1] == "blue")
                    problem.field_coin.blue = stoi(temp2[0]);
                else if (temp[1] == "green")
                    problem.field_coin.green = stoi(temp2[0]);
                else if (temp[1] == "red")
                    problem.field_coin.red = stoi(temp2[0]);
                else if (temp[1] == "black")
                    problem.field_coin.black = stoi(temp2[0]);
            }
        }

        cout << "finish save token from problem" << endl;
        point = 0;
        while (1) {  //score check
            point = problem_instance.find("have-score", point + 1);
            if (point == -1) break;
            temp_point = problem_instance.find(")", point + 1);
            int temp_point2 = problem_instance.find(")", temp_point + 1);
            str = problem_instance.substr(point + 10, temp_point - (point + 10));
            string str2 = problem_instance.substr(temp_point + 1, temp_point2 - (temp_point + 1));
            vector<string> temp = split(str, ' ');
            vector<string> temp2 = split(str2, ' ');
            //cout<<temp2[0]<<endl;
            if (temp[0] == "player1")
                problem.player_score = stoi(temp2[0]);
            else if (temp[0] == "ai1")
                problem.ai_score = stoi(temp2[0]);

            //cout<<problem.player_score<<endl;
            //cout<<problem.ai_score<<endl;
        }

        //set value
        problem.abandon = 0;
        problem.check_end = false;

        cout<<"finish make data from problem"<<endl;
        return;
        

        // problem_instance = new_str;

        
    }

    bool MINIMAXPlannerInterface::check_endgame(problem_info& gameState) {  //check endgame
        if (gameState.ai_score >= 15 || gameState.player_score >= 15){
            gameState.check_end = true;
            return true;
        }
        else
            return false;
    }

    //minimax 출처 https://github.com/lukechu10/TicTacToe-Minimax/
    double MINIMAXPlannerInterface::minimax(problem_info& gameState, bool isMax, unsigned int depth, string character, double alpha, double beta) {
		//minimaxCout++;
		//bestDepth = max(depth, bestDepth);
	
        //evaluate TODO: depth
		// if (endState(gameState) || evaluate(gameState, options.computer, options.opponent) != 0) {
		// 	return evaluate(gameState, options.computer, options.opponent);
		// }
        if(depth > planning_depth || check_endgame(gameState)){  //set depth
            //cout<<"hi"<<endl;
            return evaluate(gameState);
        }

        action result;
	
		// find out player's char:
		string playerChar = character;
        string nextplayer;
        if(character == "player1")
            nextplayer = "ai1";
        else
            nextplayer = "player1";

        // if (isMax)
        // 	playerChar = options.computer;
        // else
        // 	playerChar = options.opponent;
        double bestValue = 0;
        //alpha beta pruning
        if (isMax)
            bestValue = MAX_INFINITE;  //negative;
        else
            bestValue = MIN_INFINITE;  //positive;

        vector<action> act_list;
        vector<vector<custom_msgs::card>>& card_vector = find_card_vector(playerChar, gameState);
        custom_msgs::coin& coin_vector = find_coin_vector(playerChar, gameState);
        for (int i = 0; i < 3; i++) {  //buy
            string level = get_level_from_int(i);
            vector<custom_msgs::card>& level_vector = select_vector(level, gameState.level1_open, gameState.level2_open, gameState.level3_open
                                                                    ,gameState.nobility_open);
            for (int j = 0; j < level_vector.size(); j++) {
                if(check_buy(coin_vector,level_vector[j], card_vector)){
                    action temp;
                    temp.action = 2;
                    temp.details.clear();
                    temp.details.push_back(i);
                    temp.details.push_back(j);
                    act_list.push_back(temp);
                }
            }
        }
        int sum = coin_vector.white + coin_vector.blue + coin_vector.green + coin_vector.red + coin_vector.black;
        vector<int> possible_coin;
        for (int i = 0; i < 5; i++) {  //make possible coin
            int& coin = select_coin(i, gameState.field_coin);
            if (coin > 0)
                possible_coin.push_back(i);
        }

        
        //2coin 
    
        for (int i = 0; i < 5; i++) {
            if (sum <= 8) {
                int& coin = select_coin(i, gameState.field_coin);
                if (coin < 4)
                    continue;
                action temp;
                temp.action = 1;
                temp.details.clear();
                temp.details.push_back(i);
                act_list.push_back(temp);
            }
        }
        //3coin
        if (sum <= 7) {
            for (int j = 0; j < possible_coin.size(); j++) {
                if (possible_coin.size() > 1) {
                    for (int k = j + 1; k < possible_coin.size(); k++) {
                        if (possible_coin.size() > 2) {
                            for (int l = k + 1; l < possible_coin.size(); l++) {
                                action temp;
                                temp.action = 0;
                                temp.details.clear();
                                temp.details.push_back(possible_coin[j]);
                                temp.details.push_back(possible_coin[k]);
                                temp.details.push_back(possible_coin[l]);
                                act_list.push_back(temp);
                            }
                        } else {
                            action temp;
                            temp.action = 0;
                            temp.details.clear();
                            temp.details.push_back(possible_coin[j]);
                            temp.details.push_back(possible_coin[k]);
                            act_list.push_back(temp);
                        }
                    }
                } else {
                    action temp;
                    temp.action = 0;
                    temp.details.clear();
                    temp.details.push_back(possible_coin[j]);
                    act_list.push_back(temp);
                }
            }
        } 
        else if (sum >= 8) {    //abandon
            for (int j = 0; j < possible_coin.size(); j++) {
                custom_msgs::coin coin_temp = coin_vector;
                if (possible_coin.size() > 1) {
                    for (int k = j + 1; k < possible_coin.size(); k++) {
                        if (possible_coin.size() > 2) {
                            for (int l = k + 1; l < possible_coin.size(); l++) {
                                action temp;
                                temp.action = 0;
                                temp.details.clear();
                                temp.details.push_back(possible_coin[j]);
                                int& color1 = select_coin(j, coin_temp);
                                color1++;
                                temp.details.push_back(possible_coin[k]);
                                int& color2 = select_coin(k, coin_temp);
                                color2++;
                                temp.details.push_back(possible_coin[l]);
                                int& color3 = select_coin(l, coin_temp);
                                color3++;
                                temp.abandon.clear();
                                make_abandon(coin_temp, temp, act_list);
                                coin_temp = coin_vector;
                            }
                        } else {
                            action temp;
                            temp.action = 0;
                            temp.details.clear();
                            temp.details.push_back(possible_coin[j]);
                            int& color1 = select_coin(possible_coin[j], coin_temp);
                            color1++;
                            temp.details.push_back(possible_coin[k]);
                            int& color2 = select_coin(possible_coin[k], coin_temp);
                            color2++;
                            temp.abandon.clear();
                            make_abandon(coin_temp, temp, act_list);
                            coin_temp = coin_vector;
                        }
                    }
                } else {
                    action temp;
                    temp.action = 0;
                    temp.details.clear();
                    temp.details.push_back(possible_coin[j]);
                    int& color1 = select_coin(possible_coin[j], coin_temp);
                    color1++;
                    temp.abandon.clear();
                    make_abandon(coin_temp, temp, act_list);
                    coin_temp = coin_vector;
                }
            }
        } 
        
        if(act_list.size() == 0){  //if not have act -> insert dont act
            action temp;
            temp.action = 0;
            act_list.push_back(temp);
        }

        int best_act = 0;
        vector<action> best_list;
        //cout<<"list : "<< act_list.size()<<endl;
        problem_info old_gameState = gameState; //backup    
        for (int i = 0; i < act_list.size(); i++) {  //minimax
            old_gameState = gameState; //backup
            
            // set board for calling minimax()
            if(act_list[i].action == 0){ //3 coin
                three_coin(gameState, act_list[i].details, act_list[i].abandon, playerChar);
            }
            else if(act_list[i].action == 1){    //2coin
                two_coin(gameState, act_list[i].details, playerChar);
            }
            else if(act_list[i].action==2){   //buy   //TODO: add random card
                buy_card(gameState, act_list[i].details, playerChar);
            }   
            else continue;

            if (isMax) {        //if need max
                double post_value = bestValue;
                
                bestValue = max(bestValue, minimax(gameState, !isMax, depth + 1, nextplayer, alpha, beta));

                alpha = max(alpha, bestValue);  //alpha beta pruning    
                if(post_value != bestValue){    //best action list make
                    result = act_list[i]; 
                    best_act = i;               
                    best_list = gameState.result_act;    
                    // cout<<act_list[i].action<<" [";
                     post_value = bestValue;
                    // for(int j =0;j<act_list[i].details.size();j++){
                    //     cout<<act_list[i].details[j];
                    //     if(j!=act_list[i].details.size()-1)
                    //         cout<<", ";
                    // }
                    //cout<<"]  "<<bestValue<<" "<<depth<<" "<<act_list.size()<<" "<<alpha<<" "<<beta<<endl;
                }
                if(alpha>= beta) {cout<<"beta-cut"<<endl;break;    } //beta cutoff

                
            } else {    //if need min
                double post_value = bestValue;
                bestValue = min(bestValue, minimax(gameState, !isMax, depth + 1, nextplayer, alpha, beta));

                beta = min(beta, bestValue);    //alpha beta pruning
                if(post_value != bestValue){    //best action list make
                    best_act = i;                   
                    best_list = gameState.result_act;   
                    post_value = bestValue;
                    // cout<<act_list[i].action<<" [";
                    // for(int j =0;j<act_list[i].details.size();j++){
                    //     cout<<act_list[i].details[j];
                    //     if(j!=act_list[i].details.size()-1)
                    //         cout<<", ";
                    // }
                    // cout<<"]  "<<bestValue<<" "<<depth<<" "<<act_list.size()<<" "<<alpha<<" "<<beta<<endl;
                }
                if(alpha>= beta) {cout<<"alpha-cut"<<endl;break;} //    alpha cutoff

                
            }

            // unset board
            gameState = old_gameState;
        }
        gameState = old_gameState;
        if(gameState.check_end == true){
            act_list[best_act].check_end = true;
            gameState.check_end = false;
        }
        act_list[best_act].total_action = act_list.size();  //act's total action
        best_list.push_back(act_list[best_act]);
        gameState.result_act = best_list;     //save max, min act
        cout<<act_list.size()<<" "<<best_act<<endl;
        if (depth == 0) {
            cout << "result : ";
            cout<< gameState.result_act[gameState.result_act.size()-1].action << " [";
            for (int i = 0; i < gameState.result_act[gameState.result_act.size()-1].details.size(); i++) {
                cout << result.details[i] << ", ";
            }
            cout << "] [";
            for (int i = 0; i < gameState.result_act[gameState.result_act.size()-1].abandon.size(); i++) {
                cout << result.abandon[i] << ", ";
            }
            cout << "] " <<bestValue<< endl;
            gameState.act = gameState.result_act[gameState.result_act.size()-1];
            
            stringstream ss;
            ss.str("");
            string n = name;
            ss << "solved " << n << "'s turn" << endl;
            for (int i = gameState.result_act.size() - 1; i >= 0; i--) {    //make log_display solved msg
                ss << "[turn : " << gameState.result_act.size() - i << "] " << n << " : ";
                if (n == "ai1")
                    n = "player1";
                else
                    n = "ai1";
                if (gameState.result_act[i].action == 0) {  // action 0
                    ss << "three_coin [";
                    for (int j = 0; j < gameState.result_act[i].details.size(); j++) {
                        ss << get_color_from_int(gameState.result_act[i].details[j]);
                        if (j != gameState.result_act[i].details.size() - 1) {
                            ss << ", ";
                        }
                    }
                    ss << "] [";
                    for (int j = 0; j < gameState.result_act[i].abandon.size(); j++) {
                        ss << get_color_from_int(gameState.result_act[i].abandon[j]);
                        if (j != gameState.result_act[i].abandon.size() - 1) {
                            ss << ", ";
                        }
                    }
                    ss << "]";
                } else if (gameState.result_act[i].action == 1) {       //action 1
                    ss << "two_coin [";
                    for (int j = 0; j < gameState.result_act[i].details.size(); j++) {
                        ss << get_color_from_int(gameState.result_act[i].details[j]);
                        if (j != gameState.result_act[i].details.size() - 1) {
                            ss << ", ";
                        }
                    }
                    ss << "]";
                } else if (gameState.result_act[i].action == 2) {       //action 2
                    ss << "buy_card [";
                    ss << get_level_from_int(gameState.result_act[i].details[0]) << ", ";
                    ss << "order" << (gameState.result_act[i].details[1]) + 1 << "]";
                }
                ss << " \ttotal : " << gameState.result_act[i].total_action << endl;
                if (gameState.result_act[i].check_end == true) {
                    ss << "end game" << endl;
                }
            }
            ss << name << "'s Advantage : " << bestValue << endl;
            ss << "===================================================================="<<endl;
            log_display::log_msg msg;
            msg.log_str = ss.str();
            log_display_pub.publish(msg);   //display to log_display
        }

        return bestValue;
    }

    double MINIMAXPlannerInterface::evaluate(problem_info& gameState) {     //evaluate score of gameState
        if(name == "player1"){  //check endgame if player
            if(gameState.player_score>=15)
                return MIN_INFINITE-1;
            else if(gameState.ai_score>=15)
                return MAX_INFINITE+1;
        }
        else{   //if ai
            if(gameState.player_score>=15)
                return MAX_INFINITE+1;
            else if(gameState.ai_score>=15)
                return MIN_INFINITE-1;
        }

        double score = (gameState.ai_score * 150) + gameState.ai_coin.white + gameState.ai_coin.green + gameState.ai_coin.black + gameState.ai_coin.red + gameState.ai_coin.blue;
        score -= (gameState.player_score * 150) + gameState.player_coin.white + gameState.player_coin.green + gameState.player_coin.black + gameState.player_coin.red + gameState.player_coin.blue;
        //token and game score calc
        if (name == "player1")
            score = score * (-1);
        //if player's planner -> reverse
        score = score / hyper_game;  //hyperparameter (token and game score)

        score -= gameState.abandon * 10;    //avoid abandon

        string enemy_name = "";
        if (name == "player1")
            enemy_name = "ai1";
        else
            enemy_name = "player1";
        custom_msgs::coin& coin_vector = find_coin_vector(name, gameState);
        custom_msgs::coin& enemy_coin_vector = find_coin_vector(enemy_name, gameState); //enemy
        vector<vector<custom_msgs::card>>& card_vector = find_card_vector(name, gameState); 
        vector<vector<custom_msgs::card>>& enemy_card_vector = find_card_vector(enemy_name, gameState);//enemy
        for (int i = 0; i < 5; i++) {  //score of have card
            score += card_vector[i].size() * hyper_card;
            score -= enemy_card_vector[i].size() * hyper_card;    //enemy
        }

        //nobility
        score += card_vector[5].size() * 30;
        score -= enemy_card_vector[5].size() * 30;    //enemy
        

        //calc probability of open card and nobility
        for(int i = 0 ; i < 4; i++){    //for level and nobility
            vector<custom_msgs::card>& level_vector = select_vector(get_level_from_int(i), gameState.level1_open, gameState.level2_open,
                                                                gameState.level3_open, gameState.nobility_open);
            for(int j = 0; j < level_vector.size(); j++){
                vector<int> sc;         //now's need token for buy card
                sc.resize(5, 0);
                double need_token = 0;  //sum of now's need token for buy card
                double sum = 0;         //total need token
                for (int k = 0; k < 5; k++) {
                    sum += select_color(level_vector[j], get_color_from_int(k));
                    int temp;
                    if (i == 3) {
                        temp = select_color(level_vector[j], get_color_from_int(k)) - (card_vector[k].size());  //nobility
                    } else {
                        temp = select_color(level_vector[j], get_color_from_int(k)) - select_coin(k, coin_vector) - (card_vector[k].size());  //level card
                    }

                    if (temp < 0)
                        temp = 0;

                    sc[k] = temp;
                    need_token += temp;
                }

                double probabilty = 0;  //probability of buy card
                for(int k = 0; k<5;k++){
                    if(sc[k]>select_coin(k, gameState.field_coin) && i!=3){     //cant buy because less field token 
                        probabilty = 0;
                        break;
                    }
                    if(k == 4){
                        probabilty = (double)(sum-need_token) / sum;    //probability
                    }
                }
                
                if (i == 3) {
                    score += ((double)(20) * probabilty) * hyper_nobility; //nobility 
                } else {
                    score += ((double)(gameState.card_expected_value[level_vector[j].name]) * probabilty) * hyper_level;    //level card
                }
                //cout<<((double)(gameState.card_expected_value[level_vector[j].name]) * probabilty)*3<<" "<<probabilty<<endl;
            }
        }

        for(int i = 0 ; i < 4; i++){    //for level and nobility    for enemy
            vector<custom_msgs::card>& level_vector = select_vector(get_level_from_int(i), gameState.level1_open, gameState.level2_open,
                                                                gameState.level3_open, gameState.nobility_open);
            for(int j = 0; j < level_vector.size(); j++){
                vector<int> sc;         //now's need token for buy card
                sc.resize(5, 0);
                double need_token = 0;  //sum of now's need token for buy card
                double sum = 0;         //total need token
                for (int k = 0; k < 5; k++) {
                    sum += select_color(level_vector[j], get_color_from_int(k));
                    int temp;
                    if (i == 3) {
                        temp = select_color(level_vector[j], get_color_from_int(k)) - (enemy_card_vector[k].size());  //nobility
                    } else {
                        temp = select_color(level_vector[j], get_color_from_int(k)) - select_coin(k, enemy_coin_vector) - (enemy_card_vector[k].size());  //level card
                    }

                    if (temp < 0)
                        temp = 0;

                    sc[k] = temp;
                    need_token += temp;
                }

                double probabilty = 0;  //probability of buy card
                for(int k = 0; k<5;k++){
                    if(sc[k]>select_coin(k, gameState.field_coin )&& i!=3){     //cant buy because less field token 
                        probabilty = 0;
                        break;
                    }
                    if(k == 4){
                        probabilty = (double)(sum-need_token) / sum;    //probability
                    }
                }
                
                if (i == 3) {
                    score -= ((double)(20) * probabilty) * hyper_nobility; //nobility 
                } else {
                    score -= ((double)(gameState.card_expected_value[level_vector[j].name]) * probabilty) * hyper_level;    //level card
                }
                //cout<<((double)(gameState.card_expected_value[level_vector[j].name]) * probabilty)*3<<" "<<probabilty<<endl;
            }
        }

        //cout<<score<<endl;
        return score;
    }

    void MINIMAXPlannerInterface::three_coin(problem_info& gameState, vector<int>& details, vector<int>& abandon, string& playerChar){  //action get three coin
        custom_msgs::coin& coin_vector = find_coin_vector(playerChar, gameState);
        for (int i = 0; i < details.size(); i++) {  //get coin
            //cout<<select_coin(details[i], gameState.field_coin)<<" ";
            select_coin(details[i], coin_vector)++;
            select_coin(details[i], gameState.field_coin)--;
            //cout<<select_coin(details[i], gameState.field_coin)<<endl;
        }
        for (int i = 0; i < abandon.size(); i++) {  //abandon coin
            if(playerChar == name)
                gameState.abandon++;    //effect to evaluate
            else
                gameState.abandon--;
            select_coin(abandon[i], coin_vector)--;
            select_coin(abandon[i], gameState.field_coin)++;
        }
    }

    void MINIMAXPlannerInterface::two_coin(problem_info& gameState, vector<int>& details, string& playerChar){  //action get two coin
        custom_msgs::coin& coin_vector = find_coin_vector(playerChar, gameState);   //get
        select_coin(details[0], coin_vector) += 2;
        select_coin(details[0], gameState.field_coin) -= 2;
    }

    void MINIMAXPlannerInterface::buy_card(problem_info& gameState, vector<int>& details, string& playerChar){  //action buy card
        custom_msgs::coin& coin_vector = find_coin_vector(playerChar, gameState);
        vector<vector<custom_msgs::card>>& card_vector = find_card_vector(playerChar, gameState);
        vector<custom_msgs::card>& level_vector = select_vector(get_level_from_int(details[0]), gameState.level1_open, gameState.level2_open,
                                                                gameState.level3_open, gameState.nobility_open);
        string color = level_vector[details[1]].token;

        for(int i = 0; i<5;i++){    //move coin
            select_coin(i, coin_vector) -= select_color(level_vector[details[1]], get_color_from_int(i));
            select_coin(i, gameState.field_coin) += select_color(level_vector[details[1]], get_color_from_int(i));
        }

        if(playerChar == "player1") //add point
            gameState.player_score += level_vector[details[1]].point;
        else
            gameState.ai_score += level_vector[details[1]].point;

        if (color == "white") { //move card
            card_vector[0].push_back(level_vector[details[1]]);
        } else if (color == "blue") {
            card_vector[1].push_back(level_vector[details[1]]);
        } else if (color == "green") {
            card_vector[2].push_back(level_vector[details[1]]);
        } else if (color == "red") {
            card_vector[3].push_back(level_vector[details[1]]);
        } else if (color == "black") {
            card_vector[4].push_back(level_vector[details[1]]);
        }

        level_vector.erase(level_vector.begin() + details[1]);  //remove card from field

        //check and get nobility
        vector<custom_msgs::card>& nobility_vector = gameState.nobility_open;
        for(int i =nobility_vector.size()-1;i>=0;i--){
            int j =0;
            for(j = 0;j<5;j++){ //check
                if (card_vector[j].size() < select_color(nobility_vector[i], get_color_from_int(j)))
                    break;
            }
            if (j == 5) {  //save
                card_vector[5].push_back(nobility_vector[i]);
                if (playerChar == "player1")  //add point
                    gameState.player_score += nobility_vector[i].point;
                else
                    gameState.ai_score += nobility_vector[i].point;
                nobility_vector.erase(nobility_vector.begin() + i);
            }
        }
    }

    std::vector<custom_msgs::card>& MINIMAXPlannerInterface::select_vector(string n, vector<custom_msgs::card>& level1, vector<custom_msgs::card>& level2, 
                        vector<custom_msgs::card>& level3, vector<custom_msgs::card>& nobility) {  //select find vector by name
        if (n.find("nobility") != -1)
            return nobility;
        else if (n.find("level1") != -1)
           return level1;
        else if (n.find("level2") != -1)
            return level2;
        else if (n.find("level3") != -1)
            return level3;
    }

    string MINIMAXPlannerInterface::get_color_from_int(int n){  //get color string from int(color)
        if (n == 0)
            return "white";
        else if (n == 1)
            return "blue";
        else if (n == 2)
            return "green";
        else if (n == 3)
            return "red";
        else if (n == 4)
            return "black";
    }

    int& MINIMAXPlannerInterface::select_color(custom_msgs::card& at, string n) {  //find name and save point
        if (n == "white")
            return at.white;
        else if (n == "blue")
            return at.blue;
        else if (n == "green")
            return at.green;
        else if (n == "red")
            return at.red;
        else if (n == "black")
            return at.black;
    }

    string MINIMAXPlannerInterface::get_level_from_int(int n){  //get level string from int(level+nobility) 
        if(n == 0)
            return "level1";
        else if(n==1)
            return "level2";
        else if(n==2)
            return "level3";
        else if(n==3)
            return "nobility";
    }

    vector<vector<custom_msgs::card>>& MINIMAXPlannerInterface::find_card_vector(string n, problem_info& p){    //get card vector(player, ai) by string(name)
        if(n == "player1")
            return p.player_card;
        else 
            return p.ai_card;
    }

    custom_msgs::coin& MINIMAXPlannerInterface::find_coin_vector(string n, problem_info& p){    //get coin vector(player, ai) by string(name)
        if(n == "player1")
            return p.player_coin;
        else
            return p.ai_coin;
    }
    
    int& MINIMAXPlannerInterface::select_coin(int n, custom_msgs::coin& p){ //get value of coin' color amount by int(color)
        if(n == 0)
            return p.white;
        else if(n == 1)
            return p.blue;
        else if(n == 2)
            return p.green;
        else if(n == 3)
            return p.red;
        else if(n == 4)
            return p.black;
    }
    
    bool MINIMAXPlannerInterface::check_buy(custom_msgs::coin& p, custom_msgs::card& c, vector<vector<custom_msgs::card>>& card){   //check can buy
        if(c.white > p.white + card[0].size())  
            return false;
        else if(c.blue > p.blue + card[1].size())
            return false;
        else if(c.green > p.green + card[2].size())
            return false;
        else if(c.red > p.red + card[3].size())
            return false;
        else if(c.black > p.black + card[4].size())
            return false;
        
        return true;
    }

    void MINIMAXPlannerInterface::make_abandon(custom_msgs::coin coin, action& temp, vector<action>& act_list){ //do abandon
        int sum = coin.white + coin.blue + coin.green + coin.red + coin.black - 10;  //abandon
        if (sum > 0) {
            for (int j = 0; j < 5; j++) {  //abandon calc
                custom_msgs::coin coin_temp = coin;
                int sum2 = sum;
                if (sum2 > 1) {
                    if (select_coin(j, coin_temp) > 0) {
                        temp.abandon.push_back(j);
                        select_coin(j, coin_temp)--;
                        for (int k = j; k < 5; k++) {
                            if (select_coin(k, coin_temp) > 0) {
                                temp.abandon.push_back(k);
                                select_coin(k, coin_temp)--;
                                if (sum2 > 2) {
                                    for (int l = k; l < 5; l++) {
                                        if (select_coin(l, coin_temp) > 0) {
                                            temp.abandon.push_back(l);
                                            act_list.push_back(temp);
                                            temp.abandon.pop_back();
                                        }
                                    }
                                } else {
                                    act_list.push_back(temp);
                                }
                                select_coin(k, coin_temp)++;
                                temp.abandon.pop_back();
                            }
                        }
                        select_coin(j, coin_temp)++;
                        temp.abandon.pop_back();
                    }

                } else {
                    if (select_coin(j, coin_temp) > 0) {
                        temp.abandon.push_back(j);
                        act_list.push_back(temp);
                        temp.abandon.pop_back();
                    }
                }
            }
        }
        else{
            act_list.push_back(temp);
            temp.abandon.clear();
        }
    }
    

    void MINIMAXPlannerInterface::make_plan(string& Msg, problem_info& problem){    //make plan to pdll
        double duration = 0.000;
        stringstream ss;
        ss.str("");
        ss.precision(3);
        ss << std::fixed << duration;
        ss << ": (";
        if(problem.act.action == 0){
            ss << "three_coin";
            for(int i = 0; i<3;i++){
                if(i < problem.act.details.size()){
                    ss<< " " << get_color_from_int(problem.act.details[i]);
                }
                else{
                    ss<< " none"; 
                }
            }
            for(int i = 0; i<3;i++){
                if(i < problem.act.abandon.size()){
                    ss<< " " << get_color_from_int(problem.act.abandon[i]);
                }
                else{
                    ss<< " none"; 
                }
            }
        }
        else if(problem.act.action == 1){
            ss << "two_coin";
            ss<< " " << get_color_from_int(problem.act.details[0]);
        }
        else if(problem.act.action == 2){
            ss << "buy";
            ss<< " buy_" << get_level_from_int(problem.act.details[0]);
            ss<<" order"<<to_string(problem.act.details[1] +1 );
        }
        ss << ") [1.000]\n";
        string s = ss.str();
        Msg = s;
    }

    void MINIMAXPlannerInterface::make_pddl_from_csp(string& planner_output, std::string path) {    //make file of output
      
        std::ofstream planfile;
        planfile.open(path.c_str());
        if(planfile.is_open()){
            planfile << planner_output << std::endl;
            planfile.close();
        }
        
    }

   

} // close namespace

	/*-------------*/
	/* Main method */
	/*-------------*/

	int main(int argc, char **argv) {

		srand (static_cast <unsigned> (time(0)));
        cout<<"this is minimax"<<endl;
		ros::init(argc,argv,"rosplan_planner_interface");
		ros::NodeHandle nh("~");

		KCL_rosplan::MINIMAXPlannerInterface pi(nh);
		
		// subscribe to problem instance
		std::string problemTopic = "problem_instance";
		nh.getParam("problem_topic", problemTopic);
		ros::Subscriber problem_sub = nh.subscribe(problemTopic, 1000, &KCL_rosplan::PlannerInterface::problemCallback, dynamic_cast<KCL_rosplan::PlannerInterface*>(&pi));

		// start the planning services
		ros::ServiceServer service1 = nh.advertiseService("planning_server", &KCL_rosplan::PlannerInterface::runPlanningServerDefault, dynamic_cast<KCL_rosplan::PlannerInterface*>(&pi));
		ros::ServiceServer service2 = nh.advertiseService("planning_server_params", &KCL_rosplan::PlannerInterface::runPlanningServerParams, dynamic_cast<KCL_rosplan::PlannerInterface*>(&pi));

		ROS_INFO("KCL: (%s) Ready to receive", ros::this_node::getName().c_str());
        ros::spin();


		return 0;
	}
std::vector<std::string> split(std::string input, char delimiter)
{
  std::vector<std::string> answer;
  std::stringstream ss(input);
  std::string temp;

  while (getline(ss, temp, delimiter))
  {
	if(temp != "" && temp !=" ")
    	answer.push_back(temp);
  }

  return answer;
}

