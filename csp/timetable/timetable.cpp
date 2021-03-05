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
vector<vector<string>> class_;  //const
vector<vector<string>> room;
vector<vector<string>> professor;

static const int size=3;
static const int number=15;
class timetable : public Gecode::IntMinimizeScript {
protected:
    Gecode::IntVar objective;
    IntVarArray l;  //variable
    IntVarArray prof_num;   //const 옮기는게 나을듯
    IntVarArray time;   //variable
    IntVarArray day;
    IntVarArray room_num;
public:
    timetable(const Gecode::Options& opt) : Gecode::IntMinimizeScript(opt),
    l(*this,class_.size(),1,7),room_num(*this,class_.size(),1,room.size()),
    day(*this,class_.size(),1,5),prof_num(*this,class_.size(),1,professor.size())
    ,time(*this,class_.size(),1,7){
        for(int i=0;i<class_.size();i++){
            l[i]=expr(*this,time[i]+room_num[i]*100+day[i]*10);
        }
        
        distinct(*this,l);

        for(int i=0;i<class_.size();i++){               //수업의 교수 넘버
            for(int j=0;j<professor.size();j++){
                if(class_[i][3]==professor[j][1]){
                    prof_num[i]=expr(*this,j);
                }
            }
            cout<<i+1<<" : "<<prof_num[i]<<endl;
        }

        for(int i=0;i<class_.size();i++){
            rel(*this,stoi(class_[i][5])+time[i]<=10); //9~18
            for(int j=0;j<class_.size();j++){
                if(i!=j){//(prof_num[i]==prof_num[j])||(room_num[i]!=room_num[j]))
                    rel(*this,!( ((prof_num[i]==prof_num[j])||(room_num[i]==room_num[j]))&& //같은교수 or 강의실 x
                        ((day[i]==day[j])&&((time[i]>=time[j])&&(time[i]<time[j]+stoi(class_[i][5])))) ));  //같은날 같은 시간(동시)일때
                    
                    if((class_[i][4]=="전공필수"&&class_[j][4]=="전공필수")){
                        rel(*this,!((day[i]==day[j])&&((time[i]>=time[j])&&(time[i]<time[j]+stoi(class_[i][5])))));
                    }
                }
                rel(*this,!(time[i]<=4&&time[i]+stoi(class_[i][5])>=5)  //점심시간
                ||(time[i]==1)&&(stoi(class_[i][5])+time[i]>3));
            }
            
        }
        //rel(*this,time[0]==time[1]&&day[0]==day[1]);
        
        branch(*this,l,INT_VAR_SIZE_MIN(),INT_VAL_MIN());
        //branch(*this,day,INT_VAR_SIZE_MIN(),INT_VAL_MIN());
        //branch(*this,time,INT_VAR_SIZE_MIN(),INT_VAL_MIN());
        //branch(*this,room_num,INT_VAR_SIZE_MIN(),INT_VAL_MIN());
    }

    timetable(timetable& v) : Gecode::IntMinimizeScript(v) {
        l.update(*this,v.l);
        //day.update(*this,v.day);
        //time.update(*this,v.time);
        //room_num.update(*this,v.room_num);
    }

    virtual Space* copy(void) {
        return new timetable(*this);
    }

    virtual Gecode::IntVar cost(void) const {
        return objective;
    }

    void print(std::ostream& os) const {
        // for(int i=0;i<class_.size();i++){
        //     os<<class_[i][1]<<" : ";
        //     if(element(*this,l[i],)/100%100==0){

        //     }
            
        // }
        for(int i=0;i<class_.size();i++){
            os<<" "<<i+1<<" : "<<day[i]<<time[i]<<room_num[i]<<" ~ "<<class_[i][5]<<endl;
        }        
    }
};

int main(int argc, char* argv[]) {
    ifstream fs;
    string s[3]={"professor_data.csv","class_data.csv","room_data.csv"};
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
    opt.mode(Gecode::SM_GIST);

    Gecode::Script::run<timetable, Gecode::DFS, Gecode::Options>(opt);

    return 0;
}
