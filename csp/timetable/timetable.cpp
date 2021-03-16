#include <gecode/int.hh>
#include <gecode/minimodel.hh>
#include <gecode/search.hh>
#include <gecode/gist.hh>
#include <gecode/driver.hh>
#include <algorithm>
#include <vector>
#include <map>
#include <string>
#include <fstream>
#include <sstream>

using namespace Gecode;
using namespace std;

//const 값들
vector<vector<string>> class_;  //강의
vector<vector<string>> room;    //강의실
vector<vector<string>> professor;   //교수
vector<vector<int>> favorite;   //교수 선호
vector<vector<int>> hate;   //교수 기피
vector<int> prof_num;   //각 강의의 교수

vector<string> split(string str, char delimiter);   //선호,기피 string list를 vector로 만들어 주는 함수


class timetable : public Gecode::IntMaximizeScript{
protected:
    Gecode::IntVar objective;   //선호 점수
    //variable
    IntVarArray l;  //각 강의의 시간,요일,강의실의 값
    IntVarArray time;   //강의의 시간 
    IntVarArray day;    //강의의 요일
    IntVarArray room_num;   //강의의 강의실
public:
    timetable(const Gecode::Options& opt) : Gecode::IntMaximizeScript(opt), //생성자
    l(*this,class_.size(),1,7),                     //domain은 time,day,room_num으로 만들어지므로 의미 없으며 크기는 강의의 수만큼 
    room_num(*this,class_.size(),1,room.size()),    //domain은 1~강의실 개수, 크기는 강의의 수만큼
    day(*this,class_.size(),1,5),                   //domain은 1~5(월~금), 크기는 강의의 수만큼
    time(*this,class_.size(),1,7){                  //domain은 1~7(9~15)=> 강의 시작시간(최소 3시간 가정), 크기는 강의의 수만큼
        
        objective=expr(*this,0);                    //cost 초기화

        for(int i=0;i<class_.size();i++){           //l값 초기화
            l[i]=expr(*this,time[i]+day[i]*10+room_num[i]*100); //[1~99][1~5][1~7]=> (강의실 번호)(요일)(시간) 총 4자리
        }
        
        distinct(*this,l);  //l의 값은 모두 달라야함
        

        for(int i=0;i<class_.size();i++){
            rel(*this,stoi(class_[i][5])+time[i]<=10); //9~18   강의 시간과 강의 시작시간의 합은 18시를 넘어서면 안됨

            for(int j=0;j<class_.size();j++){
                if(i!=j){
                    rel(*this,!(((room_num[i]==room_num[j]))&&  //강의실이 같으면 안됨
                        ((day[i]==day[j])   //같은날
                        &&((time[i]>=time[j])&&(time[i]<time[j]+stoi(class_[i][5])))) ));   //같은 날,시간(동시)일때
                    
                    if(prof_num[i]==prof_num[j]){   //같은 교수면 안됨
                        rel(*this,!((day[i]==day[j])&&  //같은날
                        ((time[i]>=time[j])&&(time[i]<time[j]+stoi(class_[i][5])))) );  //같은 날,시간(동시)일때
                    }               
                    if((class_[i][2]==class_[j][2]) //같은 학년의 과목 또는
                    ||(class_[i][4]=="전공필수"&&class_[j][4]=="전공필수")){    //전필 과목끼리는
                        rel(*this,!((day[i]==day[j])&&((time[i]>=time[j])&&(time[i]<time[j]+stoi(class_[i][5]))))); //동시에 위치할 수 없음
                    }

                    // if((stoi(class_[i][5])+stoi(class_[j][5])>6)&&(prof_num[i]==prof_num[j])){    //수업 시간이 6시간 초과일때    //수정필요
                    //     rel(*this,!((day[i]==day[j]));   //같은날 같은 교수이면 안됨
                    // }
                }
                rel(*this,!(time[i]<=4&&time[i]+stoi(class_[i][5])>=5)  //점심시간에는 있을 수 없음, => 시작 시간이 12시보다 작거나 같고, 끝시간이 1시보다 크거나 같으면 겹침
                ||(time[i]==1)&&(stoi(class_[i][5])+time[i]>3));        //예외로 4시간 짜리는 9시에 위치 가능
            }
            
        }

        //수업 시간이 6시간 초과일때
        for(int i=0;i<professor.size();i++){    //교수마다
            for(int j=1;j<=5;j++){              // 각 요일에
                IntVar temp_time=expr(*this,0);
                for(int k=0;k<class_.size();k++){     
                    const IntVar temp_prof_num=expr(*this,prof_num[k]); 
                    temp_time=expr(*this,temp_time+ite((day[k]==j)&&//각 요일에 있는
                    (temp_prof_num==i),stoi(class_[k][5]),0));  //자신의 수업의 합이
                }

                rel(*this,!(temp_time>6));      //6시간을 초과하면 안됨
            }
        }

        //기피 시간(hard constraint)
        for(int i=0;i<professor.size();i++){    //교수마다
            for(int j=0;j<hate[i].size();j++){  //교수의 기피 요일,시간마다
                if(hate[i][j]!=0){              //있으면
                    if(hate[i][j]%10==0){       //요일 전체일 때,
                        for(int k=0;k<class_.size();k++){
                            if(prof_num[k]==i)      //그 교수의 수업이
                                rel(*this,!(day[k]==hate[i][j]/10));    //기피요일이라면 안됨
                        }
                    }else{
                        for(int k=0;k<class_.size();k++){   //특정 시간일 때,
                            if(prof_num[k]==i)
                                rel(*this,!((day[k]*10)+time[k]==hate[i][j]));//기피 요일,시간이면 안됨
                        }
                    }
                }
                else break;
            }
        }
        
        //rel
        // for(int i=0;i<professor.size();i++){
        //     IntVarArray temp(*this,5,0,0);
        //     cout<<i<<" : ";
        //     for(int j=0;j<class_.size();j++){
        //         if(prof_num[j]==i){
        //             int day_temp=day[j].val();
        //             temp[day_temp]=expr(*this,temp[day_temp]+stoi(class_[j][5]));
        //         }
        //     }
        //     for(int j=0;j<5;j++){
        //         cout<<temp[j]<<" ";
        //     }
        //     cout<<endl;

        // }

        // cost 계산
        // string temp;
        // for(int i=0;i<class_.size();i++){
        //     IntVarArray temp2(*this,favorite.size());
        //     for(int j=0;j<favorite.size();j++){

        //     }
        //     temp=professor[prof_num[i]][3];

        // }

        //선호도(soft constraint)
        for(int i=0;i<class_.size();i++){       //각 수업마다
            IntVar time_temp=expr(*this,time[i]);   //수업의 시간
            IntVar day_temp=expr(*this,day[i]);     //수업의 요일
            for(int j=0;j<favorite[prof_num[i]].size();j++){    //수업의 교수의 선호 요일,시간에

                if(favorite[prof_num[i]][j]%10==0){ //요일 전체
                    objective=expr(*this,objective+ite(day[i]==favorite[prof_num[i]][j]/10//선호 요일에 있으면 선호도
                    ,stoi(professor[prof_num[i]][4]),0)); //(연차만큼)
                }
                else{                               //특정 시간
                    objective=expr(*this,objective+ite((day[i]*10)+time[i]==favorite[prof_num[i]][j]    //선호 시간,요일에 있으면
                    ,stoi(professor[prof_num[i]][4]),0));    //선호도(연차만큼)
                }
            }
        }

        
        //test
        //rel(*this,day[0]==day[7]); //같은 날 같은 교수가 6시간 초과해서 수업하면 안되는 test
        //rel(*this,time[2]==time[3]&&day[2]==day[3]);    //같은 학년 같은 시간 x test
        //rel(*this,time[0]==time[1]&&day[0]==day[1]);
        //rel(*this,time[2]==1);

        //브렌치
        branch(*this,l,INT_VAR_SIZE_MIN(),INT_VAL_MIN());       
        //branch(*this,day,INT_VAR_SIZE_MIN(),INT_VAL_MIN());
        //branch(*this,room_num,INT_VAR_SIZE_MIN(),INT_VAL_MIN());
        //branch(*this,time,INT_VAR_SIZE_MIN(),INT_VAL_MIN());
        
        
        
    }

    timetable(timetable& v) : Gecode::IntMaximizeScript(v) {
        l.update(*this,v.l);

        time.update(*this,v.time);
        day.update(*this,v.day);
        objective.update(*this,v.objective);
        room_num.update(*this,v.room_num);
    }

    virtual Space* copy(void) {
        return new timetable(*this);
    }

    virtual Gecode::IntVar cost(void) const {

        return objective;
    }

    void print(std::ostream& os) const {
        os<<l<<endl<<objective<<endl;
        // for(int i=0;i<class_.size();i++){
        //     os<<" "<<i+1<<" : "<<day[i]<<time[i]<<room_num[i]<<" ~ "<<class_[i][5]<<endl;
        // }        
    }
};

int main(int argc, char* argv[]) {
    ifstream fs;
    //교수, 강의, 강의실 순서대로 읽음
    string s[3]={"data.csv","Class_data.csv","room_data.csv"};
    //fs.open("~/jylee/csp/timetable/professor_data.csv",ios::in);
    for(int i=0;i<3;i++){
        fs.open(s[i],ios::in);
        if(fs.is_open()){
            string temp;
            getline(fs,temp);
            while(!fs.eof())
            {
                vector<string> temp2;
                temp2.clear();
                if(i==0){
                    for(int j=0;j<5;j++){
                        if(j!=4) getline(fs,temp,',');
                        else getline(fs,temp);
                        temp2.push_back(temp);
                    }
                    professor.push_back(temp2);
                }
                else if(i==1){
                    for(int j=0;j<6;j++){
                        if(j!=5) getline(fs,temp,',');
                        else getline(fs,temp);
                        temp2.push_back(temp);
                    }
                    class_.push_back(temp2);
                }
                else{
                    getline(fs,temp);
                    temp2.push_back(temp);
                    room.push_back(temp2);
                }
                
            }
        }
        fs.close();
        
    }


    //선호, 기피 요일,시간 
    //요일만 있다면 (요일)*10, 시간도 있다면 (요일)*10+시간
    for(int i=0;i<professor.size();i++){
        vector<string> temp=split(professor[i][3],' ');
        vector<int> temp2;
        
         cout<<i<<" : ";
         for(int j=0;j<temp.size();j++){
             string temp4=temp[j].substr(0,3);
             cout<<temp[j]<<" ";
             int temp3=0;
            if(temp4=="월")
                temp3=10;
            else if(temp4=="화")
                temp3=20;
            else if(temp4=="수")
                temp3=30;
            else if(temp4=="목")
                temp3=40;
            else if(temp4=="금")
                temp3=50;

            if(temp[j].length()>3){
                temp[j]=temp[j].substr(3);
                temp3=temp3+(stoi(temp[j])-8);
            }
            temp2.push_back(temp3);
            cout<<temp3<<" ";
        }
        favorite.push_back(temp2);
        cout<<endl;
         
    }

    for(int i=0;i<professor.size();i++){
        vector<string> temp=split(professor[i][2],' ');
        vector<int> temp2;
        
         cout<<i<<" : ";
         for(int j=0;j<temp.size();j++){
             string temp4=temp[j].substr(0,3);
             cout<<temp[j]<<" ";
             int temp3=0;
            if(temp4=="월")
                temp3=10;
            else if(temp4=="화")
                temp3=20;
            else if(temp4=="수")
                temp3=30;
            else if(temp4=="목")
                temp3=40;
            else if(temp4=="금")
                temp3=50;

            if(temp[j].length()>3){
                temp[j]=temp[j].substr(3);
                temp3=temp3+(stoi(temp[j])-8);
            }
            temp2.push_back(temp3);
            cout<<temp3<<" ";
        }
        hate.push_back(temp2);
        cout<<endl;
         
    }

    cout<<class_.size();
    for(int i=0;i<class_.size();i++){               //수업의 교수 넘버
        for(int j=0;j<professor.size();j++){
            if(class_[i][3]==professor[j][1]){
                prof_num.push_back(j);
                break;
            }
        }
        cout<<i+1<<" : "<<prof_num[i]<<endl;
    }


    //읽은 데이터 출력
    for(int i=0;i<professor.size();i++){
        cout<<professor[i][0]<<" "<<professor[i][1]<<" "<<professor[i][2]<<" "
        <<professor[i][3]<<" "<<professor[i][4]<<endl;
    }for(int i=0;i<class_.size();i++){
        cout<<class_[i][0]<<" "<<class_[i][1]<<" "<<class_[i][2]<<" "
        <<class_[i][3]<<" "<<class_[i][4]<<" "<<class_[i][5]<<endl;
    }
    for(int i=0;i<room.size();i++){
        cout<<room[i][0]<<endl;
    }


    Gecode::Options opt("");
    opt.time(-1);
    opt.solutions(0);
    opt.threads(5);
    opt.interrupt(false);
    opt.parse(argc, argv);
    //opt.mode(Gecode::SM_GIST);

    Gecode::Script::run<timetable, Gecode::BAB, Gecode::Options>(opt);  //DFS=>BAB(branch and bound)(분기한정 -> 백트래킹)

    return 0;
}

vector<string> split(string input, char delimiter) {
    vector<string> answer;
    stringstream ss(input);
    string temp;
 
    while (getline(ss, temp, delimiter)) {
        answer.push_back(temp);
    }
 
    return answer;
}