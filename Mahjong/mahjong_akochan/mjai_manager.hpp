#pragma once

#include "share/include.hpp"
#include "share/types.hpp"
#include "share/agari_ten.hpp"
#include "share/calc_shanten.hpp"
#include "share/make_move.hpp"
#include "import.hpp"

class Game_Settings {
    public:
    Game_Settings();
    int chicha;
    int player_id;
};

enum Game_Phase {
    GP_AI,
    GP_PLAYER,
    GP_END,
};

struct state_msg{
    std::vector<int> haiyama;
    Game_State game_state;
    int player_id;
    int chicha;
};

Moves get_masked_log(Moves game_record, const int pid);

void seed_mt19937(int i);

void add_start_game(Moves& game_record);
void prepare_haiyama(std::vector<int>& haiyama);
std::array<std::array<int, 13>, 4> get_haipai(const std::vector<int>& haiyama, const int oya);
void add_first_kyoku(Moves& game_record, std::vector<int>& haiyama, const int chicha, const json11::Json& request);
void add_next_kyoku_or_end_game(Moves& game_record, std::vector<int>& haiyama, const json11::Json& request);

void add_tsumo(const std::vector<int>& haiyama, Moves& game_record, const int pid);
void add_rinshan_tsumo(const std::vector<int>& haiyama, Moves& game_record, const int pid);
void add_after_ankan(const std::vector<int>& haiyama, Moves& game_record, const int pid);
void add_accept_reach_or_dora_if_necessary(const std::vector<int>& haiyama, Moves& game_record);
void add_ryukyoku_fanpai(Moves& game_record);

void add_move_after_dahai(const std::vector<int>& haiyama, Moves& game_record, const std::array<Moves, 4>& candidate_moves, const int clnt_sock);
void add_move_after_tsumo(const std::vector<int>& haiyama, Moves& game_record, const std::array<Moves, 4>& candidate_moves, const int clnt_sock);
void add_move_after_tsumo_or_dahai(const std::vector<int>& haiyama, Moves& game_record, const std::array<Moves, 4>& candidate_moves, const int clnt_sock);

Moves ai_assign(const Moves& game_record, const int player_id);
std::array<Moves, 4> require_moves_after_tsumo(const Moves& game_record, const int player_id, const json11::Json& request, const int clnt_sock);
std::array<Moves, 4> require_moves_after_dahai(const Moves& game_record, const int player_id, const json11::Json& request, const int clnt_sock);
std::array<Moves, 4> require_moves_after_tsumo_or_dahai(const Moves& game_record, const int player_id, const json11::Json& request, const int clnt_sock);

void proceed_game(std::vector<int>& haiyama, Moves& game_record, const int chicha, const int player_id, const json11::Json& request, const int clnt_sock);
void game_loop(std::vector<int>& haiyama, Moves& game_record, const int chicha, const int player_id, const int clnt_sock);

json11::Json game_server(Moves& game_record, const json11::Json& request);

//custom
std::string MakeStreamForPlayer(json11::Json record); //make stream for sending to player
