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

        bool end_flag;      //멀티 프로세싱 멈추는 플래그
        std::queue<Queue_state> que;    //멀티 프로세싱에 줄 queue 일
        std::vector<int> result_simulation; //결과 저장하는 vector





    public:
        Board(ros::NodeHandle &nh, const int sock);
        ~Board();

        void MulitProcessingServer();   //멀티 프로세싱 실행 함수

        void run_board();       //보드 실행 함수
        void DivideAndParseBuffer(std::string buf); //divide and parse buffer stream

        int hai_str_to_int(const std::string hai_str);  //convert 패 37가지 1~37
        std::string hai_int_to_str(int hai_int);        //패 int -> str
        int hai38_to_hai9(int hai_int38);               //패 str -> int
        std::string TypeIntToStr(int type);             //Pon,chi 들의 상태를 int -> str
        
        void PrintTehai();  //print all tehai           

        std::vector<int> CalculateScore(state& use_game_state, json11::Json& move, std::string type);       //상태와 hora action, ron,tsumo을 보고 점수계산
        int CalculateShanten(std::vector<int>& tehai, std::vector<Fuuro_Elem_>& Fuuro, int dahai);  //샨텐 (텐파이 한수 전)까지 남은 패 계산
        int CalculatePlayerKazeFromOya(int oya);             //플레이어의 방향 계산

        bool CheckTenpai(state& use_game_state, int actor);     //텐파이 상태인지 계산
        std::vector<buffer> CheckNaki(int actor, int target, state& use_game_state, bool last_actor_chi);   //울 수 있는지 체크 => 할 수 있는 행동 return
        bool CheckHora(state& use_game_state, int next_actor, json11::Json& last_act);      //울 수 있는지 체크


        std::string Planner(std::string act);   //플래너 시작 함수
        int DahaiSimulation(int possible, state& use_game_state, int depth, int actor); //시뮬레이션 함수

        //change state funcion
        void ChangeStateWithStartKyoku();                                                   //국 시작 할때 상태 변경
        void ChangeStateWithTsumo(state& game_state_, buffer& buf_info_, bool plan);        //뽑을 때 상태 변경
        void ChangeStateWithDahai(state& game_state_, buffer& buf_info_, bool plan);        //버릴 때 상태 변경
        void ChangeStateWithHora();                                                         //울 때 상태 변경
        void ChangeStateWithRyokyoku();                                                     //유국 일 때 상태 변경
        void ChangeStateWithChi(state& game_state_, buffer& buf_info_, bool plan);          //치일때 상태 변경
        void ChangeStateWithPon(state& game_state_, buffer& buf_info_, bool plan);          //폰일때 상태 변경
        void ChangeStateWithDaiminkan(state& game_state_, buffer& buf_info_, bool plan);    //대명깡일때 상태 변경
        void ChangeStateWithKakan(state& game_state_, buffer& buf_info_, bool plan);        //가캉일때 상태변경
        void ChangeStateWithAnkan(state& game_state_, buffer& buf_info_, bool plan);        //안캉인때 상태변경
        void ChangeStateWithDora(state& game_state_, buffer& buf_info_, bool plan);         //도라를 깠을 떄 상태변경
        void ChangeStateWithReach(state& game_state_, buffer& buf_info_, bool plan);        //리치할 때 상태변경
        void ChangeStateWithRequest();  //request 받았을 떄 함수
        void WriteDahai();      //dahai 할 것 보내는 함수

        int PlayerHeuristic(state& use_game_state, const int pai);  //Make player's heuristic

        //chi buffer 만드느 함수
        buffer MakeChiBuffer(int actor, int target, int pai, std::vector<int> consumed);
 

    };

    std::vector<std::string> SplitToString(std::string input, char delimiter, bool remove);
    std::vector<int> SplitToInt(std::string input, char delimiter);
}   //close namespace

#endif