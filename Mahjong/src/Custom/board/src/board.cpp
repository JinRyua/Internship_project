#include "board/board.h"
#include "board/game.h"

#include <iostream>
#include <string>
#include <chrono>
#include <cstdlib>
#include <ctime>
#include <cstring>

#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

#define PORT 7777
#define BUF_SIZE 3076
const char IP[] = "127.0.0.1";  //loopback

using namespace std;
void print_log(string node_name, string func,string str);



namespace Custom{
    Board::Board(ros::NodeHandle &nh)   //생성자
    {
        
        
        node_handle = &nh;  //get node handle

        
    }

    
    Board::~Board() 
    {   
    }
    
    void Board::run_board(){
        //type = tsumo, dahai, start_kyoku, chi, pon, hora
        // reach, reach_accepted, end_kyoku, ryukyoku, end_game...
        if(buf_info.type == "start_kyoku")
            ChangeStateWithStartKyoku();
        else if(buf_info.type == "tsumo")
            ChangeStateWithTsumo();
        else if(buf_info.type == "dahai")
            ChangeStateWithDahai();
        //else if(buf_info.type == "reach")
            //TODO: reach
        else if(buf_info.type == "hora")
            ChangeStateWithHora();
        else if(buf_info.type == "ryukyoku")
            ChangeStateWithRyokyoku();
        else if(buf_info.type == "chi")
            ChangeStateWithChi();
        else if(buf_info.type == "pon")
            ChangeStateWithPon();

    }

    void Board::ChangeStateWithStartKyoku(){    //set game state init
        game_state.haipai.resize(38,4);

        game_state.bakaze = buf_info.bakaze;
        game_state.dora_marker.clear();
        game_state.dora_marker.push_back(hai_str_to_int(buf_info.dora_marker));
        game_state.haipai[hai_str_to_int(buf_info.dora_marker)]--;
        game_state.honba = buf_info.honba;
        game_state.kyoku = buf_info.kyoku;
        game_state.kyotaku = buf_info.kyotaku;
        game_state.oya = buf_info.oya;
        game_state.score = buf_info.score;
        game_state.turn = 0;   //70개 뽑음 -> 136(총패) - 14개 영상,도라  - 13*4 배패
        game_state.dahai.resize(4);
        game_state.tehai.resize(4);
        game_state.Fuuro.resize(4);
        for (int i = 0; i < game_state.tehai.size(); i++)
            game_state.tehai[i].resize(38, 0); //reset all to ?
        for (int i = 0; i < buf_info.start_tehai.size(); i++){
            game_state.tehai[0][hai_str_to_int(buf_info.start_tehai[i])]++;
            game_state.haipai[hai_str_to_int(buf_info.start_tehai[i])]--;
        }
        


        
    }
    void Board::ChangeStateWithTsumo(){
        if(buf_info.actor == PLAYER){   //if player's tsumo
            game_state.actor = 0;
            game_state.tsumo = hai_str_to_int(buf_info.pai);
            game_state.tehai[PLAYER][hai_str_to_int(buf_info.pai)]++;
            game_state.haipai[hai_str_to_int(buf_info.pai)]--;
            game_state.turn++;
        } else {
            game_state.actor = buf_info.actor;
            game_state.turn++;
        }
    }
    void Board::ChangeStateWithDahai(){
        game_state.actor = buf_info.actor;
        game_state.recent_dahai = hai_str_to_int(buf_info.pai);
        game_state.dahai[game_state.actor].push_back(game_state.recent_dahai);
    }
    void Board::ChangeStateWithHora(){
        //TODO: 
        game_state.score = buf_info.score;
    }
    void Board::ChangeStateWithRyokyoku(){
        //TODO:
        game_state.score = buf_info.score;
    }
    void Board::ChangeStateWithChi(){
        Fuuro_Elem temp;
        temp.type = CHI;
        temp.hai = hai_str_to_int(buf_info.pai);
        temp.consumed.push_back(hai_str_to_int(buf_info.consumed[0]));
        temp.consumed.push_back(hai_str_to_int(buf_info.consumed[1]));
        temp.target_relative = buf_info.actor * 10 + buf_info.target;

        game_state.recent_dahai = 0;

        game_state.actor = buf_info.actor;
        for (int i = 0; i < buf_info.consumed.size(); i++)
            game_state.tehai[game_state.actor][hai_str_to_int(buf_info.consumed[i])]--;

        game_state.Fuuro[game_state.actor].push_back(temp);
    }
    void Board::ChangeStateWithPon(){
        Fuuro_Elem temp;
        temp.type = PON;
        temp.hai = hai_str_to_int(buf_info.pai);
        temp.consumed.push_back(hai_str_to_int(buf_info.consumed[0]));
        temp.consumed.push_back(hai_str_to_int(buf_info.consumed[1]));
        temp.target_relative = buf_info.actor * 10 + buf_info.target;

        game_state.recent_dahai = 0;

        game_state.actor = buf_info.actor;
        for (int i = 0; i < buf_info.consumed.size(); i++)
            game_state.tehai[game_state.actor][hai_str_to_int(buf_info.consumed[i])]--;

        game_state.Fuuro[game_state.actor].push_back(temp);

    }

    void Board::DivideAndParseBuffer(std::string buf) {
        //TODO: divide buf
        int pos = 0;
        struct buffer new_buffer;
        while(1){
            pos = buf.find(":", pos);  //find type pos
            if(pos == -1)
                break;
            
            int end_type_pos = buf.rfind("\"", pos);    //find type name
            int start_type_pos = buf.rfind("\"", end_type_pos - 1);
            string type = buf.substr(start_type_pos + 1, end_type_pos - start_type_pos - 1);

            //save state
            pos = pos + 1;
            if (type == "actor") {
                int end_pos = buf.find(",", pos);
                new_buffer.actor = stoi(buf.substr(pos, end_pos - pos));
            } else if (type == "pai") {
                int start_pos = buf.find("\"", pos) + 1;
                int end_pos = buf.find("\"", start_pos);
                new_buffer.pai = buf.substr(start_pos, end_pos - start_pos);
            } else if (type == "type") {
                int start_pos = buf.find("\"", pos) + 1;
                int end_pos = buf.find("\"", start_pos);
                new_buffer.type = buf.substr(start_pos, end_pos - start_pos);
            } else if (type == "target") {
                int end_pos = buf.find(",", pos);
                new_buffer.target = stoi(buf.substr(pos, end_pos - pos));
            } else if (type == "tsumogiri") {
                int end_pos = buf.find("false", pos);
                if(end_pos!=-1)
                    new_buffer.tsumogiri = false;
                else
                    new_buffer.tsumogiri = true;
            } else if (type == "honba") {
                int end_pos = buf.find(",", pos);
                new_buffer.honba = stoi(buf.substr(pos, end_pos - pos));
            } else if (type == "kyoku") {
                int end_pos = buf.find(",", pos);
                new_buffer.kyoku = stoi(buf.substr(pos, end_pos - pos));
            } else if (type == "kyotaku") {
                int end_pos = buf.find(",", pos);
                new_buffer.kyotaku = stoi(buf.substr(pos, end_pos - pos));
            } else if (type == "oya") {
                int end_pos = buf.find(",", pos);
                new_buffer.oya = stoi(buf.substr(pos, end_pos - pos));
            } else if (type == "bakaze") {
                int start_pos = buf.find("\"", pos) + 1;
                int end_pos = buf.find("\"", start_pos);
                new_buffer.bakaze = buf.substr(start_pos, end_pos - start_pos);
            } else if (type == "dora_marker") {
                int start_pos = buf.find("\"", pos) + 1;
                int end_pos = buf.find("\"", start_pos);
                new_buffer.dora_marker = buf.substr(start_pos, end_pos - start_pos);
            } else if (type == "scores") {
                int start_pos = buf.find("[", pos) + 1;
                int end_pos = buf.find("]", start_pos);
                string list_str = buf.substr(start_pos, end_pos - start_pos);
                vector<int> vector_score = SplitToInt(list_str, ',');
                new_buffer.score = vector_score;
            } else if (type == "uradora_marker") {
                int start_pos = buf.find("[", pos) + 1;
                int end_pos = buf.find("]", start_pos);
                string list_str = buf.substr(start_pos, end_pos - start_pos);
                vector<string> vector_uradora = SplitToString(list_str, ',', true);
                new_buffer.uradora_marker = vector_uradora;
            } else if (type == "hora_tehais") {
                int start_pos = buf.find("[", pos) + 1;
                int end_pos = buf.find("]", start_pos);
                string list_str = buf.substr(start_pos, end_pos - start_pos);
                vector<string> vector_uradora = SplitToString(list_str, ',', true);
                new_buffer.hora_tehais = vector_uradora;
            } else if (type == "tehais") {
                int start_pos = buf.find("[", pos) + 1;
                if (buf[start_pos] != '[') {   //only player (start)
                    int end_pos = buf.find("]", start_pos);
                    string list_str = buf.substr(start_pos, end_pos - start_pos);
                    vector<string> vector_tehai = SplitToString(list_str, ',', true);
                    new_buffer.start_tehai = vector_tehai;
                }
                else{
                    pos = start_pos;
                    vector<vector<string>> all_vector;
                    for (int i = 0; i < 4; i++) {
                        int start_pos = buf.find("[", pos) + 1;
                        int end_pos = buf.find("]", start_pos);
                        string list_str = buf.substr(start_pos, end_pos - start_pos);
                        vector<string> vector_tehai = SplitToString(list_str, ',', true);
                        all_vector.push_back(vector_tehai);
                        
                        pos = end_pos;
                    }
                    new_buffer.all_tehai = all_vector;
                    
                }
            } else if (type == "consumed") {
                int start_pos = buf.find("[", pos) + 1;
                int end_pos = buf.find("]", start_pos);
                string list_str = buf.substr(start_pos, end_pos - start_pos);
                vector<string> vector_consumed = SplitToString(list_str, ',', true);
                new_buffer.consumed = vector_consumed;
                
            }
            
            cout<<endl;

        }
        
        buf_info = new_buffer;


    }

    int Board::hai_str_to_int(const std::string hai_str) {
        if (hai_str == "1m") {
            return 1;
        } else if (hai_str == "2m") {
            return 2;
        } else if (hai_str == "3m") {
            return 3;
        } else if (hai_str == "4m") {
            return 4;
        } else if (hai_str == "5m") {
            return 5;
        } else if (hai_str == "6m") {
            return 6;
        } else if (hai_str == "7m") {
            return 7;
        } else if (hai_str == "8m") {
            return 8;
        } else if (hai_str == "9m") {
            return 9;
        } else if (hai_str == "5mr") {
            return 10;
        } else if (hai_str == "1p") {
            return 11;
        } else if (hai_str == "2p") {
            return 12;
        } else if (hai_str == "3p") {
            return 13;
        } else if (hai_str == "4p") {
            return 14;
        } else if (hai_str == "5p") {
            return 15;
        } else if (hai_str == "6p") {
            return 16;
        } else if (hai_str == "7p") {
            return 17;
        } else if (hai_str == "8p") {
            return 18;
        } else if (hai_str == "9p") {
            return 19;
        } else if (hai_str == "5pr") {
            return 20;
        } else if (hai_str == "1s") {
            return 21;
        } else if (hai_str == "2s") {
            return 22;
        } else if (hai_str == "3s") {
            return 23;
        } else if (hai_str == "4s") {
            return 24;
        } else if (hai_str == "5s") {
            return 25;
        } else if (hai_str == "6s") {
            return 26;
        } else if (hai_str == "7s") {
            return 27;
        } else if (hai_str == "8s") {
            return 28;
        } else if (hai_str == "9s") {
            return 29;
        } else if (hai_str == "5sr") {
            return 30;
        } else if (hai_str == "E") {
            return 31;
        } else if (hai_str == "S") {
            return 32;
        } else if (hai_str == "W") {
            return 33;
        } else if (hai_str == "N") {
            return 34;
        } else if (hai_str == "P") {
            return 35;
        } else if (hai_str == "F") {
            return 36;
        } else if (hai_str == "C") {
            return 37;
        } else if (hai_str == "?") {
            return -1;
        } else {
            cout<<"error hai_str_to_int"<<endl;
            return 0;
        }
    }
    std::string Board::hai_int_to_str(int hai_int) {
        std::string hai_str = "";
        if (hai_int == 1) {
            hai_str = "1m";
        } else if (hai_int == 2) {
            hai_str = "2m";
        } else if (hai_int == 3) {
            hai_str = "3m";
        } else if (hai_int == 4) {
            hai_str = "4m";
        } else if (hai_int == 5) {
            hai_str = "5m";
        } else if (hai_int == 6) {
            hai_str = "6m";
        } else if (hai_int == 7) {
            hai_str = "7m";
        } else if (hai_int == 8) {
            hai_str = "8m";
        } else if (hai_int == 9) {
            hai_str = "9m";
        } else if (hai_int == 10) {
            hai_str = "5mr";
        } else if (hai_int == 11) {
            hai_str = "1p";
        } else if (hai_int == 12) {
            hai_str = "2p";
        } else if (hai_int == 13) {
            hai_str = "3p";
        } else if (hai_int == 14) {
            hai_str = "4p";
        } else if (hai_int == 15) {
            hai_str = "5p";
        } else if (hai_int == 16) {
            hai_str = "6p";
        } else if (hai_int == 17) {
            hai_str = "7p";
        } else if (hai_int == 18) {
            hai_str = "8p";
        } else if (hai_int == 19) {
            hai_str = "9p";
        } else if (hai_int == 20) {
            hai_str = "5pr";
        } else if (hai_int == 21) {
            hai_str = "1s";
        } else if (hai_int == 22) {
            hai_str = "2s";
        } else if (hai_int == 23) {
            hai_str = "3s";
        } else if (hai_int == 24) {
            hai_str = "4s";
        } else if (hai_int == 25) {
            hai_str = "5s";
        } else if (hai_int == 26) {
            hai_str = "6s";
        } else if (hai_int == 27) {
            hai_str = "7s";
        } else if (hai_int == 28) {
            hai_str = "8s";
        } else if (hai_int == 29) {
            hai_str = "9s";
        } else if (hai_int == 30) {
            hai_str = "5sr";
        } else if (hai_int == 31) {
            hai_str = "E";
        } else if (hai_int == 32) {
            hai_str = "S";
        } else if (hai_int == 33) {
            hai_str = "W";
        } else if (hai_int == 34) {
            hai_str = "N";
        } else if (hai_int == 35) {
            hai_str = "P";
        } else if (hai_int == 36) {
            hai_str = "F";
        } else if (hai_int == 37) {
            hai_str = "C";
        } else {
            cout<< "hai_int_to_str invalid_input"<<endl;
        }
        return hai_str;
    }

    std::vector<std::string> SplitToString(std::string input, char delimiter, bool remove) {
        std::vector<std::string> answer;
        std::stringstream ss(input);
        std::string temp;

        while (getline(ss, temp, delimiter)) {
            if (temp != "" && temp != " "){
                if (remove == true) {
                    int pos = 0;
                    while (1) {
                        pos = 0;
                        pos = temp.find("\"", pos);
                        if (pos != -1) {
                            temp.erase(temp.begin() + pos);
                        } else
                            break;
                    }
                    while (1) {
                        pos = 0;
                        pos = temp.find(" ", pos);
                        if (pos != -1) {
                            temp.erase(temp.begin() + pos);
                        } else
                            break;
                    }
                }
                answer.push_back(temp);

            }
        }

        return answer;
    }

    std::vector<int> SplitToInt(std::string input, char delimiter) {
        std::vector<int> answer;
        std::stringstream ss(input);
        std::string temp;

        while (getline(ss, temp, delimiter)) {
            if (temp != "" && temp != " ")
                answer.push_back(stoi(temp));
        }

        return answer;
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

    //subscriber
    
    int sock;
    struct sockaddr_in serv_addr;
    char buf[BUF_SIZE];
    string buff(BUF_SIZE, 0);
    int str_len;

    sock = socket(PF_INET, SOCK_STREAM, 0); //make socket
    if(sock == -1){
        cout<<"socket() error"<<endl;
        return 0;
    }

    memset(&serv_addr, 0 ,sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = inet_addr(IP);
    serv_addr.sin_port = htons(PORT);

    if(connect(sock,(struct sockaddr*)&serv_addr,sizeof(serv_addr))==-1){
        return 0;
    }

    std::cout<<"ready to run board"<<std::endl;
    ROS_INFO("Custom: (%s) Ready to receive", ros::this_node::getName().c_str());
    double act_time = 1;
    while (ros::ok())
    {
        sleep(0);
        double start_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
        ros::spinOnce();    //check sub and pub and srv

        
        str_len = read(sock, buf, BUF_SIZE - 1);
        if(str_len != 0){
            buf[str_len] = 0;
            buff = buf;
            vector<string> buf_list = Custom::SplitToString(buff, '}' , false);
            for(int i =0;i<buf_list.size();i++){
            cout << buf_list[i] << endl;
            //cout << str_len << endl;
            //TODO: 겹치기 예외 처리

            bi.DivideAndParseBuffer(buf_list[i]);
            bi.run_board();  //run_board if received stream from socket
            }
            
        }

        // double finish_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
        // double rate = (double)(act_time * 1000000000 - (finish_time - start_time)) / 1000000000;
        // if (rate > 0){
        //     ros::Rate wait = 1 / rate;
        //     wait.sleep();
        // }
    }

    close(sock);
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
