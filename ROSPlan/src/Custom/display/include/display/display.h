#include "ros/ros.h"
#include "display/display_info.h"
#include "std_msgs/Empty.h"
#include "custom_msgs/axis.h"
#include<utility>
#include <vector>
#ifndef DISPLAY
#define DISPLAY

namespace Custom
{

    class Display
    {
    private:
        ros::NodeHandle *node_handle;

        /* params */
        std::string white_board;    //백지 상태
        std::string display_info;   //디스플레이의 기본 내용 -> 이미 기본적으로 벽과 비어있는 길 저장
        
        const int score_size = 1;   //스코어 보드 크기
        int score;              //점수
        int life;               //목숨
        int row;    //맵 크기
        int col;    //맵 크기

        bool selecting_menu;    //고르고 있는 메뉴
        std::vector<custom_msgs::axis> menus;    //메뉴 출력 좌표


        std::vector<custom_msgs::axis> player;    //player 좌표
        std::vector<std::pair<custom_msgs::axis, bool>> agents;   //agent들 좌표
        std::vector<custom_msgs::axis> scookies; //small cookie들 좌표
        std::vector<custom_msgs::axis> lcookies; //lcookies들 좌표


    public:
        Display(ros::NodeHandle &nh);
        ~Display();

        void displayCallback(const display::display_info& msg);  //board가 보내는 display callback
        void exitCallback(const std_msgs::Empty& msg);  //board가 보내는 exit callback
        void display(); //display
    };
}   //close namespace

#endif