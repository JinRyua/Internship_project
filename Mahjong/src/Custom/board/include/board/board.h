#include "ros/ros.h"


#include <fstream>
#include <utility>
#include <map>
#include <string>
#include <vector>

#ifndef BOARD
#define BOARD


namespace Custom
{
    struct state{
        std::vector<std::vector<int>> haipai;   //남은 패    
        std::vector<std::vector<int>> tehai;    //손패  37가지 1~37 
        int recent_dahai;   //최근 버림패
        std::vector<std::vector<int>> dahai;    //버림패
        std::vector<std::vector<int>> chi;    //버림패
        std::vector<int> scroe;    //점수
        std::vector<int> dora_marker;   //도라 표시패
        std::string bakaze;     //바람(동풍)
        int honba;      //본장
        int kyoku;      //국
        int kyotaku;    //남은 스틱
        int oya;        //오야 번호(0~3)

    };

    struct buffer{  //buffer information
        std::string type;
        std::string bakaze;
        std::string dora_marker;
        int honba;
        int kyoku;
        int kyotaku;
        int oya;
        int actor;
        std::string pai;
        int target;
        bool tsumogiri;

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


        buffer buf_info;

        std::string path;    //path save log
        std::ofstream writeFile;  //ofstream to save log





    public:
        Board(ros::NodeHandle &nh);
        ~Board();

        void run_board();
        void DivideBuffer(std::string buf);

        int hai_str_to_int(const std::string hai_str);  //convert 패 37가지 1~37
        std::string hai_int_to_str(int hai_int);
        //service client

        // //publisher
        

        // //service
       
        // //sub callback
        // void exit_callback(const std_msgs::Empty& msg);

    };
}   //close namespace

#endif