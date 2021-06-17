
#include <string>
#include <vector>
#include "boost/serialization/serialization.hpp"
#include "boost/serialization/utility.hpp"
#include "boost/archive/text_oarchive.hpp"
#include "boost/archive/text_iarchive.hpp"

#ifndef CUSTOM_TYPES
#define CUSTOM_TYPES

// std::ostringstream oss;
// boost::archive::text_oarchive oa(oss);
// oa << game_state;
// cout << oss.str() << endl;
// std::istringstream iss(oss.str());
// //text_iarchive 생성 시 역직렬화를 위한 입력 데이터 스트림 지정
// boost::archive::text_iarchive ia(iss);

// //text_iarchive >> 연산자를 이용해 역직렬화를 통한 객체 생성
// ia >> game_state;
namespace Custom
{
     class Fuuro_Elem_ {  //pon, kan, chi
       public:
        int type;
        int hai;    //가져온 패
        std::vector<int> consumed;
        int target_relative;  

        Fuuro_Elem_(){};

        friend class boost::serialization::access;
        
        template<typename Archive>
        void serialize(Archive& ar, const unsigned int version){
            ar& type;
            ar& hai;
            ar& consumed;
            ar& target_relative;
        }
    };

    class state{
        public:
        std::vector<std::vector<Fuuro_Elem_>> Fuuro;
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
        void serialize(Archive& ar, const unsigned int version){
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

    class buffer{  //buffer information
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

    struct end_info{
        int turns;
        std::string winner;    
    };

    class Queue_state{
        public:
        state game_state;
        int possible;
        int result_num;

        friend class boost::serialization::access;

        template <typename Archive>
        void serialize(Archive& ar, const unsigned int version) {
            ar& game_state;
            ar& possible;
            ar& result_num;
        }
    };
}   //close namespace

#endif