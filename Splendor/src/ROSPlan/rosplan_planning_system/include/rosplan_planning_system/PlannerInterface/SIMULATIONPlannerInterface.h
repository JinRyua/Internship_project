#include "PlannerInterface.h"


#include "custom_msgs/coin.h"
#include "custom_msgs/card.h"
#include "std_msgs/Empty.h"
#include "rosplan_dispatch_msgs/ActionDispatch.h"
#include <vector>
#include <map>
#include <fstream>
#include <sstream>
#include <string>
#include <ctime>
#include <string>
#include <streambuf>
#include <thread>
#include <mutex>

#ifndef KCL_SIMULATION_planner_interface
#define KCL_SIMULATION_planner_interface
using namespace std;

#define DEPTH 1     //start simulation depth
#define SIMULATION_COUNT 500 //amount simulation for each act

#define MIN_INFINITE 1000000
#define MAX_INFINITE -1000000

#define WIN 1
#define LOSE 0

/**
 * This file contains an interface to the planner.
 */


namespace KCL_rosplan {
    struct action{
        int action;
        vector<int> details;
        vector<int> abandon;
        int total_action;
        bool check_end = false;
    };
    struct problem_info{
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

        std::map<string, int> card_expected_value;

        custom_msgs::coin field_coin;  //field's coin

        int player_score;
        int ai_score;

        action act;

        vector<action> result_act;

        bool check_end;

        int abandon;

    };

    

	class SIMULATIONPlannerInterface: public PlannerInterface
	{
	private:

		/* runs external commands */
		std::string runCommand(std::string cmd);

        string name;

        int planning_depth;

        int thread_size;    //?????? ???????????? ?????? ?????????
        std::vector<std::thread> thread_list;
        std::mutex m;
        
        //hyper parameter
        double hyper_game;
        double hyper_level;
        double hyper_nobility;
        double hyper_card;

	protected:

		bool runPlanner();

	public:

		SIMULATIONPlannerInterface(ros::NodeHandle& nh);
		~SIMULATIONPlannerInterface();

        
        void three_coin(problem_info& gameState, vector<int>& details, vector<int>& abandon, string& playerChar);   //?????? 3??? ?????? ??????
        void two_coin(problem_info& gameState, vector<int>& details, string& playerChar);       //?????? 2??? ?????? ??????
        void buy_card(problem_info& gameState, vector<int>& details, string& playerChar);       //?????? ?????? ?????? ??????

        std::vector<custom_msgs::card>& select_vector(string n, vector<custom_msgs::card>& level1, vector<custom_msgs::card>& level2, 
                        vector<custom_msgs::card>& level3, vector<custom_msgs::card>& nobility);  //select find vector by name
        int& select_color(custom_msgs::card& at, string n);                                      //find name and save point
        string get_color_from_int(int n);   //int????????? color string ?????? ??????
        string get_level_from_int(int n);   //int????????? level string ?????? ??????
        vector<vector<custom_msgs::card>>& find_card_vector(string n, problem_info& p); //string?????? ?????? card_vector??? ?????? ??????
        custom_msgs::coin& find_coin_vector(string n, problem_info& p); //string???????????? coin vector ?????? ??????
        int& select_coin(int n, custom_msgs::coin& p);  //???????????? ????????? coin value ?????? ??????

        bool check_buy(custom_msgs::coin& p, custom_msgs::card& c, vector<vector<custom_msgs::card>>& card);    //?????? ????????? ??????
        void make_abandon(custom_msgs::coin coin, action& temp, vector<action>& act_list);  //abandon ??? ??? ??? ????????? => ??? ??? ????????? ?????? ???????????? ??????

        void make_pddl_from_csp(string& planner_output, std::string path);  //pddl??? ?????? ??????
        void make_problem_for_csp(string& problem_instance, problem_info& problem); //???????????? ?????? ???????????? ??????

        void make_plan(string& Msg, problem_info& problem); //?????? ????????? ??????

        double minimax(problem_info& gameState, bool isMax, unsigned int depth, string character, double alpha, double beta);   //????????????
        double simulation(problem_info& gameState, std::string character, int count, int depth);    //??????????????? ??????(???????????????)
        std::vector<action> MakeActionList(problem_info& gameState, std::string playerChar);    //?????? ????????? ????????? ??????
        void StartSimulationByThread(int number, std::vector<action>& possible_action_list, double& rate, problem_info& gameState, string& playerChar, const int start, const int end, int depth);
        //?????? ???????????? ??????????????? ?????? ??????
        bool check_endgame(problem_info& gameState);    //?????? ???????????? ??????


        //publisher
		ros::Publisher log_display_pub;

		
	};

} // close namespace

#endif
