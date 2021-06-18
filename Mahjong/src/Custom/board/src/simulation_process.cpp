#include "board/simulation_process.h"
#include "board/types.h"

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

#include <thread>

//https://github.com/critter-mj/akochan
//using mahjong calculator

#define PORT 8888       //multi processing port
#define BUF_SIZE 7152
const char IP[] = "127.0.0.1";  //loopback

using namespace std;
void print_log(string node_name, string func,string str);



namespace Custom{
    SimulationProcess::SimulationProcess(ros::NodeHandle &nh, const int sock)   //생성자
    {
        
        node_handle = &nh;  //get node handle
        serv_sock = sock;
    }
    
    SimulationProcess::~SimulationProcess() 
    {   
        
    }

    bool SimulationProcess::CheckTenpai(state& use_game_state, int actor){
    
        vector<Fuuro_Elem_>& Fuuro = use_game_state.Fuuro[actor];       //actor의 fuuro 상태 가져옴
        Fuuro_Vector fuuro_vec;
        fuuro_vec.resize(Fuuro.size());
        for (int i = 0; i < Fuuro.size(); i++) {        //시뮬레이터의 furro vector 상태로 변경
            if (Fuuro[i].type == PON)
                fuuro_vec[i].type = FT_PON;
            else if (Fuuro[i].type == CHI)
                fuuro_vec[i].type = FT_CHI;
            else if (Fuuro[i].type == DAIMINKAN)
                fuuro_vec[i].type = FT_DAIMINKAN;
            else if (Fuuro[i].type == ANKAN)
                fuuro_vec[i].type = FT_ANKAN;
            else if (Fuuro[i].type == KAKAN)
                fuuro_vec[i].type = FT_KAKAN;

            if(Fuuro[i].type != ANKAN)
                fuuro_vec[i].hai = Fuuro[i].hai;
            fuuro_vec[i].consumed = Fuuro[i].consumed;  
        }

        Hai_Array tehai;    //simulator의 hai_array로 패 상태 convert
        vector<int>& tehai_vec = use_game_state.tehai[actor];
        std::copy_n(tehai_vec.begin(), 38, tehai.begin());

        Game_State stat;    //마작 시뮬레이터의 Game_state 형태로 변경
        stat.bakaze = kaze_str_to_int(use_game_state.bakaze);
        stat.player_state[actor].fuuro = fuuro_vec;
        stat.player_state[actor].jikaze = use_game_state.kyoku;
        for(int i = 0;i<4;i++)
            stat.player_state[i].score = use_game_state.score[i];
        
        //패상태 분석을 위한 클래스
        const Tenpai_Info tenpai_info = cal_tenpai_info(
            stat.bakaze, stat.player_state[actor].jikaze, tehai, stat.player_state[actor].fuuro);
        
        //agari_vec -> 대기 패 상태
        if(tenpai_info.agari_vec.size()!=0) //tenpai => agari pai exist
            return true;
        return false;
        
    }

    int SimulationProcess::CalculateShanten(vector<int>& tehai, vector<Fuuro_Elem_>& Fuuro, int dahai) {
        vector<int> temp = tehai;
        Tehai_Analyzer tehai_analyzer;
        Fuuro_Vector fuuro_vec;                 //마작 시뮬레이터의 클래스로 furro, tehai convert
        fuuro_vec.resize(Fuuro.size());
        for (int i = 0; i < Fuuro.size(); i++) {
            if (Fuuro[i].type == PON)
                fuuro_vec[i].type = FT_PON;
            else if (Fuuro[i].type == CHI)
                fuuro_vec[i].type = FT_CHI;
            else if (Fuuro[i].type == DAIMINKAN)
                fuuro_vec[i].type = FT_DAIMINKAN;
            else if (Fuuro[i].type == ANKAN)
                fuuro_vec[i].type = FT_ANKAN;
            else if (Fuuro[i].type == KAKAN)
                fuuro_vec[i].type = FT_KAKAN;
            if(Fuuro[i].type != ANKAN)
                fuuro_vec[i].hai = Fuuro[i].hai;
            fuuro_vec[i].consumed = Fuuro[i].consumed;  

        }
        Hai_Array hai;
        std::copy_n(tehai.begin(), 38, hai.begin());

        Game_State stat;                //게임 스테이트도 convert
        stat.player_state[0].tehai = hai;
        stat.player_state[0].fuuro = fuuro_vec;

        tehai_analyzer.reset_tehai_analyzer_with(hai, false, fuuro_vec);
        tehai_analyzer.analyze_tenpai(0, stat);     //샨텐 상태 계산
        tehai = temp;
        //샨텐까지 남은 패 계산
        return min(tehai_analyzer.get_mentu_shanten_num(), tehai_analyzer.get_titoi_shanten_num());
    }

    std::vector<buffer> SimulationProcess::CheckNaki(int actor, int target, state& use_game_state, bool last_actor_chi){
        int recent_dahai = use_game_state.recent_dahai; //최근에 버린패
        vector<int>& tehai = use_game_state.tehai[actor];   //액터의 패
        vector<buffer> return_vec;  //울 수 있는 행동들

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
                        vector<int> temp_vec = {recent_dahai + 1, recent_dahai + 2};
                        return_vec.push_back(MakeChiBuffer(actor, target, recent_dahai, temp_vec));
                    }
                }
                if (hai38_to_hai9(recent_dahai) < 9 && hai38_to_hai9(recent_dahai) > 1) {  //MIDDLE
                    if (tehai[recent_dahai - 1] > 0 && tehai[recent_dahai + 1] > 0) {
                        vector<int> temp_vec = {recent_dahai - 1, recent_dahai + 1};
                        return_vec.push_back(MakeChiBuffer(actor, target, recent_dahai, temp_vec));
                    }
                }
                if (hai38_to_hai9(recent_dahai) > 2) {  //RIGHT
                    if (tehai[recent_dahai - 1] > 0 && tehai[recent_dahai - 2] > 0) {
                        vector<int> temp_vec = {recent_dahai - 1, recent_dahai - 2};
                        return_vec.push_back(MakeChiBuffer(actor, target, recent_dahai, temp_vec));
                    }
                }
            }
        }

        return return_vec;
    }

    std::vector<int> SimulationProcess::CalculateScore(state& use_game_state, json11::Json& move, string type) {  
        cout<<"start score"<<endl;
        const json11::Json moves = move;        //hora move

        const int actor = moves["actor"].int_value();
        const int hai = hai_str_to_int(moves["pai"].string_value());

        // legal_check;
        vector<Fuuro_Elem_>& Fuuro = use_game_state.Fuuro[actor]; 
        Fuuro_Vector fuuro_vec;
        fuuro_vec.resize(Fuuro.size());
        for (int i = 0; i < Fuuro.size(); i++) {
            if (Fuuro[i].type == PON)
                fuuro_vec[i].type = FT_PON;
            else if (Fuuro[i].type == CHI)
                fuuro_vec[i].type = FT_CHI;
            else if (Fuuro[i].type == DAIMINKAN)
                fuuro_vec[i].type = FT_DAIMINKAN;
            else if (Fuuro[i].type == ANKAN)
                fuuro_vec[i].type = FT_ANKAN;
            else if (Fuuro[i].type == KAKAN)
                fuuro_vec[i].type = FT_KAKAN;
            if(Fuuro[i].type != ANKAN)
                fuuro_vec[i].hai = Fuuro[i].hai;
            fuuro_vec[i].consumed = Fuuro[i].consumed;  
        }
        Hai_Array tehai;
        vector<int>& tehai_vec = use_game_state.tehai[actor];
        std::copy_n(tehai_vec.begin(), 38, tehai.begin());
        // dora_count
        if (type == "tsumo")    //론과 츠모오름일때 다름
            tehai[hai]--;
        

        Game_State stat;        //state convert -> simulator class
        stat.bakaze = kaze_str_to_int(use_game_state.bakaze);
        stat.player_state[actor].fuuro = fuuro_vec;
        stat.player_state[actor].jikaze = use_game_state.kyoku;
        for(int i = 0;i<4;i++)
            stat.player_state[i].score = use_game_state.score[i];
        
        const Tenpai_Info tenpai_info = cal_tenpai_info(    //패 분석
            stat.bakaze, stat.player_state[actor].jikaze, tehai, stat.player_state[actor].fuuro);

        int agari_id = -1;
        int agari_ten = 0;
        int han_add = 0;
        if (stat.player_state[actor].reach_accepted) {      //리치 되었으면 점수 올림
            han_add++;
            // if (is_ippatsu_valid(game_record, actor)) {  //dont calc ippatsu//TODO:
            //     han_add++;
            // }
        }
        // ハイテイ、
        tehai[hai]++;

        int dora_num = 0;
        std::vector<int> uradora_marker;
        //리치 체크
        if (stat.player_state[actor].reach_accepted) {
            for (int i = 0; i < stat.dora_marker.size(); i++) {
                uradora_marker.push_back(use_game_state.haipai[use_game_state.haipai.size() - 1 - 5 - 2 * i]);
            }
        }
        //도라 체크
        dora_num = count_dora(tehai, stat.player_state[actor].fuuro, stat.dora_marker, uradora_marker);
        //날 수 있는지 체크
        for (int i = 0; i < tenpai_info.agari_vec.size(); i++) {
            if (haikind(hai) == tenpai_info.agari_vec[i].hai &&
                han_add + tenpai_info.agari_vec[i].han_tsumo > 0) {
                int agari_ten_tmp = tsumo_agari(han_add + tenpai_info.agari_vec[i].han_tsumo + dora_num, tenpai_info.agari_vec[i].fu_tsumo, stat.player_state[actor].jikaze == 0);
                if (agari_ten_tmp > agari_ten) {
                    agari_ten = agari_ten_tmp;
                    agari_id = i;
                }
            }
        }
        
        //점수 계산
        cout<<hai_int_to_str( tenpai_info.agari_vec[agari_id].hai)<<" "<<tenpai_info.agari_vec[agari_id].han_tsumo;
        const int han = han_add + tenpai_info.agari_vec[agari_id].han_tsumo + dora_num;
        const int fu = tenpai_info.agari_vec[agari_id].fu_tsumo;
        std::array<int, 4> ten_move = ten_move_hora(
            actor, actor, han, fu, use_game_state.oya, stat.honba, use_game_state.kyotaku, false);
        
        std::array<int, 4> scores;

        //점수 저장
        vector<int> score_return;
        for (int pid = 0; pid < 4; pid++) {
            score_return.push_back(stat.player_state[pid].score + ten_move[pid]);
        }

        tehai[hai]--;   //상태 복원
        
        if (actor == PLAYER) {
            cout << endl
                 << "score : ";
            cout << score_return[PLAYER] << endl;
        }
        return score_return;
    }

    buffer SimulationProcess::MakeChiBuffer(int actor, int target, int pai, vector<int> consumed) {
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

    int SimulationProcess::hai38_to_hai9(int hai_int38){
        int hai_int9 = 0;
        if (hai_int38 % 10 == 0)    //도라
                hai_int9 = 5;
            else
                hai_int9 = hai_int38 % 10;
        
        return hai_int9;
    }

    bool SimulationProcess::CheckHora(state& use_game_state, int next_actor, json11::Json& last_act){
        json11::Json hora_move = make_hora(next_actor, next_actor, use_game_state.tsumo);   //오름 액션
        json11::Json last_move = last_act;  //최근 액션
        
        Moves game_record(1, last_move);    
        array<int, 4UL> arr;    
        //convert to simulator class
        std::copy_n(use_game_state.score.begin(), 4, arr.begin());
        game_record.push_back(make_start_kyoku(kaze_str_to_int(use_game_state.bakaze), use_game_state.kyoku, use_game_state.honba, use_game_state.kyotaku, arr));
        game_record.push_back(last_move);

        Game_State stat;
        stat.bakaze = kaze_str_to_int(use_game_state.bakaze);
        Hai_Array temp_hai;
        std::copy_n(use_game_state.tehai[next_actor].begin(), 38, temp_hai.begin());
        stat.player_state[next_actor].tehai = temp_hai;
        Fuuro_Vector fuuro_vec;
        vector<Fuuro_Elem_> Fuuro = use_game_state.Fuuro[next_actor];
        fuuro_vec.resize(Fuuro.size());
        for (int i = 0; i < Fuuro.size(); i++) {
            if (Fuuro[i].type == PON)
                fuuro_vec[i].type = FT_PON;
            else if (Fuuro[i].type == CHI)
                fuuro_vec[i].type = FT_CHI;
            else if (Fuuro[i].type == DAIMINKAN)
                fuuro_vec[i].type = FT_DAIMINKAN;
            else if (Fuuro[i].type == ANKAN)
                fuuro_vec[i].type = FT_ANKAN;
            else if (Fuuro[i].type == KAKAN)
                fuuro_vec[i].type = FT_KAKAN;
            if (Fuuro[i].type != ANKAN)
                fuuro_vec[i].hai = Fuuro[i].hai;
            fuuro_vec[i].consumed = Fuuro[i].consumed;
        }
        stat.player_state[next_actor].fuuro = fuuro_vec;
        stat.player_state[next_actor].jikaze = use_game_state.kyoku;
  
        //legal check
        bool co = is_legal_hora(game_record, stat, hora_move);

        //save hora action
        last_act = hora_move;
        return co;
    }

    int SimulationProcess::DahaiSimulation(int possible, state& use_game_state, int depth, int actor){  
        state init = use_game_state;
        //상태 저장
        int next_actor = actor + 1; //다음 액터
        if (next_actor > 3) next_actor = 0;

        buffer new_buf_info;        //dahai를 위한 buffer 생성
        new_buf_info.actor = actor;
        new_buf_info.pai = hai_int_to_str(possible);

        bool check_shanten_flag[4] = {false,};
        
       
        ChangeStateWithDahai(use_game_state, new_buf_info, true);   //dahai action

        //need check end to return
        if (use_game_state.turn >= 70) {  //ryukyoku   check
            bool checktenpai[4] = {
                0,
            };
            int count = 0;
            for (int i = 0; i < 4; i++) {  //tenpai 한 사람 계산
                checktenpai[i] = CheckTenpai(use_game_state, i);
                if (checktenpai[i] == true)
                    count++;
            }
            if (count == 0 || count == 4)  //아무도 tenpai x, 모두 tenpai o
                return 0;
            else if (count == 1) {  //한사람만 tenpai => 3000점 나머지 -1000
                if (checktenpai[PLAYER] == true)
                    return 3000;
                else
                    return -1000;
            } else if (count == 2) {    //두사람 tenpai => 두명 1500 , 나머지 -1500
                if (checktenpai[PLAYER] == true)
                    return 1500;
                else
                    return -1500;
            } else if (count == 3) {   //세사람 tenpai => 세명 1000, 나머지 -3000
                if (checktenpai[PLAYER] == true)
                    return 1000;
                else
                    return -3000;
            }
        }

        for (int i = 0; i < 4; i++) {   //check ron
            if (i == actor)//|| check_shanten_flag[i] == false)     //자신 ron 불가
                continue;       
            
            //cant ron dahai pai 자신이 버린패랑 같으면 불가
            if (find(use_game_state.dahai[i].begin(), use_game_state.dahai[i].end(), use_game_state.recent_dahai) != use_game_state.dahai[i].end())
                continue;

            json11::Json last_move = make_dahai(actor, use_game_state.recent_dahai, false);
            //날 수 있는지 체크함
            if (CheckHora(use_game_state, i, last_move)) {
                //날 수 있음
                cout << "dahai " << hai_int_to_str(use_game_state.recent_dahai) << i << actor << endl;
                //상태 출력
                for (int k = i; k < i + 1; k++) {
                    for (int l = 0; l < use_game_state.tehai[k].size(); l++) {
                        for (int a = 0; a < use_game_state.tehai[k][l]; a++)
                            cout << hai_int_to_str(l) << ", ";
                    }
                    cout << endl;
                }
                cout << "fuuro" << endl;
                int j = i;
                for (int k = j; k < j + 1; k++) {
                    for (int l = 0; l < use_game_state.Fuuro[k].size(); l++) {
                        cout << TypeIntToStr(use_game_state.Fuuro[k][l].type) << " : ";
                        if (use_game_state.Fuuro[k][l].hai > 0)
                            cout << hai_int_to_str(use_game_state.Fuuro[k][l].hai) << ", ";
                        for (int a = 0; a < use_game_state.Fuuro[k][l].consumed.size(); a++)
                            cout << hai_int_to_str(use_game_state.Fuuro[k][l].consumed[a]) << ", ";
                        cout << "||";
                    }
                    cout << endl;
                }
                //점수 계산
                vector<int> result_score = CalculateScore(use_game_state, last_move, "dahai");
                int score = 0;
                if (i == PLAYER)    //플레이어면 추가 점수 (휴리스틱)
                    score += 1500;
                return result_score[PLAYER] - game_state.score[PLAYER] + score;
            }
        }
        //check pon,chi...
        if (depth != 0) {
            for (int i = actor + 2; i < actor + 6; i++) {   //actor 오른쪽부터
                int j = i;  //actor 계산
                if (j > 3)
                    j = j % 4;
                if (j == actor) 
                    continue;
                    
                bool last_actor_chi = false;    //chi 가능한 사람인지
                if (j == (actor + 1) % 4)
                    last_actor_chi = true;

                //울 수 있는지
                vector<buffer> buf_check = CheckNaki(j, actor, use_game_state, last_actor_chi);
                
                //있음
                if (!buf_check.empty()) {
                    if(j == PLAYER){    //player call only pon
                        for (int l = 0; l < buf_check.size(); l++) {
                            if (buf_check[l].type == "pon") {
                                ChangeStateWithPon(use_game_state, buf_check[l], true);

                                vector<int> possible_vec;
                                for (int k = 1; k < use_game_state.tehai[j].size(); k++) {  //make possible action
                                    if (use_game_state.tehai[j][k] > 0)
                                        possible_vec.push_back(k);
                                }
                                int random = rand() % possible_vec.size();
                                state next_game_state = use_game_state;

                                return DahaiSimulation(possible_vec[random], next_game_state, depth + 1, j);
                            }
                        }
                    }
                    else if ((rand() % 10) < 1) {  //10% -> naki, 90% - >dont naki
                        int select_naki = rand() % buf_check.size();
                        
                        if (buf_check[select_naki].type == "pon")
                            ChangeStateWithPon(use_game_state, buf_check[select_naki], true);
                        else if (buf_check[select_naki].type == "chi")
                            ChangeStateWithChi(use_game_state, buf_check[select_naki], true);
                        
                        vector<int> possible_vec;
                        for (int k = 1; k < use_game_state.tehai[j].size(); k++) {  //make possible action
                            if (use_game_state.tehai[j][k] > 0)
                                possible_vec.push_back(k);
                        }
                        int random = rand() % possible_vec.size();
                        state next_game_state = use_game_state;
                        
                        return DahaiSimulation(possible_vec[random], next_game_state, depth + 1, j);
                    }
                }
            }
        }

        //tsumo함
        new_buf_info.actor = next_actor;
        new_buf_info.pai = hai_int_to_str(use_game_state.haipai[use_game_state.haipai.size() - (70 - use_game_state.turn) - 13]);
        ChangeStateWithTsumo(use_game_state, new_buf_info, true);

        //need check end
        json11::Json last_move = make_tsumo(next_actor, use_game_state.tsumo);
        if (CheckHora(use_game_state, next_actor, last_move)) { //울수있음
            //상태 출력
            cout << endl
                 << "tsumo " << next_actor << hai_int_to_str(use_game_state.tsumo) << endl;
            for (int k = next_actor; k < next_actor + 1; k++) {
                for (int l = 0; l < use_game_state.tehai[k].size(); l++) {
                    for (int a = 0; a < use_game_state.tehai[k][l]; a++)
                        cout << hai_int_to_str(l) << ", ";
                }
                cout << endl;
            }
            cout << "fuuro" << endl;
            int j = next_actor;
            for (int k = j; k < j + 1; k++) {
                for (int l = 0; l < use_game_state.Fuuro[k].size(); l++) {
                    cout<<TypeIntToStr(use_game_state.Fuuro[k][l].type)<<" : ";
                    if (use_game_state.Fuuro[k][l].hai > 0)
                        cout << hai_int_to_str(use_game_state.Fuuro[k][l].hai) << ", ";
                    for (int a = 0; a < use_game_state.Fuuro[k][l].consumed.size(); a++)
                        cout << hai_int_to_str(use_game_state.Fuuro[k][l].consumed[a]) << ", ";
                    cout << "||";
                }
                cout << endl;
            }
            //점수계산
            vector<int> result_score = CalculateScore(use_game_state, last_move, "tsumo");
            int score = 0;
            if (next_actor == PLAYER)   //플레이어는 추가점수
                score += 1500;
            
            return result_score[PLAYER] - game_state.score[PLAYER] + score;
        }
        

        if(depth == 0){ //시뮬레이션 시작일때
            int result = 0;
            //calc possible
            vector<int> possible_vec;   
            for (int i = 1; i < use_game_state.tehai[next_actor].size(); i++) { //make possible action
                if (use_game_state.tehai[next_actor][i] > 0)
                    possible_vec.push_back(i);
            }

            //do simulation
            int count = 5;
            for (int i = 0; i < count; i++) {   //count 만큼 시뮬레이션
                state next_game_state = use_game_state;
                int random = rand() % possible_vec.size();

                //cutsu heuristic   => too many toitoi, chitoitsu
                while (use_game_state.tehai[next_actor][possible_vec[random]] >= 2 && (rand() % 10) > 4) {
                    random = rand() % possible_vec.size();
                }

                //new cutsu heuristic only complete cutsu   => no effect
                // while (use_game_state.tehai[next_actor][possible_vec[random]] == 3 && (rand() % 10) > 2) {
                //     random = rand() % possible_vec.size();
                // }

                //mentsu heuristic  //only ai
                if (next_actor != PLAYER) {
                    while ((use_game_state.tehai[next_actor][possible_vec[random] - 1] >= 1 || use_game_state.tehai[next_actor][possible_vec[random] + 1] >= 1) && (rand() % 10) > 4) {
                        random = rand() % possible_vec.size();
                    }
                }
                result += DahaiSimulation(possible_vec[random], next_game_state, depth + 1, next_actor);
            }
            //평균 계산
            use_game_state = init;
            return result / count;
        }
        else{   //시뮬레이션 중
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

            //cutsu heuristic   => too many toitoi, chitoitsu
            while (use_game_state.tehai[next_actor][possible_vec[random]] == 2 && (rand() % 10) > 4) {
                random = rand() % possible_vec.size();
            }

            //new cutsu heuristic only complete cutsu   => no effect
            // while (use_game_state.tehai[next_actor][possible_vec[random]] == 3 && (rand() % 10) > 2) {
            //     random = rand() % possible_vec.size();
            // }

            //mentsu heuristic
            while ((use_game_state.tehai[next_actor][possible_vec[random] - 1] >= 1 
                || use_game_state.tehai[next_actor][possible_vec[random] + 1] >= 1) && (rand() % 10) > 4) {
                random = rand() % possible_vec.size();
            }
            return DahaiSimulation(possible_vec[random], next_game_state, depth + 1, next_actor);
        }

        return 0;   //not use
    }

    void SimulationProcess::ChangeStateWithStartKyoku(){    //set game state init   -> not use
        game_state.haipai.clear();
        game_state.haipai.resize(38,4);
        game_state.haipai[10] = 1;  //dora
        game_state.haipai[20] = 1;  //dora
        game_state.haipai[30] = 1;  //dora
        game_state.reach.clear();
        game_state.reach.resize(4,pair<bool,int>(false, 0));
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
    void SimulationProcess::ChangeStateWithTsumo(state& game_state_, buffer& buf_info_, bool plan){
        if(buf_info_.actor == PLAYER){   //if player's tsumo
            game_state_.actor = 0;
            game_state_.tsumo = hai_str_to_int(buf_info_.pai);
            game_state_.tehai[PLAYER][hai_str_to_int(buf_info_.pai)]++;
            if (plan == false)  //not use 
                game_state_.haipai[hai_str_to_int(buf_info_.pai)]--;
            game_state_.turn++;
        } else {    //ai
            game_state_.actor = buf_info_.actor;
            game_state_.turn++;
            if(buf_info_.pai != "?"){
                game_state_.tsumo = hai_str_to_int(buf_info_.pai);
                game_state_.tehai[buf_info_.actor][hai_str_to_int(buf_info_.pai)]++;
            }
        }
        game_state_.recent_dahai = -1;
    }
    void SimulationProcess::ChangeStateWithDahai(state& game_state_, buffer& buf_info_, bool plan){
        game_state_.actor = buf_info_.actor;
        if(game_state_.actor == PLAYER){ 
            string dahai;

            game_state_.recent_dahai = hai_str_to_int(buf_info_.pai);
            game_state_.dahai[game_state_.actor].push_back(game_state_.recent_dahai);
            game_state_.dahai_order.push_back((game_state_.actor * 100) + game_state_.dahai[game_state_.actor].size() -1);  //dahai order => actor * 100 + actor's dahai order 
            game_state_.tehai[game_state_.actor][game_state_.recent_dahai]--;
        } else {
            game_state_.recent_dahai = hai_str_to_int(buf_info_.pai);
            game_state_.dahai[game_state_.actor].push_back(game_state_.recent_dahai);
            game_state_.dahai_order.push_back((game_state_.actor * 100) + game_state_.dahai[game_state_.actor].size() -1);  //dahai order  => actor * 100 + actor's dahai order
            if(plan == false)  //if not planning except haipai
                game_state_.haipai[game_state_.recent_dahai]--;
            if(game_state_.tehai[game_state_.actor][game_state_.recent_dahai]>0)
                game_state_.tehai[game_state_.actor][game_state_.recent_dahai]--;
        }
    }
    void SimulationProcess::ChangeStateWithHora(){
        game_state.score = buf_info.score;
    }
    void SimulationProcess::ChangeStateWithRyokyoku(){
        game_state.score = buf_info.score;
    }
    void SimulationProcess::ChangeStateWithChi(state& game_state_, buffer& buf_info_, bool plan){
        Fuuro_Elem_ temp;
        temp.type = CHI;
        temp.hai = hai_str_to_int(buf_info_.pai);
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[0]));
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[1]));
        temp.target_relative = (buf_info_.actor + buf_info_.target) % 4;

        game_state_.recent_dahai = 0;

        game_state_.actor = buf_info_.actor;

        if (buf_info_.actor == PLAYER) {
            for (int i = 0; i < buf_info_.consumed.size(); i++)
                game_state_.tehai[game_state_.actor][hai_str_to_int(buf_info_.consumed[i])]--;

        } else {
            if (plan == true) {
                for (int i = 0; i < buf_info_.consumed.size(); i++)
                    game_state_.tehai[game_state_.actor][hai_str_to_int(buf_info_.consumed[i])]--;
            } else {
                for (int i = 0; i < buf_info_.consumed.size(); i++)
                    game_state_.haipai[hai_str_to_int(buf_info_.consumed[i])]--;
            }
        }

        game_state_.Fuuro[game_state_.actor].push_back(temp);
    }
    void SimulationProcess::ChangeStateWithPon(state& game_state_, buffer& buf_info_, bool plan){
        Fuuro_Elem_ temp;
        temp.type = PON;
        temp.hai = hai_str_to_int(buf_info_.pai);
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[0]));
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[1]));
        temp.target_relative = (buf_info_.actor + buf_info_.target) % 4;

        game_state_.recent_dahai = 0;

        game_state_.actor = buf_info_.actor;

        if (buf_info_.actor == PLAYER) {
            for (int i = 0; i < buf_info_.consumed.size(); i++)
                game_state_.tehai[game_state_.actor][hai_str_to_int(buf_info_.consumed[i])]--;

        } else {
            if (plan == true) {
                for (int i = 0; i < buf_info_.consumed.size(); i++)
                    game_state_.tehai[game_state_.actor][hai_str_to_int(buf_info_.consumed[i])]--;
            } else {
                for (int i = 0; i < buf_info_.consumed.size(); i++)
                    game_state_.haipai[hai_str_to_int(buf_info_.consumed[i])]--;
            }
        }

        game_state_.Fuuro[game_state_.actor].push_back(temp);

    }
    void SimulationProcess::ChangeStateWithDaiminkan(state& game_state_, buffer& buf_info_, bool plan) {
        Fuuro_Elem_ temp;
        temp.type = DAIMINKAN;
        temp.hai = hai_str_to_int(buf_info_.pai);
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[0]));
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[1]));
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[2]));
        temp.target_relative = (buf_info_.actor + buf_info_.target) % 4;

        game_state_.recent_dahai = 0;

        game_state_.actor = buf_info_.actor;
        
        if(buf_info_.actor == PLAYER){
            for (int i = 0; i < buf_info_.consumed.size(); i++)
                game_state_.tehai[game_state_.actor][hai_str_to_int(buf_info_.consumed[i])]--;
        } else {
            if (plan == true) {
                for (int i = 0; i < buf_info_.consumed.size(); i++)
                    game_state_.tehai[game_state_.actor][hai_str_to_int(buf_info_.consumed[i])]--;
            } else {
                for (int i = 0; i < buf_info_.consumed.size(); i++)
                    game_state_.haipai[hai_str_to_int(buf_info_.consumed[i])]--;
            }
        }

        game_state_.Fuuro[game_state_.actor].push_back(temp);
    }
    void SimulationProcess::ChangeStateWithKakan(state& game_state_, buffer& buf_info_, bool plan) {
        Fuuro_Elem_ temp;   
        temp.type = KAKAN;
        temp.hai = hai_str_to_int(buf_info_.pai);
        int actor = buf_info_.actor;
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[0]));
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[1]));
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[2]));

        vector<Fuuro_Elem_>& fuuro_vec = game_state_.Fuuro[actor];
        
        for(int i = 0;i < fuuro_vec.size();i++){
            if(fuuro_vec[i].hai == temp.hai && fuuro_vec[i].type == PON){   //remove PON
                fuuro_vec.erase(fuuro_vec.begin() + i);
            }
        }

        game_state_.recent_dahai = 0;

        game_state_.actor = buf_info_.actor;
        if(actor == PLAYER){
            game_state_.tehai[game_state_.actor][hai_str_to_int(buf_info_.pai)]--;
        } else{
            if(plan == true){
                game_state_.tehai[game_state_.actor][hai_str_to_int(buf_info_.pai)]--;
            } else {
                game_state_.haipai[hai_str_to_int(buf_info_.pai)]--;
            }
        }
            
        game_state_.Fuuro[game_state_.actor].push_back(temp);
    }
    void SimulationProcess::ChangeStateWithAnkan(state& game_state_, buffer& buf_info_, bool plan) {
        Fuuro_Elem_ temp;
        temp.type = ANKAN;
        temp.hai = 0;
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[0]));
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[1]));
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[2]));
        temp.consumed.push_back(hai_str_to_int(buf_info_.consumed[3]));

        game_state_.recent_dahai = 0;

        game_state_.actor = buf_info_.actor;

        if(buf_info_.actor == PLAYER){
            for (int i = 0; i < buf_info_.consumed.size(); i++)
                game_state_.tehai[game_state_.actor][hai_str_to_int(buf_info_.consumed[i])]--;
        } else {
            if (plan == true) {
                for (int i = 0; i < buf_info_.consumed.size(); i++)
                    game_state_.tehai[game_state_.actor][hai_str_to_int(buf_info_.consumed[i])]--;
            } else {
                for (int i = 0; i < buf_info_.consumed.size(); i++)
                    game_state_.haipai[hai_str_to_int(buf_info_.consumed[i])]--;
            }
        }

        game_state_.Fuuro[game_state_.actor].push_back(temp);
    }
    void SimulationProcess::ChangeStateWithDora(state& game_state_, buffer& buf_info_, bool plan){
        game_state_.dora_marker.push_back(hai_str_to_int(buf_info_.dora_marker));
        if (plan == false)
            game_state_.haipai[hai_str_to_int(buf_info_.dora_marker)]--;
        else{
            
        }   

    }
    void SimulationProcess::ChangeStateWithReach(state& game_state_, buffer& buf_info_, bool plan){
        game_state_.reach[buf_info_.actor].first = true;
        game_state_.reach[buf_info_.actor].second = game_state_.dahai_order.size() - 1;
    }
   
    void SimulationProcess::PrintTehai(){
        cout << "player's tehai : ";
        for (int i = 0; i < game_state.tehai[PLAYER].size(); i++) {
            for (int j = 0; j < game_state.tehai[PLAYER][i]; j++) {
                cout << hai_int_to_str(i) << ", ";
            }
        }
        cout << endl;
    }

    int SimulationProcess::hai_str_to_int(const std::string hai_str) {
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
    std::string SimulationProcess::hai_int_to_str(int hai_int) {
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
    std::string SimulationProcess::TypeIntToStr(int type) {
        if (type == NONE)
            return "none";
        else if (type == PON)
            return "pon";
        else if (type == CHI)
            return "chi";
        else if (type == DAIMINKAN)
            return "daiminkan";
        else if (type == KAKAN)
            return "kakan";
        else if (type == ANKAN)
            return "ankan";
        else if (type == HORA)
            return "hora";
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

    int SimulationProcess::run_simulation(std::string buffer) {
        std::istringstream iss(buffer);
        boost::archive::text_iarchive text_ia(iss);
        Queue_state temp;
        text_ia >> temp;  //역직렬화

        int possible = temp.possible;                 //시뮬레이션 할 것
        state new_game_state = temp.game_state;  //시뮬레이션 할 상태
        game_state = new_game_state;
        
       
        return DahaiSimulation(possible, new_game_state, 0, PLAYER);
    }

    int SimulationProcess::CalculatePlayerKazeFromOya(int oya){
        vector<string> order = {"E", "N", "W", "S"};
        int kaze_num = (4 - oya) % 4;
        return kaze_str_to_int(order[kaze_num]);
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
    
    int sock;   //소켓을 위한 데이터들
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

    if(connect(sock,(struct sockaddr*)&serv_addr,sizeof(serv_addr))==-1){   //connect
        cout<<"connect error"<<endl;
        return 0;
    }

    Custom::SimulationProcess si(nh, sock);     //클래스 생성

    std::cout<<"ready to run board"<<std::endl;
    ROS_INFO("Custom: (%s) Ready to receive", ros::this_node::getName().c_str());
    double act_time = 1;
    while (ros::ok())
    {
        sleep(0);
        
        string buffer = "";
        char buf_char[BUF_SIZE];
        int buf_len = read(sock, &buf_char, BUF_SIZE - 1);      //read
        if (buf_len != 0) {
            buf_char[buf_len] = 0;
            buffer = buf_char;

            int result = si.run_simulation(buffer); //분산 시뮬레이션

            buffer = to_string(result); //결과 저장 후 전송
            write(sock, buffer.c_str(), buffer.size());
            
        }
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
