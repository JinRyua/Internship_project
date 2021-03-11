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
vector<int> firestation; 
vector<vector<int>> scenes;    
vector<vector<int>> matrix;
static int car=3;
static int scene=30;
int temp=0;

int a=2;
vector<string> split(string str, char delimiter);   //선호,기피 string list를 vector로 만들어 주는 함수


class fire : public Gecode::IntMaximizeScript{
protected:
    Gecode::IntVar objective;   //선호 점수
    IntVar hour,min,sec;
    IntVar time;
    //variable
    IntVarArray agent;
    IntVar spot; 
    IntVar idx_i;
        

public:
    fire(const Gecode::Options& opt) : Gecode::IntMaximizeScript(opt),agent(*this,matrix.size(),1,matrix.size())
    ,idx_i(*this,0,0),time(*this,13*3600,13*3600),spot(*this,0,0)
    //,temp(*this,3,2,4)//생성자
    {       
        distinct(*this,agent);

        time=expr(*this,9*3600);
        idx_i=expr(*this,0);
        for(int i=0;i<matrix.size();i++){
            idx_i=expr(*this,ite(agent[i]==1,i,idx_i));
        } 
        cout<<idx_i<<endl;
        for(int i=0;i<matrix.size();i++){
            for(int j=0;j<matrix.size();j++){
                if(i==0){
                    time=expr(*this,time+ite(i<=idx_i&&(agent[i]==j+1),scenes[0][j],0));
                }
                else if(i>0){
                    for(int k=0;k<matrix.size();k++){
                        if(j!=k){
                            time=expr(*this,time+ite(i<=idx_i&&(agent[i]==k+1)&&(agent[i-1]==j+1),matrix[j][k],0));
                        }
                    }
                }
            }
            time=expr(*this,time+ite(i<=idx_i&&agent[i]!=1,19*60,0));
        }
        spot=expr(*this,idx_i);
        objective=expr(*this,spot*18*3600-time);
        rel(*this,time<=18*3600);

        
        branch(*this,agent,INT_VAR_SIZE_MIN(),INT_VAL_MIN());
   
        
    }

    fire(fire& v) : Gecode::IntMaximizeScript(v) {
        
        agent.update(*this,v.agent);
        idx_i.update(*this,v.idx_i);
        spot.update(*this,v.spot);

        objective.update(*this,v.objective);
        // // hour.update(*this,v.hour);
        // // min.update(*this,v.min);
        // // sec.update(*this,v.sec);
        time.update(*this,v.time);
        //  

    }

    virtual Space* copy(void) {
        return new fire(*this);
    }

    virtual Gecode::IntVar cost(void) const {

        return objective;
    }

    void print(std::ostream& os) const {


        os<<agent<<" "<<idx_i<<" "<<endl;
        os<<spot<<" ";
        os<<time<<" ";
        os<<objective<<endl;
        

    }

};

int main(int argc, char* argv[]) {
     ifstream fs;
    string s="data2.csv";
    string temp;
    fs.open(s,ios::in);
    int max=0;
    while(!fs.eof())
    {
        getline(fs,temp);
        int com=temp.find(",");
        temp=temp.substr(0,com);
        cout<<endl<<temp<<endl;
        if(temp=="Station"){
            getline(fs,temp);
            int a=0;
            getline(fs,temp);
            while(temp[0]!=','&&!fs.eof()){
                com=temp.find(",");
                temp=temp.substr(0,com);
                firestation.push_back(a);
                a++;
                cout<<temp<<endl;
                max++;
                getline(fs,temp);
            }
        }
        else if(temp=="Fire Scenes"){
            vector<int> temp2;
            getline(fs,temp);
            getline(fs,temp);
            com=0;
            while(temp[0]!=','&&!fs.eof()){
                temp2.clear();
                com=temp.find(",");
                int com2=temp.find(",",com+1);
                string temp3=temp.substr(com+1,com2-com-1);
                com=com2;
                temp2.push_back(stoi(temp3)*60);
                cout<<temp<<endl<<stoi(temp3)*60<<" ";
                
                com2=temp.find(":",com+1);

                if(com2!=-1){
                temp3=temp.substr(com+1,com2-com-1);
                int temp4=0;
                temp4=stoi(temp3)*3600;

                com=com2;
                com2=temp.find(":",com+1);
                temp3=temp.substr(com+1,com2-com-1);
                temp4=temp4+stoi(temp3)*60;

                com=com2;
                com2=temp.find(",",com+1);
                temp3=temp.substr(com+1,com2-com-1);
                temp4=temp4+stoi(temp3);
                
                temp2.push_back(temp4);
                cout<<temp4<<endl;
                }
                if(max<=scene){
                    scenes.push_back(temp2);
                    max++;
                }
                getline(fs,temp);
            }
        }
        else if(temp=="Distance Matrix"){
            getline(fs,temp);
            cout<<"max:"<<max<<endl;
            int count=0;
             while(temp[0]!=','&&!fs.eof()){
                
                int com=0;
                vector<int> temp3;
                temp3.clear();
                for(int i=0;i<max;i++){
                    com=temp.find(",",com);
                    int com2=temp.find(",",com+1);
                    string temp2=temp.substr(com+1,com2-com-1);
                    if(i==max-1)
                        temp2=temp.substr(com+1);
                    
                    if(i<max){
                        if(i!=0)
                            temp3.push_back(stoi(temp2)/27);//+scenes[i-1][0]);
                        else
                            temp3.push_back(stoi(temp2)/27);
                    }
                    com=com2;
                    
                }
                if(count<max)
                    matrix.push_back(temp3);
                count++;
                cout<<endl;
                getline(fs,temp);
                if(fs.eof()){
                    break;
                }
             }

        }   
        else if(temp=="Fire Cars"){
            getline(fs,temp);
            while(temp[0]!=','&&!fs.eof()){
                getline(fs,temp);
            }
        }
    }
    // for(int i=0;i<matrix.size();i++){
    //     for(int j=0;j<matrix.size();j++){
    //         cout<<matrix[i][j]<<" ";
    //     }
    //     cout<<endl;
    // }

    fs.close();
   
    Gecode::Options opt("");
    opt.time(30000);
    opt.solutions(0);
    opt.threads(5);
    opt.interrupt(false);
    opt.parse(argc, argv);
    //opt.mode(Gecode::SM_GIST);

    Gecode::Script::run<fire, Gecode::BAB, Gecode::Options>(opt);  //DFS=>BAB(branch and bound)(분기한정 -> 백트래킹)

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