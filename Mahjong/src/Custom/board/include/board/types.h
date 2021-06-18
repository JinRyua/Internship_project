
#include <string>
#include <vector>
#include "boost/serialization/serialization.hpp"
#include "boost/serialization/utility.hpp"
#include "boost/archive/text_oarchive.hpp"
#include "boost/archive/text_iarchive.hpp"

#ifndef CUSTOM_TYPES
#define CUSTOM_TYPES


namespace Custom
{
     class Fuuro_Elem_ {  //pon, kan, chi
       public:
        int type;   //운 타입
        int hai;    //가져온 패
        std::vector<int> consumed;  //운 패들
        int target_relative;   //actor, target relative

        Fuuro_Elem_(){};

        friend class boost::serialization::access;
        
        template<typename Archive>
        void serialize(Archive& ar, const unsigned int version){    //직렬화 역직렬화
            ar& type;
            ar& hai;
            ar& consumed;
            ar& target_relative;
        }
    };

    class state{
        public:
        std::vector<std::vector<Fuuro_Elem_>> Fuuro;    //pon,chi... 상태
        std::vector<int> haipai;   //안나온 패    
        std::vector<std::vector<int>> tehai;    //손패  37가지 1~37 [4][38]
        int recent_dahai;   //최근 버림패
        std::vector<std::vector<int>> dahai;    //버림패        [4][~]
        std::vector<std::vector<int>> chi;    //버림패
        std::vector<int> score;    //점수
        std::vector<int> dora_marker;   //도라 표시패
        std::vector<int> dahai_order;   // actor * 100 + actor's dahai order
        std::string bakaze;     //바람(동풍)
        std::vector<std::pair<bool,int>> reach; //accepted, dahai order
        int honba;      //본장
        int kyoku;      //국
        int kyotaku;    //남은 스틱
        int oya;        //오야 번호(0~3)
        int actor;      //최근 actor
        int turn;       //남은 뽑기 패
        int tsumo;      //최근 들어온 패

        friend class boost::serialization::access;
        
        template<typename Archive>
        void serialize(Archive& ar, const unsigned int version){    //직렬화 역직렬화
            ar& Fuuro;
            ar& haipai;
            ar& tehai;
            ar& recent_dahai;
            ar& dahai;
            ar& chi;
            ar& score;
            ar& dora_marker;
            ar& dahai_order;
            ar& bakaze;
            ar& reach;
            ar& honba;
            ar& kyoku;
            ar& kyotaku;
            ar& oya;
            ar& actor;
            ar& turn;
            ar& tsumo;
        }

    };

    class buffer{  //buffer information => 용도는 state와 같음
       public:
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
        std::vector<bool> reach_accepted;
        
    };

    struct end_info{    //not use
        int turns;
        std::string winner;    
    };

    class Queue_state{  //queue에 저장하는 일 클래스
        public:
        state game_state;   //게임 상태
        int possible;       //시뮬레이션할 행동
        int result_num;     //result_vector에 들어갈 위ㅎ치

        friend class boost::serialization::access;

        template <typename Archive> //직렬화, 역직렬화
        void serialize(Archive& ar, const unsigned int version) {
            ar& game_state;
            ar& possible;
            ar& result_num;
        }
    };
}   //close namespace

#endif