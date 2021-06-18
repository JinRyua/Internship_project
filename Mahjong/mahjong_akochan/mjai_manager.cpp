#include <random>
#include "mjai_manager.hpp"

//for custom ai
//socket
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <string>

#define BUF_SIZE 3076

std::mt19937 gen;

void seed_mt19937(int i) {
    gen.seed(i);
}

Game_Settings::Game_Settings() {
    player_id = -1;
    chicha = 0;
}

Moves get_masked_log(Moves game_record, const int pid) {
    // 他家のツモ牌を伏せたログを取得
    for (int i = 0; i < game_record.size(); i++) {
        if (game_record[i]["type"].string_value() == "tsumo" &&
            game_record[i]["actor"].int_value() != pid
        ) {
            game_record[i] = json11::Json::object {
                                    { "type", "tsumo" },
                                    { "actor", game_record[i]["actor"].int_value() },
                                    { "pai", "?"}
                                };
        }
    }
    return game_record;
}

void add_start_game(Moves& game_record) {
    assert(game_record.size() == 0);
    game_record.push_back(make_start_game());
}

void prepare_haiyama(std::vector<int>& haiyama) {
    haiyama.clear();
    const int haiyama_size = 136;
    for (int i = 0;i < haiyama_size; i++) {
		haiyama.push_back(i);
	}

    //std::shuffle(haiyama.begin(), haiyama.end(), gen);    //random haiyama
    
    //custom haiyama
    std::vector<std::string> custom = {"6s","6s","6s","4p","4p","4p","S","5m","6m","4m","1p","1p","9p"};  //13개
    std::vector<std::string> custom2 = {"6s","7s","8s","P","1p","1p","P","P","F","F","2p","9p","9p"};  //13개
    std::vector<std::string> custom3 = {"N","N","S","4m","4m","3p","3p","3p","2s","2s","2s","1m","6m"};  //13개
    std::vector<std::string> custom4 = {"5mr","5pr","5p","C","C","8s","7s","8s","7s","E","E","S","W"};  //13개

    std::vector<int> custom_haiyama;
    int count = 0;
    for(int i =0;i<haiyama_size;i++){   //make origin haiyama
            custom_haiyama.push_back(i);
    }
    for (int i = 0;i < haiyama_size; i++) { //convert 136 -> 38
		custom_haiyama[i] = get_hai38(custom_haiyama[i]);
	}
    for(int i = 0;i<13;i++){    //erase custom haipai from origin
        std::vector<int>::iterator it = find(custom_haiyama.begin(),custom_haiyama.end(),hai_str_to_int(custom[i]));
        custom_haiyama.erase(it);
        it = find(custom_haiyama.begin(),custom_haiyama.end(),hai_str_to_int(custom2[i]));
        custom_haiyama.erase(it);
        it = find(custom_haiyama.begin(),custom_haiyama.end(),hai_str_to_int(custom3[i]));
        custom_haiyama.erase(it);
        it = find(custom_haiyama.begin(),custom_haiyama.end(),hai_str_to_int(custom4[i]));
        custom_haiyama.erase(it);
    }
    //shuffle haiyama
    std::shuffle(custom_haiyama.begin(), custom_haiyama.end(), gen);
    //insert custom haipai
    for(int i =0;i<13;i++){
        custom_haiyama.insert(custom_haiyama.begin()+(i*4),hai_str_to_int(custom[i]));
        custom_haiyama.insert(custom_haiyama.begin()+(i*4+1),hai_str_to_int(custom2[i]));
        custom_haiyama.insert(custom_haiyama.begin()+(i*4+2),hai_str_to_int(custom3[i]));
        custom_haiyama.insert(custom_haiyama.begin()+(i*4+3),hai_str_to_int(custom4[i]));
    }
    //custom_haiyama.insert(custom_haiyama.begin()+(14*4),custom[13]);    //tsumo hora after reach
    //custom_haiyama.insert(custom_haiyama.begin()+(13*4)+2,custom[13]);    //ron hora after reach
    haiyama = custom_haiyama;   //set custom haiyama

    //origin function
	// for (int i = 0;i < haiyama_size; i++) {
	// 	haiyama[i] = get_hai38(haiyama[i]);
	// }

   
}

std::array<std::array<int, 13>, 4> get_haipai(const std::vector<int>& haiyama, const int oya) {
    std::array<std::array<int, 13>, 4> haipai_tmp, haipai;
    for (int i = 0;i <13*4; i++) {
		int pid = i % 4;
		haipai_tmp[pid][i/4] = haiyama[i];
	}
    for (int pid = 0; pid < 4; pid++) {
        haipai[pid] = haipai_tmp[(4 + pid - oya) % 4];
    }
    return haipai;
}

void add_first_kyoku(Moves& game_record, std::vector<int>& haiyama, const int chicha, const json11::Json& request) {    //ready haiyama(패)
    assert(0 < game_record.size());
    const json11::Json& prev = game_record[game_record.size() - 1];
    assert(prev["type"].string_value() == "start_game");
    if (request["haiyama"].is_null()) {
        prepare_haiyama(haiyama);
    }
    const std::array<std::array<int, 13>, 4> haipai = get_haipai(haiyama, chicha);
    const int dora_marker = haiyama[haiyama.size() - 6];
    if (!prev["first_kyoku"].is_null()) {
        std::array<int, 4> scores;
        assert(!prev["first_kyoku"]["kyoku"].is_null());
        assert(prev["first_kyoku"]["scores"].array_items().size() == 4);
        int first_kyoku = prev["first_kyoku"]["kyoku"].int_value();
        for (int i = 0; i < 4; i++) {
            scores[i] = prev["first_kyoku"]["scores"][i].int_value();
        }
        game_record.push_back(make_start_kyoku(0, first_kyoku, 0, 0, chicha, dora_marker, haipai, scores, haiyama));
    } else {
        game_record.push_back(make_start_kyoku(0, 1, 0, 0, chicha, dora_marker, haipai, {25000, 25000, 25000, 25000}, haiyama));
    }
}

void add_next_kyoku_or_end_game(Moves& game_record, std::vector<int>& haiyama, const json11::Json& request) {
    assert(0 < game_record.size());
    const json11::Json& prev = game_record[game_record.size() - 1];
    assert(prev["type"].string_value() == "hora" || prev["type"].string_value() == "ryukyoku");
    std::pair<int, int> next_bakaze_kyoku = cal_next_bakaze_kyoku(game_record);
    std::array<int, 4> scores;
    for (int pid = 0; pid < 4; pid++) {
        scores[pid] = prev["scores"].array_items()[pid].int_value();
    }
    if (next_bakaze_kyoku.first == -1) {
        game_record.push_back(make_end_kyoku());
        game_record.push_back(make_end_game(scores));
    } else {
        const int next_honba = cal_next_honba(game_record);
        const int next_oya = cal_next_oya(game_record);
        game_record.push_back(make_end_kyoku());
        if (request["haiyama"].is_null()) {
            prepare_haiyama(haiyama);
        }
        const std::array<std::array<int, 13>, 4> haipai = get_haipai(haiyama, next_oya);
        const int dora_marker = haiyama[haiyama.size() - 6];

        game_record.push_back(make_start_kyoku(
            next_bakaze_kyoku.first, next_bakaze_kyoku.second,
            next_honba, get_kyotaku(game_record), next_oya,
            dora_marker, haipai, scores, haiyama
        ));
    }
}

void add_tsumo(const std::vector<int>& haiyama, Moves& game_record, const int pid) {
    // game_record.push_back(make_tsumo(pid, haiyama[13*4 + count_tsumo_num_all(game_record)]));
    
    
    game_record.push_back(make_tsumo(pid, haiyama[13*4 + count_tsumo_num(game_record).first])); //update tsumo action   
    //but only update action record
    //current state made by record, haiyama, when it is needed
    
}

void add_rinshan_tsumo(const std::vector<int>& haiyama, Moves& game_record, const int pid) {
    game_record.push_back(make_tsumo(pid, haiyama[haiyama.size() - 1 - count_tsumo_num(game_record).second]));
    // アナログな麻雀とリンシャン牌の取り方が違うが面倒なのでよいことにする。
}

void add_after_ankan(const std::vector<int>& haiyama, Moves& game_record, const int pid) {
    Game_State game_state = get_game_state(game_record);
    const int dora_marker = haiyama[haiyama.size() - 6 - 2 * game_state.dora_marker.size()];
    game_record.push_back(make_dora(dora_marker));
    add_rinshan_tsumo(haiyama, game_record, pid);
}

void add_accept_reach_or_dora_if_necessary(const std::vector<int>& haiyama, Moves& game_record) {
    assert(game_record[game_record.size()-1]["type"].string_value() == "dahai");
    if (game_record[game_record.size()-2]["type"].string_value() == "reach") {
        game_record.push_back(make_reach_accepted(game_record[game_record.size()-2]["actor"].int_value()));
    } else if (game_record[game_record.size()-2]["type"].string_value() == "tsumo") {
        if (game_record[game_record.size()-3]["type"].string_value() == "daiminkan" || game_record[game_record.size()-3]["type"].string_value() == "kakan") {
            Game_State game_state = get_game_state(game_record);
            const int dora_marker = haiyama[haiyama.size() - 6 - 2 * game_state.dora_marker.size()];
            game_record.push_back(make_dora(dora_marker));
        }
    }
}

void add_ryukyoku_fanpai(Moves& game_record) {
    std::array<bool, 4> tenpai_flag = {false, false, false, false};
    std::array<json11::Json, 4> tehais;
    Game_State game_state = get_game_state(game_record);
    for (int pid = 0; pid < 4; pid++) {
        Hai_Array tehai = game_state.player_state[pid].tehai;
        const Tenpai_Info tenpai_info = cal_tenpai_info(
            game_state.bakaze, game_state.player_state[pid].jikaze, tehai, game_state.player_state[pid].fuuro
        );
        if (tenpai_info.shanten_num() == 0) {
            tenpai_flag[pid] = true;
            tehais[pid] = hai_array_to_json(tehai);
        } else {
            json11::Json::array t;
            for (int hai = 0; hai < 38; hai++) {
                for (int i = 0; i < tehai[hai]; i++) {
                    t.push_back("?");
                }
            }
            tehais[pid] = json11::Json(t);
        }
    }
    std::array<int, 4> deltas = ten_move_ryukyoku(tenpai_flag);
    std::array<int, 4> scores;
    for (int pid = 0; pid < 4; pid++) {
        scores[pid] = game_state.player_state[pid].score + deltas[pid];
    }
    game_record.push_back(make_ryukyoku_fanpai(tenpai_flag, tehais, scores));
}

void add_move_after_dahai(const std::vector<int>& haiyama, Moves& game_record, const std::array<Moves, 4>& candidate_moves, const int clnt_sock) {
    const json11::Json& current_move = game_record[game_record.size() - 1];
    assert(current_move["type"].string_value() == "dahai" || current_move["type"].string_value() == "kakan");
    const int target = current_move["actor"].int_value();
    bool ron_flag = false;
    for (int pid_add = 1; pid_add <= 3; pid_add++) {
        const int actor = (target + pid_add) % 4;
        if (candidate_moves[actor][0]["type"].string_value() == "hora") {   //론이 무조건 먼저
            assert(actor == candidate_moves[actor][0]["actor"].int_value());
            assert(target == candidate_moves[actor][0]["target"].int_value());
            // legal_check;
            const int hai = hai_str_to_int(candidate_moves[actor][0]["pai"].string_value());
            const Game_State game_state = get_game_state(game_record);
            // legal_check;
            Hai_Array tehai = game_state.player_state[actor].tehai;
            const Tenpai_Info tenpai_info = cal_tenpai_info(
                game_state.bakaze, game_state.player_state[actor].jikaze, tehai, game_state.player_state[actor].fuuro
            );

            int agari_id = -1;
            int agari_ten = 0;
            int han_add = 0;
            if (game_state.player_state[actor].reach_accepted) {
                han_add++;
                if (is_ippatsu_valid(game_record, actor)) {
                    han_add++;
                }
            }
            if (current_move["type"].string_value() == "kakan") {
                han_add++; // 槍槓
            }
            // ハイテイ、
            tehai[hai]++;
            int dora_num = 0;
            std::vector<int> uradora_marker;
            if (game_state.player_state[actor].reach_accepted) {                
                for (int i = 0; i < game_state.dora_marker.size(); i++) {
                    uradora_marker.push_back(haiyama[136 - 5 - 2*i]);
                }
            }
            dora_num = count_dora(tehai, game_state.player_state[actor].fuuro, game_state.dora_marker, uradora_marker);

            for (int i = 0; i < tenpai_info.agari_vec.size(); i++) {
                if (haikind(hai) == tenpai_info.agari_vec[i].hai &&
                    han_add + tenpai_info.agari_vec[i].han_ron > 0
                ) {
                    int agari_ten_tmp = ron_agari(han_add + tenpai_info.agari_vec[i].han_ron + dora_num, tenpai_info.agari_vec[i].fu_ron, game_state.player_state[actor].jikaze == 0);
                    if (agari_ten_tmp > agari_ten) {
                        agari_ten = agari_ten_tmp;
                        agari_id = i;
                    }
                }
            }
            const int han = han_add + tenpai_info.agari_vec[agari_id].han_ron + dora_num;
            const int fu = tenpai_info.agari_vec[agari_id].fu_ron;
            std::array<int, 4> ten_move = ten_move_hora(
                actor, target, han, fu, get_oya(game_record), game_state.honba, get_kyotaku(game_record), false
            );
            std::array<int, 4> scores;
            for (int pid = 0; pid < 4; pid++) {
                scores[pid] = game_state.player_state[pid].score + ten_move[pid];
            }
            tehai[hai]--;

            
            game_record.push_back(make_hora(actor, target, hai, tehai, han, fu, uradora_marker, scores));
            ron_flag = true;
        }
    }
    if (ron_flag) { return; }
    if (count_tsumo_num_all(game_record) == 70) {
        add_ryukyoku_fanpai(game_record);
        return;
    } else if (current_move["type"].string_value() == "kakan") {    //if kakan => must act
        // 最後の牌はカカンできないため、count_tsumo_num_all(game_record) == 70にはならない。
        add_rinshan_tsumo(haiyama, game_record, target);
        return;
    }
    for (int pid_add = 1; pid_add <= 3; pid_add++) {
        const int actor = (target + pid_add) % 4;
        if (candidate_moves[actor][0]["type"].string_value() == "pon") {    //2개가 동시에 나옴 pon, dahai
            // legal_check;
            add_accept_reach_or_dora_if_necessary(haiyama, game_record);
            if(actor == 0){     //if player, ask what to dahai
                std::string write_buf = "need dahai";
                for (int i = 0; i < candidate_moves[actor][0]["consumed"].array_items().size(); i++) {
                    write_buf += " " + candidate_moves[actor][0]["consumed"].array_items()[i].string_value();
                }
                std::cout<<write_buf<<std::endl;
                write(clnt_sock, write_buf.c_str(), write_buf.size());
                char read_buf[3076];
                std::string read_str;
                int str_len = read(clnt_sock, read_buf, 3076 - 1);
                read_buf[str_len] = 0;
                read_str = read_buf;
                std::cout<<read_str<<std::endl;
                if(read_str == "no"){    //dont pon => dont use -> select none action
                    continue;
                } else {        //add dahai pai 
                    game_record.push_back(candidate_moves[actor][0]);
                    game_record.push_back(make_dahai(actor, hai_str_to_int(read_str), false));
                    return;
                }
            }

            for (const json11::Json& action : candidate_moves[actor]) {
                game_record.push_back(action);
            }
            return;
        } else if (candidate_moves[actor][0]["type"].string_value() == "daiminkan") {   //if daiminkan => must act
            // legal_check;
            add_accept_reach_or_dora_if_necessary(haiyama, game_record);
           
            game_record.push_back(candidate_moves[actor][0]);
            return;
        }
    }
    for (int pid_add = 1; pid_add <= 1; pid_add++) {
        const int actor = (target + pid_add) % 4;
        if (candidate_moves[actor][0]["type"].string_value() == "chi") {    //if chi, ask
            // legal_check;
            add_accept_reach_or_dora_if_necessary(haiyama, game_record);

            if(actor == 0){ 
                std::string write_buf = "need dahai";
                //make buf 
                for (int i = 0; i < candidate_moves[actor][0]["consumed"].array_items().size(); i++) {
                    write_buf += " " + candidate_moves[actor][0]["consumed"].array_items()[i].string_value();
                }
                write(clnt_sock, write_buf.c_str(), write_buf.size());
                char read_buf[3076];
                std::string read_str;
                int str_len = read(clnt_sock, read_buf, 3076 - 1);
                read_buf[str_len] = 0;
                read_str = read_buf;
                if(read_str == "no"){    //dont chi -> dont use => select none action
                    continue;
                } else {                  //add dahai pai //TODO: read stream
                    game_record.push_back(candidate_moves[actor][0]);
                    game_record.push_back(make_dahai(actor, hai_str_to_int(read_str), false));
                    return;
                }
            }

            for (const json11::Json& action : candidate_moves[actor]) {     //2개가 동시에 나옴 chi, dahai
                game_record.push_back(action);
            }
            return;
        }
    }
    add_accept_reach_or_dora_if_necessary(haiyama, game_record);
    add_tsumo(haiyama, game_record, (target + 1) % 4);  //add tsumo
}

void add_move_after_tsumo(const std::vector<int>& haiyama, Moves& game_record, const std::array<Moves, 4>& candidate_moves, const int clnt_sock) {
    std::cout<<"make after tsumo"<<std::endl;
    assert(game_record[game_record.size()-1]["type"].string_value() == "tsumo");
    const Moves& moves = candidate_moves[game_record[game_record.size()-1]["actor"].int_value()];
    if (moves[0]["type"].string_value() == "hora") {
        const int actor = moves[0]["actor"].int_value();
        const int hai = hai_str_to_int(moves[0]["pai"].string_value());
        const Game_State game_state = get_game_state(game_record);
        // legal_check;
        Hai_Array tehai = game_state.player_state[actor].tehai;
        // dora_count
        tehai[hai]--;
        const Tenpai_Info tenpai_info = cal_tenpai_info(
            game_state.bakaze, game_state.player_state[actor].jikaze, tehai, game_state.player_state[actor].fuuro
        );
        int agari_id = -1;
        int agari_ten = 0;
        int han_add = 0;
        if (game_state.player_state[actor].reach_accepted) {
            han_add++;
            if (is_ippatsu_valid(game_record, actor)) {
                han_add++;
            }
        }
        // ハイテイ、
        tehai[hai]++;
        int dora_num = 0;
        std::vector<int> uradora_marker;
        if (game_state.player_state[actor].reach_accepted) {
            for (int i = 0; i < game_state.dora_marker.size(); i++) {
                uradora_marker.push_back(haiyama[136 - 5 - 2*i]);
            }
        }
        dora_num = count_dora(tehai, game_state.player_state[actor].fuuro, game_state.dora_marker, uradora_marker);

        for (int i = 0; i < tenpai_info.agari_vec.size(); i++) {
            if (haikind(hai) == tenpai_info.agari_vec[i].hai &&
                han_add + tenpai_info.agari_vec[i].han_tsumo > 0
            ) {
                int agari_ten_tmp = tsumo_agari(han_add + tenpai_info.agari_vec[i].han_tsumo + dora_num, tenpai_info.agari_vec[i].fu_tsumo, game_state.player_state[actor].jikaze == 0);
                if (agari_ten_tmp > agari_ten) {
                    agari_ten = agari_ten_tmp;
                    agari_id = i;
                }
            }
        }
        const int han = han_add + tenpai_info.agari_vec[agari_id].han_tsumo + dora_num;
        const int fu = tenpai_info.agari_vec[agari_id].fu_tsumo;
        std::array<int, 4> ten_move = ten_move_hora(
            actor, actor, han, fu, get_oya(game_record), game_state.honba, get_kyotaku(game_record), false
        );
        std::array<int, 4> scores;
        for (int pid = 0; pid < 4; pid++) {
            scores[pid] = game_state.player_state[pid].score + ten_move[pid];
        }
        tehai[hai]--;
        game_record.push_back(make_hora(actor, actor, hai, tehai, han, fu, uradora_marker, scores));
    } else if (moves[0]["type"].string_value() == "ryukyoku" && moves[0]["reason"].string_value() == "kyushukyuhai") {
        const int actor = moves[0]["actor"].int_value();
        const Game_State game_state = get_game_state(game_record);
        std::array<int, 4> scores;
        for (int pid = 0; pid < 4; pid++) {
            scores[pid] = game_state.player_state[pid].score;
        }
        game_record.push_back(make_kyushukyuhai(actor, game_state.player_state[actor].tehai, scores));
    } else {
        for (int i = 0; i < moves.size(); i++) {        //add dahai include ankan , kakan, reach
            if (moves[i]["actor"] == 0) {
                std::cout<<i<<" "<<moves[i].dump()<<std::endl;

                if(moves[i]["type"] == "ankan"){    //if ankan
                    std::vector<int> arr;
                    for(int k=0;k<moves[i]["consumed"].array_items().size();k++){
                        arr.push_back(hai_str_to_int( moves[i]["consumed"].array_items()[k].string_value()));
                    }
                    game_record.push_back(make_ankan(0, arr));  //make ankan action record
                    continue;
                } else if(moves[i]["type"] == "kakan"){ //if kakan
                    std::vector<int> arr;
                    for(int k=0;k<moves[i]["consumed"].array_items().size();k++){
                        arr.push_back(hai_str_to_int( moves[i]["consumed"].array_items()[k].string_value()));
                    }
                    //make kakan action record
                    game_record.push_back(make_kakan(0, hai_str_to_int(moves[i]["pai"].string_value()), arr));
                    continue;
                } else if (moves[i]["type"] == "reach") {   //if reach
                    game_record.push_back(make_reach(0));   //make reach but it also have dahai => request
                    continue;
                }

                Game_State stat = get_game_state(game_record);
                //if player declare reach or accepted => dont ask dahai
                if (stat.player_state[0].reach_accepted == false && stat.player_state[0].reach_declared == false) {
                    std::string buf = "need dahai";
                    std::cout << "send msg to player : " << std::endl;
                    std::cout << buf << std::endl;

                    write(clnt_sock, buf.c_str(), buf.size());
                    char temp[BUF_SIZE];
                    int str_len = read(clnt_sock, temp, BUF_SIZE - 1);
                    temp[str_len] = 0;
                    std::string read_buf = temp;
                    std::cout << read_buf << std::endl;

                    int dahai_value = hai_str_to_int(read_buf); 
                    //make dahai action
                    game_record.push_back(make_dahai(0, dahai_value, true));  //TODO: tsumogiri
                    continue;
                }
            }
            game_record.push_back(moves[i]);
        }
    }
}

void add_move_after_tsumo_or_dahai(const std::vector<int>& haiyama, Moves& game_record, const std::array<Moves, 4>& candidate_moves, const int clnt_sock) {
    const json11::Json& current_move = game_record[game_record.size() - 1];
    if (current_move["type"] == "tsumo") {
        add_move_after_tsumo(haiyama, game_record, candidate_moves, clnt_sock);    //이전 행동이 tsumo 면 dahai 
    } else if (current_move["type"] == "dahai" || current_move["type"] == "kakan") {    
        add_move_after_dahai(haiyama, game_record, candidate_moves, clnt_sock);    //이전 행동이 dahai, kakan이면 tsumo
    } else {
        assert(false);
    }
}

Moves ai_assign(const Moves& game_record, const int player_id) {
    return ai(game_record, player_id, false);        
    //return ai_interface(game_record, player_id);
    //if (player_id == 0 || player_id == 2) {
    //    return ai_interface(game_record, player_id);
    //} else {
    //    return ai_201808(game_record, player_id);
    //}
}

std::array<Moves, 4> require_moves_after_dahai(const Moves& game_record, const int player_id, const json11::Json& request, const int clnt_sock) {
    std::array<std::vector<Moves>, 4> all_legal_moves = get_all_legal_moves(game_record);
    std::array<Moves, 4> result;
    for (int pid = 0; pid < 4; pid++) {
        if (all_legal_moves[pid].size() > 0) {  
            if (pid != player_id && pid != 0) {
                //result[pid] = ai_interface(game_record, pid);
                //result[pid] = ai_tsumogiri(game_record, pid);
                result[pid] = ai_assign(game_record, pid);
            } else if(pid == 0){    //player
                std::vector<Moves> possible_moves;
                //int pid = 0;  //player
                if (all_legal_moves[pid].size() > 0) {      //, ask player
                    std::string write_buf = "{\"action\": [";  //make request legal moves
                    for (int j = 0; j < all_legal_moves[pid].size(); j++) {  //make request buf
                        std::string find_str = all_legal_moves[pid][j][0].dump();
                        find_str[find_str.size() - 1] = ']';
                        find_str[0] = '[';
                        if (write_buf.find(find_str) != -1 && find_str != "")
                            continue;
                        possible_moves.push_back(all_legal_moves[pid][j]);
                        if (write_buf[write_buf.size() - 1] == ']')
                            write_buf += ", ";
                        write_buf += find_str;
                    }
                    write_buf += "], \"type\": \"request\"}";   //ask player 
                    write(clnt_sock, write_buf.c_str(), write_buf.size());
                    char temp[BUF_SIZE];
                    int str_len = read(clnt_sock, temp, BUF_SIZE - 1);
                    temp[str_len] = 0;
                    std::string read_buf;
                    read_buf = temp;
                    int select = stoi(read_buf); //TODO:
                    result[pid] = possible_moves[select - 1];
                }
            }
        } else {
            Moves moves;
            moves.push_back(make_none(pid));
            result[pid] = moves;
        }
    }
    return result;
}

std::array<Moves, 4> require_moves_after_tsumo(const Moves& game_record, const int player_id, const json11::Json& request, const int clnt_sock) {
    std::array<std::vector<Moves>, 4> all_legal_moves = get_all_legal_moves(game_record);
    std::array<Moves, 4> result;
    const int actor = game_record[game_record.size() - 1]["actor"].int_value();
    if (actor != player_id && actor != 0) {
        //result[actor] = ai_interface(game_record, actor);
        //result[actor] = ai_tsumogiri(game_record, actor);
        result[actor] = ai_assign(game_record, actor);
    } else if (actor == 0) {  //player
        std::vector<Moves> possible_moves;
        int request = 0;
        if (all_legal_moves[actor].size() > 0) {    //if have other action after tsumo ask player(reach, hora...)
            std::string write_buf = "{\"action\": [";  //make request legal moves
            for (int j = 0; j < all_legal_moves[actor].size(); j++) {   //make request buf
                if(all_legal_moves[actor][j][0]["type"].string_value() == "dahai"
                    || all_legal_moves[actor][j][0]["type"].string_value() == "tsumo")
                    continue;
                request = 1;
                std::string find_str = all_legal_moves[actor][j][0].dump();
                find_str[find_str.size() - 1] = ']';
                find_str[0] = '[';
                if (write_buf.find(find_str) != -1 && find_str != "")
                    continue;
                possible_moves.push_back(all_legal_moves[actor][j]);
                if (write_buf[write_buf.size() - 1] == ']')
                    write_buf += ", ";
                write_buf += find_str;
                
            }
            
            if (request == 1) { //if have request
                write_buf += "], \"type\": \"request\"}";
                std::cout<<"send msg to player : "<<write_buf<<std::endl;
                write(clnt_sock, write_buf.c_str(), write_buf.size());
                char temp[BUF_SIZE];
                int str_len = read(clnt_sock, temp, BUF_SIZE - 1);
                temp[str_len] = 0;
                std::string read_buf;
                read_buf = temp;
                int select = stoi(read_buf);  //TODO:
                result[actor] = possible_moves[select - 1];
                std::cout<<result[actor][0].dump()<<std::endl;
            } else if (request == 0) {  //if dont have request, save action
                result[actor] = all_legal_moves[actor][0];
            }
        }
    }

    else {
        result[actor].push_back(request);
    }
    return result;
}

std::array<Moves, 4> require_moves_after_tsumo_or_dahai(const Moves& game_record, const int player_id, const json11::Json& request, const int clnt_sock) {
    const json11::Json& current_move = game_record[game_record.size() - 1];
    if (current_move["type"] == "tsumo") {
        return require_moves_after_tsumo(game_record, player_id, request, clnt_sock);
    } else if (current_move["type"] == "dahai" || current_move["type"] == "kakan") {
        return require_moves_after_dahai(game_record, player_id, request, clnt_sock);
    } else {
        assert_with_out(false, "require_moves_after_tsumo_or_dahai error");
        std::array<Moves, 4> result;
        return result;
    }
}



void proceed_game(std::vector<int>& haiyama, Moves& game_record, const int chicha, const int player_id, const json11::Json& request, const int clnt_sock) {
    if (game_record.size() == 0) {
        add_start_game(game_record);
    } else {
        const json11::Json& current_move = game_record[game_record.size() - 1]; //acting last action(move)
        if (player_id == -1) {
            std::cout << game_record.size() - 1 << " " << current_move.dump() << std::endl; //action dump ()
        }
        if (current_move["type"] == "start_game") {
            add_first_kyoku(game_record, haiyama, chicha, request);
            assert_with_out(haiyama.size() == 136, "proceed_game_error: haiyama.size() != 136");

          //  msg->haiyama = haiyama;

        } else if (current_move["type"] == "hora" || current_move["type"] == "ryukyoku") {  //나거나 유국일때
            add_next_kyoku_or_end_game(game_record, haiyama, request);
            assert_with_out(haiyama.size() == 136, "proceed_game_error: haiyama.size() != 136");
        } else if (current_move["type"] == "start_kyoku") { //뽑기(쯔모) <- (시작할때)
            add_tsumo(haiyama, game_record, get_oya(game_record));
        } else if (current_move["type"] == "tsumo" || current_move["type"] == "dahai" || current_move["type"] == "kakan") {
            //tsumo 뽑기 , dahai 버리기, kakan 가깡(퐁이 있는데 쯔모했을 경우)
            if (!request["type"].is_null() && request["type"] != "pass" && !is_legal_single_move(game_record, request)) {
                return;
            }
            std::array<Moves, 4> candidate_moves = require_moves_after_tsumo_or_dahai(game_record, player_id, request, clnt_sock);
            add_move_after_tsumo_or_dahai(haiyama, game_record, candidate_moves, clnt_sock);
        } else if (current_move["type"] == "ankan") {   //안깡  퐁같이
            add_after_ankan(haiyama, game_record, current_move["actor"].int_value());
        } else if (current_move["type"] == "daiminkan") {   //대명깡 패에서
            add_rinshan_tsumo(haiyama, game_record, current_move["actor"].int_value());
        } else if (current_move["type"] == "reach" || current_move["type"] == "chi" || current_move["type"] == "pon") {
            //리치, 치 ,퐁
            assert_with_out(current_move["actor"] == player_id, "game_server_error");   //자신은 안됨
            if (is_legal_dahai_after_reach_or_fuuro(game_record, request)) {
                game_record.push_back(request);
            }
        }
    }
}

void game_loop(std::vector<int>& haiyama, Moves& game_record, const int chicha, const int player_id, const int clnt_sock) {
    //TODO: need socket maybe main

    std::string buf = "";
    std::string read_buf = "";
    int count = 0;
    while (game_record.size() == 0 || game_record.back()["type"] != "end_game") {
        Game_State game_state = get_game_state(game_record);    //tehai print
        std::cout<<"tehai : "<<std::endl;
        for (int pid = 0; pid < 4; pid++) {
            Hai_Array tehai = game_state.player_state[pid].tehai;
            std::cout<<pid<<" : ";
            for(int j = 1;j<38;j++){
                if(tehai[j]>=0&&tehai[j]<=4)
                for(int k =0;k<tehai[j];k++)
                            std::cout << hai_int_to_str(j) << ",";
            }
            std::cout<<std::endl;
        }
        
        
        proceed_game(haiyama, game_record, chicha, player_id, {}, clnt_sock);

        if (clnt_sock != -1) {  //send stream by socket
            for (int i = count; i < game_record.size(); i++) {
                //record는 행동이 끝난다음 생김
                buf = MakeStreamForPlayer(game_record[i]);
                //send record to player client
                std::cout<<"send msg to player : "<<std::endl;
                std::cout<<buf<<std::endl;
                
                write(clnt_sock, buf.c_str(), buf.size());

                game_state = get_game_state(game_record);   //update state by record update //TODO: move tsumo
                const json11::Json& current_move = game_record[i];  //acting last action(move)
                
                    
            }
            count = game_record.size();
        }
    }
}

json11::Json game_server(Moves& game_record, const json11::Json& request) {
    json11::Json::object ret;
    size_t prev_size = game_record.size();
    const int chicha = !request["chicha"].is_null() ? request["chicha"].int_value() : -1;
    const int my_pid = 0;
    std::vector<int> haiyama;
    if (!request["haiyama"].is_null()) {
        for (const auto& hai : request["haiyama"].array_items()) {
            haiyama.push_back(hai_str_to_int(hai.string_value()));
        }
    } else {
        for (int i = int(game_record.size()) - 1; 0 <= i; i--) {
            const json11::Json& action_json = game_record[i];
            if (action_json["type"] == "start_kyoku") {
                assert_with_out(!action_json["haiyama"].is_null(), "game_server_error: haiyama is null");
                for (const auto& hai : action_json["haiyama"].array_items()) {
                    haiyama.push_back(hai_str_to_int(hai.string_value()));
                }
                break;
            }
        }
    }
    
    //proceed_game(haiyama, game_record, chicha, my_pid, request);
    assert_with_out(0 < game_record.size(), "game_server_error: game_record.size() == 0");
    json11::Json::array new_moves;
    for (size_t i = prev_size; i < game_record.size(); i++) {
        new_moves.push_back(game_record[i]);
    }
    ret["new_moves"] = new_moves;

    const json11::Json& last_action = game_record.back();
    if (prev_size < game_record.size()) {
        if (last_action["type"] == "reach" || last_action["type"] == "pon" || last_action["type"] == "chi") {
            assert_with_out(last_action["actor"] == my_pid, "game_server_error: last_action is unexpected"); // プレイヤーのリーチ、副露が受理された場合のみの想定。
            ret["msg_type"] = "update_and_dahai";
        } else {
            const std::vector<Moves> legal_moves = get_all_legal_moves(game_record)[my_pid];
            if (0 < legal_moves.size()) {
                ret["msg_type"] = last_action["type"] == "tsumo" ? "update_and_dahai" : "update_and_fuuro";
                ret["legal_moves"] = legal_moves;
            } else {
                ret["msg_type"] = "update";
            }
        }
    } else {
        // クライアントが合法でないmoveを送信した場合のみの想定
        // assert(0 < get_all_legal_moves(game_record)[player_id].size()); 副露した牌を捨てた場合などは、get_all_legal_movesが0になる。
        if (last_action["type"] == "reach" || last_action["type"] == "pon" || last_action["type"] == "chi" ||
            (last_action["type"] == "tsumo" && last_action["actor"] == my_pid)
        ) {
            ret["msg_type"] = "dahai_again";
        } else {
            ret["msg_type"] = "fuuro_again";
        }
    }
    return json11::Json(ret);
}


//custom
std::string MakeStreamForPlayer(json11::Json record) {  //make stream for sending to player
    json11::Json::object move;
    if (record["type"] == "start_kyoku") {  //setup start state
        move["type"] = "start_kyoku";
        move["bakaze"] = record["bakaze"];
        move["kyoku"] = record["kyoku"];
        move["honba"] = record["honba"];
        move["kyotaku"] = record["kyotaku"];
        move["oya"] = record["oya"];
        move["dora_marker"] = record["dora_marker"];
        move["scores"] = record["scores"];
        move["tehais"] = record["tehais"][0];   //only plyaer
        json11::Json temp(move);
        return temp.dump();
    }
    else if(record["type"] == "tsumo"){ //action tsumo
        move["type"] = "tsumo";
        move["actor"] = record["actor"];
        if (record["actor"] == 0) {   //only player send player's pai
            move["pai"] = record["pai"];
        }   
        json11::Json temp(move);
        return temp.dump();
    } 
    else if (record["type"] == "dahai") {
        move["type"] = "dahai";
        move["actor"] = record["actor"];
        move["pai"] = record["pai"];
        if (record["actor"] == 0) {  //only player send player's tsumogiri
            move["tsumogiri"] = record["tsumogiri"];
        }

        json11::Json temp(move);
        return temp.dump();
    }
    return record.dump();   //pon,chi ,reach, kan...
}