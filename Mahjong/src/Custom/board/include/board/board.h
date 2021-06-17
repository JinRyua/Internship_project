#include "ros/ros.h"
#include "board/multiprocessing.h"
#include "board/types.h"

//https://github.com/critter-mj/akochan
//mahjong calculator
#include "ai_src/tehai_ana.hpp"
#include "ai_src/selector.hpp"
#include "share/types.hpp"

#include <fstream>
#include <utility>
#include <map>
#include <string>
#include <queue>
#include <vector>

#ifndef BOARD
#define BOARD

#define PLAYER 0

#define NONE -1
#define PON 0
#define CHI 1
#define DAIMINKAN 2
#define KAKAN 3
#define ANKAN 4
#define HORA 5
#define REACH 6

namespace Custom
{

    class Board{

    private:
        ros::NodeHandle *node_handle;

        /* params */

        state game_state;   //게임 상태
        int serv_sock;

        struct buffer buf_info;

        std::string path;    //path save log
        std::ofstream writeFile;  //ofstream to save log

        std::vector<std::thread> thread_list;   //thread list 
        bool end_flag;
        std::queue<Queue_state> que;
        std::vector<int> result_simulation;





    public:
        Board(ros::NodeHandle &nh, const int sock);
        ~Board();

        void MulitProcessingServer();

        void run_board();
        void DivideAndParseBuffer(std::string buf); //divide and parse buffer stream

        int hai_str_to_int(const std::string hai_str);  //convert 패 37가지 1~37
        std::string hai_int_to_str(int hai_int);
        int hai38_to_hai9(int hai_int38);
        std::string TypeIntToStr(int type);
        
        void PrintTehai();  //print all tehai

        std::vector<int> CalculateScore(state& use_game_state, json11::Json& move, std::string type);
        int CalculateShanten(std::vector<int>& tehai, std::vector<Fuuro_Elem_>& Fuuro, int dahai);
        int CalculatePlayerKazeFromOya(int oya);

        bool CheckTenpai(state& use_game_state, int actor);
        std::vector<buffer> CheckNaki(int actor, int target, state& use_game_state, bool last_actor_chi);
        bool CheckHora(state& use_game_state, int next_actor, json11::Json& last_act);

        std::string Planner(std::string act);
        int DahaiSimulation(int possible, state& use_game_state, int depth, int actor);

        //change state funcion
        void ChangeStateWithStartKyoku();
        void ChangeStateWithTsumo(state& game_state_, buffer& buf_info_, bool plan);
        void ChangeStateWithDahai(state& game_state_, buffer& buf_info_, bool plan);
        void ChangeStateWithHora();
        void ChangeStateWithRyokyoku();
        void ChangeStateWithChi(state& game_state_, buffer& buf_info_, bool plan);
        void ChangeStateWithPon(state& game_state_, buffer& buf_info_, bool plan);
        void ChangeStateWithDaiminkan(state& game_state_, buffer& buf_info_, bool plan);
        void ChangeStateWithKakan(state& game_state_, buffer& buf_info_, bool plan);
        void ChangeStateWithAnkan(state& game_state_, buffer& buf_info_, bool plan);
        void ChangeStateWithDora(state& game_state_, buffer& buf_info_, bool plan);
        void ChangeStateWithReach(state& game_state_, buffer& buf_info_, bool plan);
        void ChangeStateWithRequest();
        void WriteDahai();

        int PlayerHeuristic(state& use_game_state, const int pai);  //Make player's heuristic

        buffer MakeChiBuffer(int actor, int target, int pai, std::vector<int> consumed);
 

        //service client

        // //publisher
        

        // //service
       
        // //sub callback
        // void exit_callback(const std_msgs::Empty& msg);

    };

    std::vector<std::string> SplitToString(std::string input, char delimiter, bool remove);
    std::vector<int> SplitToInt(std::string input, char delimiter);
}   //close namespace

#endif