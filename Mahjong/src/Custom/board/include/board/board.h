#include "ros/ros.h"

//https://github.com/critter-mj/akochan
//mahjong calculator
#include "ai_src/tehai_ana.hpp"
#include "ai_src/selector.hpp"
#include "share/types.hpp"

#include <fstream>
#include <utility>
#include <map>
#include <string>
#include <vector>

#ifndef BOARD
#define BOARD

#define PLAYER 0

#define NONE -1
#define PON 0
#define CHI 1
#define KAN 2

namespace Custom
{
    class Fuuro_Elem_ {  //pon, kan, chi
       public:
        int type;
        int hai;    //가져온 패
        std::vector<int> consumed;
        int target_relative;  

        Fuuro_Elem_(){};
    };

    struct state{
        std::vector<std::vector<Fuuro_Elem_>> Fuuro;
        std::vector<int> haipai;   //안나온 패    
        std::vector<std::vector<int>> tehai;    //손패  37가지 1~37 [4][38]
        int recent_dahai;   //최근 버림패
        std::vector<std::vector<int>> dahai;    //버림패        [4][~]
        std::vector<std::vector<int>> chi;    //버림패
        std::vector<int> score;    //점수
        std::vector<int> dora_marker;   //도라 표시패
        std::string bakaze;     //바람(동풍)
        int honba;      //본장
        int kyoku;      //국
        int kyotaku;    //남은 스틱
        int oya;        //오야 번호(0~3)
        int actor;      //최근 actor
        int turn;       //남은 뽑기 패
        int tsumo;      //최근 들어온 패
    };

    struct buffer{  //buffer information
        std::string type;
        std::string bakaze;
        std::string dora_marker;
        std::string pai;
        int honba;
        int kyoku;
        int kyotaku;
        int oya;
        int actor;
        int target;
        bool tsumogiri;
        std::vector<int> score;
        std::vector<std::string> uradora_marker;
        std::vector<std::string> hora_tehais;
        std::vector<std::string> start_tehai;
        std::vector<std::vector<std::string>> all_tehai;
        std::vector<std::string> consumed;
        std::vector<Fuuro_Elem_> reqeust;
        
    };

    struct end_info{
        int turns;
        std::string winner;    
    };

    class Board{

    private:
        ros::NodeHandle *node_handle;

        /* params */

        state game_state;   //게임 상태
        int serv_sock;

        struct buffer buf_info;

        std::string path;    //path save log
        std::ofstream writeFile;  //ofstream to save log






    public:
        Board(ros::NodeHandle &nh, const int sock);
        ~Board();

        void run_board();
        void DivideAndParseBuffer(std::string buf); //divide and parse buffer stream

        int hai_str_to_int(const std::string hai_str);  //convert 패 37가지 1~37
        std::string hai_int_to_str(int hai_int);
        int hai38_to_hai9(int hai_int38);
        
        void PrintTehai();  //print all tehai 

        

        int CalculateShanten(std::vector<int>& tehai, std::vector<Fuuro_Elem_>& Fuuro, int dahai);

        std::vector<buffer> CheckNaki(int actor, int target, state& use_game_state, bool last_actor_chi);

        std::string Planner(std::string act);
        int dahai(int possible, state& use_game_state, int depth, int actor);

        //change state funcion
        void ChangeStateWithStartKyoku();
        void ChangeStateWithTsumo(state& game_state_, buffer& buf_info_, bool plan);
        void ChangeStateWithDahai(state& game_state_, buffer& buf_info_);
        void ChangeStateWithHora();
        void ChangeStateWithRyokyoku();
        void ChangeStateWithChi(state& game_state_, buffer& buf_info_);
        void ChangeStateWithPon(state& game_state_, buffer& buf_info_);
        void ChangeStateWithRequest();
        void WriteDahai();


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