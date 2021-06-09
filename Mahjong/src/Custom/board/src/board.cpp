#include "board/board.h"
#include "board/game.h"

#include <iostream>
#include <fstream>
#include <string>
#include <chrono>
#include <cstdlib>
#include <ctime>
#include <cstring>
#include <algorithm>

#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

#define PORT 7777
#define BUF_SIZE 3076
const char IP[] = "127.0.0.1";  //loopback

using namespace std;
void print_log(string node_name, string func,string str);



namespace Custom{
    Board::Board(ros::NodeHandle &nh, const int sock)   //생성자
    {
        
        
        node_handle = &nh;  //get node handle
        serv_sock = sock;

        
    }
    
    Board::~Board() 
    {   
    }

    std::string Board::Planner(std::string act){
        if(act == "dahai"){
            vector<int> possible;
            cout<<"gd"<<endl;
            for (int i = 1; i < game_state.tehai[0].size(); i++) { //make possible action
                if (game_state.tehai[0][i] > 0)
                    possible.push_back(i);
            }
            cout<<"god"<<endl;
            vector<int> haipai_temp;
            for (int i = 1; i < game_state.haipai.size(); i++) {
                for (int j = 0; j < game_state.haipai[i]; j++)
                    haipai_temp.push_back(i);
            }
            cout<<"good"<<endl;
            vector<int> fuuro;
            fuuro.resize(4);
            for (int i = 1; i < 4; i++) {
                int count = 0;
                for (int j = 0; j < game_state.Fuuro[i].size(); j++) {
                    for (int k = 0; k < game_state.Fuuro[i][j].consumed.size(); k++) {
                        count++;
                    }
                    count++;
                }
                fuuro[i] = count;
            }
            cout<<"goood"<<endl;
            int act = 0;
            int result = -999999999;
            int simulation_count = 20;
            int result_vec[possible.size()] = {0,};
            for (int j = 0; j < simulation_count; j++) {
                state new_game_state = game_state;
                vector<int> new_haipai = haipai_temp;

                for (int k = 1; k < 4; k++) {  //make ai's tehai
                    for (int l = 0; l < 13 - fuuro[k]; l++) {
                        int random = rand() % new_haipai.size();

                        //heuristics -> dahai pai usually dont use tehai
                        if (find(new_game_state.dahai[k].begin(), new_game_state.dahai[k].end(),
                            new_haipai[random]) != new_game_state.dahai[k].end()) {
                            if ((rand() % 10) > 2) { //70% -> dont insert dahai pai
                                l--;
                                continue;
                            }
                        }

                        new_game_state.tehai[k][new_haipai[random]]++;
                        new_game_state.haipai[new_haipai[random]]--;
                        new_haipai.erase(new_haipai.begin() + random);
                    }
                }
                random_shuffle(new_haipai.begin(), new_haipai.end());
                new_game_state.haipai = new_haipai;
                //finish setting
                
                
                cout<<"gooood"<<endl;
                for(int k =0;k<4;k++){
                    for(int l = 0;l<new_game_state.tehai[k].size();l++){
                        for(int a = 0;a<new_game_state.tehai[k][l];a++)
                            cout<<hai_int_to_str(l)<<", ";
                    }
                    cout<<endl;
                }
                for(int i = 0;i<new_haipai.size();i++){
                    cout<<hai_int_to_str(new_haipai[i])<<", ";
                }
                cout<<endl;

                for (int k = 0; k < possible.size(); k++) {
                    cout<<"start simulation : ";
                    result_vec[k] += dahai(possible[k], new_game_state, 0, PLAYER);
                }
            }

            //calculate min value
            for (int k = 0; k < possible.size(); k++) {
                if (result < result_vec[k] / simulation_count) {
                    result = result_vec[k] / simulation_count;
                    act = k;
                }
            }

            cout << "result : " << result << ", dahai_act : " << hai_int_to_str(possible[act]) << endl;
            return hai_int_to_str(possible[act]);
        }
    }

   
    int Board::CalculateShanten(vector<int>& tehai, vector<Fuuro_Elem_>& Fuuro, int dahai) {
        //do simulation //TODO:
        string man = "";
        string pin = "";
        string sou = "";
        string honors = "";
        vector<int> temp = tehai;
        Tehai_Analyzer tehai_analyzer;
        Fuuro_Vector fuuro_vec;
        fuuro_vec.resize(Fuuro.size());
        for (int i = 0; i < Fuuro.size(); i++) {
            if (Fuuro[i].type == PON)
                fuuro_vec[i].type = FT_PON;
            else if (Fuuro[i].type == CHI)
                fuuro_vec[i].type = FT_CHI;
            fuuro_vec[i].hai = Fuuro[i].hai;
            //tehai[Fuuro[i].hai]--;
            fuuro_vec[i].consumed = Fuuro[i].consumed;  //TODO:
            //for(int j =0;j<Fuuro[i].consumed.size();j++)
                //tehai[Fuuro[i].consumed[j]]--;
        }
        Hai_Array hai;
        std::copy_n(tehai.begin(), 38, hai.begin());

        Game_State stat;
        stat.player_state[0].tehai = hai;
        stat.player_state[0].fuuro = fuuro_vec;

        tehai_analyzer.reset_tehai_analyzer_with(hai, false, fuuro_vec);
        //tehai_analyzer.print_tehai();
        tehai_analyzer.analyze_tenpai(0, stat);
        //cout << tehai_analyzer.get_mentu_shanten_num() << endl;
        //cout << tehai_analyzer.get_titoi_shanten_num() << endl;
        tehai = temp;
        return min(tehai_analyzer.get_mentu_shanten_num(), tehai_analyzer.get_titoi_shanten_num());
    }

    std::vector<buffer> Board::CheckNaki(int actor, int target, state& use_game_state, bool last_actor_chi){
        int recent_dahai = use_game_state.recent_dahai;
        vector<int>& tehai = use_game_state.tehai[actor];
        vector<buffer> return_vec;
        if (tehai[recent_dahai] == 2) {  //PON  //TODO: dont check dora
            buffer temp;
            temp.actor = actor;
            temp.type = "pon";
            temp.pai = hai_int_to_str(recent_dahai);
            vector<string> temp_vec(2,hai_int_to_str(recent_dahai));
            temp.consumed = temp_vec;
            buf_info.target = target;
            return_vec.push_back(temp);
        }

        if(last_actor_chi == true){ //CHI
            if (recent_dahai < 30) {    //use man, pin ,sou
                if (hai38_to_hai9(recent_dahai) < 8) {  //LEFT
                    if (tehai[recent_dahai + 1] > 0 && tehai[recent_dahai + 2] > 0) {
                        vector<int> temp_vec = {tehai[recent_dahai + 1], tehai[recent_dahai + 2]};
                        return_vec.push_back(MakeChiBuffer(actor, target, recent_dahai, temp_vec));
                    }
                }
                if (hai38_to_hai9(recent_dahai) < 9 && hai38_to_hai9(recent_dahai) > 1) {  //MIDDLE
                    if (tehai[recent_dahai - 1] > 0 && tehai[recent_dahai + 1] > 0) {
                        vector<int> temp_vec = {tehai[recent_dahai - 1], tehai[recent_dahai + 1]};
                        return_vec.push_back(MakeChiBuffer(actor, target, recent_dahai, temp_vec));
                    }
                }
                if (hai38_to_hai9(recent_dahai) > 2) {  //RIGHT
                    if (tehai[recent_dahai - 1] > 0 && tehai[recent_dahai - 2] > 0) {
                        vector<int> temp_vec = {tehai[recent_dahai - 1], tehai[recent_dahai - 2]};
                        return_vec.push_back(MakeChiBuffer(actor, target, recent_dahai, temp_vec));
                    }
                }
            }
        }

        return return_vec;
    }

    buffer Board::MakeChiBuffer(int actor, int target, int pai, vector<int> consumed) {
        buffer temp;
        temp.actor = actor;
        temp.type = "chi";
        temp.pai = hai_int_to_str(pai);
        vector<string> temp_vec;
        for(int i =0;i<consumed.size();i++)
            temp_vec.push_back(hai_int_to_str(consumed[i]));
        temp.consumed = temp_vec;
        buf_info.target = target;

        return temp;
    }

    int Board::hai38_to_hai9(int hai_int38){
        int hai_int9 = 0;
        if (hai_int38 % 10 == 0)
                hai_int9 = 5;
            else
                hai_int9 = hai_int38 % 10;
        
        return hai_int9;
    }

    int Board::dahai(int possible, state& use_game_state, int depth, int actor){    
        state init =use_game_state;
        
        int next_actor = actor + 1;
        if (next_actor > 3) next_actor = 0;

        buffer new_buf_info;
        new_buf_info.actor = actor;
        new_buf_info.pai = hai_int_to_str(possible);
        //cout<<"aa"<<CalculateShanten(use_game_state.tehai[0], use_game_state.Fuuro[0], -1);  //hora TODO:
               
        ChangeStateWithDahai(use_game_state, new_buf_info);

        //cout<<"bb"<<CalculateShanten(use_game_state.tehai[0], use_game_state.Fuuro[0], -1);  //hora TODO:
             
        //cant do pon, chi...

        //need check end to return
        if (use_game_state.turn >= 70)  //ryukyoku  //TODO: check end
            return -1000;
        for (int i = 0; i < 4; i++) {   //check ron
            if (i == actor)
                continue;
            //cout<< depth<<" "<<i<<" : ";
            if (CalculateShanten(use_game_state.tehai[i], use_game_state.Fuuro[i], use_game_state.recent_dahai) == 0) {  //hora TODO:
                if (i == PLAYER)
                    return 1000;
                else
                    return -1000;
            }
        }
        //check pon,chi...
        if (depth != 0) {
            for (int i = actor + 3; i < actor + 6; i++) {
                int j = i;
                if (j > 3)
                    j = j % 4;
                bool last_actor_chi = false;
                if (j == (actor + 1) % 4)
                    last_actor_chi = true;
                vector<buffer> buf_check = CheckNaki(j, actor, use_game_state, last_actor_chi);
                if (!buf_check.empty()) {
                    if ((rand() % 10) < 3) {  //30% -> naki, 70% - >dont naki
                        int select_naki = rand() % buf_check.size();

                        if (buf_check[select_naki].type == "pon")
                            ChangeStateWithPon(use_game_state, buf_check[select_naki]);
                        else if (buf_check[select_naki].type == "chi")
                            ChangeStateWithChi(use_game_state, buf_check[select_naki]);

                        //calc possible
                        vector<int> possible_vec;
                        for (int k = 1; k < use_game_state.tehai[next_actor].size(); k++) {  //make possible action
                            if (use_game_state.tehai[next_actor][k] > 0)
                                possible_vec.push_back(i);
                        }
                        int random = rand() % possible_vec.size();
                        state next_game_state = use_game_state;
                        return dahai(possible_vec[random], next_game_state, depth + 1, next_actor);
                    }
                }
            }
        }

        //tsumo
        new_buf_info.actor = next_actor;
        new_buf_info.pai = hai_int_to_str(use_game_state.haipai[use_game_state.turn - (70 - use_game_state.haipai.size())]);
        ChangeStateWithTsumo(use_game_state, new_buf_info,true);

        //need check end
        if (CalculateShanten(use_game_state.tehai[next_actor], use_game_state.Fuuro[next_actor], -1) == 0) {  //hora TODO:
            if (next_actor == PLAYER)
                return 1000;
            else
                return -1000;
        }

        if(depth == 0){
            int result = 0;

            

            //calc possible
            vector<int> possible_vec;
            for (int i = 1; i < use_game_state.tehai[next_actor].size(); i++) { //make possible action
                if (use_game_state.tehai[next_actor][i] > 0)
                    possible_vec.push_back(i);
            }

            //do simulation
            int count = 10;
            for (int i = 0; i < count; i++) {
                state next_game_state = use_game_state;
                int random = rand() % possible_vec.size();
                result += dahai(possible_vec[random], next_game_state, depth + 1, next_actor);
                //cout<<result<<endl;
            }
            use_game_state = init;
            return result / count;
        }
        else{
            int result = 0;

            //calc possible
            vector<int> possible_vec;
            for (int i = 1; i < use_game_state.tehai[next_actor].size(); i++) { //make possible action
                if (use_game_state.tehai[next_actor][i] > 0)
                    possible_vec.push_back(i);
            }

            //do simulation
            state next_game_state = use_game_state;
            int random = rand() % possible_vec.size();
            return dahai(possible_vec[random], next_game_state, depth + 1, next_actor);
        }

        return 0;   //not use
    }
    
    void Board::run_board(){
        //type = tsumo, dahai, start_kyoku, chi, pon, hora
        // reach, reach_accepted, end_kyoku, ryukyoku, end_game...
        if(buf_info.type == "start_kyoku")
            ChangeStateWithStartKyoku();
        else if(buf_info.type == "tsumo")
            ChangeStateWithTsumo(game_state, buf_info,false);
        else if(buf_info.type == "dahai")
            ChangeStateWithDahai(game_state, buf_info);
        //else if(buf_info.type == "reach")
            //TODO: reach
        else if(buf_info.type == "hora")
            ChangeStateWithHora();
        else if(buf_info.type == "ryukyoku")
            ChangeStateWithRyokyoku();
        else if(buf_info.type == "chi")
            ChangeStateWithChi(game_state, buf_info);
        else if(buf_info.type == "pon")
            ChangeStateWithPon(game_state, buf_info);
        else if(buf_info.type == "request")
            ChangeStateWithRequest();
        else if(buf_info.type == "need dahai")
            WriteDahai();

    }

    void Board::ChangeStateWithStartKyoku(){    //set game state init
        game_state.haipai.clear();
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

        game_state.dahai.clear();
        game_state.tehai.clear();
        game_state.Fuuro.clear();

        game_state.dahai.resize(4);
        game_state.tehai.resize(4);
        game_state.Fuuro.resize(4);
        for (int i = 0; i < game_state.tehai.size(); i++){
            game_state.tehai[i].clear();
            game_state.tehai[i].resize(38, 0); //reset all to ?
        }
        for (int i = 0; i < buf_info.start_tehai.size(); i++){
            game_state.tehai[0][hai_str_to_int(buf_info.start_tehai[i])]++;
            game_state.haipai[hai_str_to_int(buf_info.start_tehai[i])]--;
        }
    
    }
    void Board::ChangeStateWithTsumo(state& game_state_, buffer& buf_info_, bool plan){
        if(buf_info_.actor == PLAYER){   //if player's tsumo
            game_state_.actor = 0;
            game_state_.tsumo = hai_str_to_int(buf_info_.pai);
            game_state_.tehai[PLAYER][hai_str_to_int(buf_info_.pai)]++;
            if (plan == false)
                game_state_.haipai[hai_str_to_int(buf_info_.pai)]--;
            game_state_.turn++;
        } else {
            game_state_.actor = buf_info_.actor;
            game_state_.turn++;
            if(buf_info_.pai != "?"){
                game_state_.tsumo = hai_str_to_int(buf_info_.pai);
                game_state_.tehai[buf_info_.actor][hai_str_to_int(buf_info_.pai)]++;
                //game_state_.haipai[hai_str_to_int(buf_info_.pai)]--;
            }
        }
        game_state_.recent_dahai = -1;
    }
    void Board::ChangeStateWithDahai(state& game_state_, buffer& buf_info_){
        game_state_.actor = buf_info_.actor;
        if(game_state_.actor == PLAYER){ 
            string dahai;
            //cin >> dahai;
            //dahai = to_string(hai_str_to_int(dahai));
            game_state_.recent_dahai = hai_str_to_int(buf_info_.pai);
            game_state_.dahai[game_state_.actor].push_back(game_state_.recent_dahai);
            game_state_.tehai[game_state_.actor][game_state_.recent_dahai]--;
        } else {
            game_state_.recent_dahai = hai_str_to_int(buf_info_.pai);
            game_state_.dahai[game_state_.actor].push_back(game_state_.recent_dahai);
            if(game_state_.tehai[game_state_.actor][game_state_.recent_dahai]>0)
                game_state_.tehai[game_state_.actor][game_state_.recent_dahai]--;
        }
    }
    void Board::ChangeStateWithHora(){
        //TODO: 
        game_state.score = buf_info.score;
    }
    void Board::ChangeStateWithRyokyoku(){
        //TODO:
        game_state.score = buf_info.score;
    }
    void Board::ChangeStateWithChi(state& game_state_, buffer& buf_info_){
        Fuuro_Elem_ temp;
        temp.type = CHI;
        temp.hai = hai_str_to_int(buf_info_.pai);
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[0]));
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[1]));
        temp.target_relative = buf_info_.actor * 10 + buf_info_.target;

        game_state_.recent_dahai = 0;

        game_state_.actor = buf_info_.actor;
        for (int i = 0; i < buf_info_.consumed.size(); i++)
            game_state_.tehai[game_state_.actor][hai_str_to_int(buf_info_.consumed[i])]--;

        game_state_.Fuuro[game_state_.actor].push_back(temp);
    }
    void Board::ChangeStateWithPon(state& game_state_, buffer& buf_info_){
        Fuuro_Elem_ temp;
        temp.type = PON;
        temp.hai = hai_str_to_int(buf_info_.pai);
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[0]));
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[1]));
        temp.target_relative = buf_info_.actor * 10 + buf_info_.target;

        game_state_.recent_dahai = 0;

        game_state_.actor = buf_info_.actor;
        for (int i = 0; i < buf_info_.consumed.size(); i++)
            game_state_.tehai[game_state_.actor][hai_str_to_int(buf_info_.consumed[i])]--;

        game_state_.Fuuro[game_state_.actor].push_back(temp);

    }

    void Board::ChangeStateWithRequest(){
        //TODO: select Fuuro number   0 => dont select 1~
        string buf = "no";  //test dont select
        for (int i = 0; i < buf_info.reqeust.size(); i++) {
            cout << i + 1 << " : ";
            cout << "type : ";
            if (buf_info.reqeust[i].type == PON)
                cout << "pon";
            else if (buf_info.reqeust[i].type == CHI)
                cout << "chi";
            else if (buf_info.reqeust[i].type == KAN)
                cout << "kan";
            else if (buf_info.reqeust[i].type == NONE)
                cout << "none";
            
            if (buf_info.reqeust[i].type != NONE) {
                cout << ", ";
                cout << "consumed : [";
                for (int j = 0; j < buf_info.reqeust[i].consumed.size(); j++) {
                    cout << hai_int_to_str(buf_info.reqeust[i].consumed[j]);
                    if (j != buf_info.reqeust[i].consumed.size() - 1)
                        cout << ", ";
                }
                cout << "], pai : " << hai_int_to_str(buf_info.reqeust[i].hai);
                cout << ", target : " << buf_info.reqeust[i].target_relative;
            }
            cout<<endl;
        }
      cout<<"please type number to select action:";
      cin>>buf;
      cout<<buf<<endl;
      write(serv_sock,buf.c_str(),buf.size());
    }

    void Board::WriteDahai(){
        //select Dahai  insert AI TODO:
            string dahai;
            for (int i = 0; i < buf_info.consumed.size(); i++) {
                game_state.tehai[PLAYER][hai_str_to_int(buf_info.consumed[i])]--;
            }
            dahai = Planner("dahai");
            PrintTehai();
            //dahai = buf_info.pai;   //test
            // cout << "please type pai to dahai : ";
            // cin >> dahai;
            write(serv_sock,dahai.c_str(),dahai.size());

            for (int i = 0; i < buf_info.consumed.size(); i++) {
                game_state.tehai[PLAYER][hai_str_to_int(buf_info.consumed[i])]++;
            }
    }

    void Board::PrintTehai(){
        cout << "player's tehai : ";
        for (int i = 0; i < game_state.tehai[PLAYER].size(); i++) {
            for (int j = 0; j < game_state.tehai[PLAYER][i]; j++) {
                cout << hai_int_to_str(i) << ", ";
            }
        }
        cout << endl;
    }

    void Board::DivideAndParseBuffer(std::string buf) {
        //TODO: divide buf
        int pos = 0;
        struct buffer new_buffer;
        if (buf.find("need dahai", pos) != -1) {
            new_buffer.type = "need dahai";
            vector<string> consumed = SplitToString(buf,' ',false);
            consumed.erase(consumed.begin());
            consumed.erase(consumed.begin());
            new_buffer.consumed = consumed;
        } else if (buf.find("request", pos) != -1) {  //if request
            new_buffer.type = "request";
            int start_action_pos = buf.find("[",pos) + 1;   //find action list
            int end_action_pos = buf.rfind("]");
            string action_list = buf.substr(start_action_pos, end_action_pos - start_action_pos);
            vector<Custom::Fuuro_Elem_> action_list_vector;
            start_action_pos = 0;

            while(1){
                int check_pos = action_list.find("actor", start_action_pos);

                if (check_pos == -1){
                    cout<<"break"<<endl;
                    break;
                }

                check_pos = action_list.find("consumed", check_pos);

                Custom::Fuuro_Elem_ req_temp;
                if (check_pos != -1) {
                    start_action_pos = check_pos;
                    start_action_pos = action_list.find("[", start_action_pos) + 1;
                    end_action_pos = action_list.find("]", start_action_pos);
                    string temp = action_list.substr(start_action_pos, end_action_pos - start_action_pos);

                    vector<string> consumed = SplitToString(temp, ',', true);
                    vector<int> int_consumed;
                    int_consumed.clear();
                    for (int i = 0; i < consumed.size(); i++){
                        int_consumed.push_back(hai_str_to_int(consumed[i]));
                    }
                    req_temp.consumed = int_consumed;
                }
                check_pos = 0;

                check_pos = action_list.find("pai\": \"", end_action_pos + 1);
                if (check_pos != -1) {
                    start_action_pos = check_pos + 7;
                    end_action_pos = action_list.find("\"", start_action_pos);
                    cout<<action_list.substr(start_action_pos, end_action_pos - start_action_pos)<<endl;
                    req_temp.hai = hai_str_to_int(action_list.substr(start_action_pos, end_action_pos - start_action_pos));
                }
                check_pos = 0;
                check_pos = action_list.find("target\": ", end_action_pos + 1);
                if (check_pos != -1) {
                    start_action_pos = check_pos + 9;
                    end_action_pos = action_list.find(",", start_action_pos);
                    req_temp.target_relative = stoi(action_list.substr(start_action_pos, end_action_pos - start_action_pos));
                }
                check_pos = action_list.find("type\": \"", end_action_pos + 1);
                if (check_pos != -1) {
                    start_action_pos = check_pos + 8;
                    end_action_pos = action_list.find("\"", start_action_pos);
                    string type_temp = action_list.substr(start_action_pos, end_action_pos - start_action_pos);
                    if (type_temp == "pon")
                        req_temp.type = PON;
                    else if (type_temp == "chi")
                        req_temp.type = CHI;
                    else if (type_temp == "kan")
                        req_temp.type = KAN;
                    else if (type_temp == "none")
                        req_temp.type = NONE;
                }
                check_pos = 0;
                action_list_vector.push_back(req_temp);
                end_action_pos = start_action_pos;


                cout<<"good"<<endl;
            }

            new_buffer.actor = 0;
            new_buffer.reqeust = action_list_vector;
        } else {
            new_buffer.pai = "?";
            while (1) {
                pos = buf.find(":", pos);  //find type pos
                if (pos == -1)
                    break;

                int end_type_pos = buf.rfind("\"", pos);  //find type name
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
                    if (end_pos != -1)
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
                    if (buf[start_pos] != '[') {  //only player (start)
                        int end_pos = buf.find("]", start_pos);
                        string list_str = buf.substr(start_pos, end_pos - start_pos);
                        vector<string> vector_tehai = SplitToString(list_str, ',', true);
                        new_buffer.start_tehai = vector_tehai;
                    } else {
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

                cout << endl;
            }
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
            cout<<"error hai_str_to_int "<<hai_str<<endl;
            exit(0);
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
            cout<< "hai_int_to_str invalid_input "<<hai_int<<endl;
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

    Custom::Board bi(nh, sock);

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
