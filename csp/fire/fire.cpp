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
static int car=2;

int a=2;
vector<string> split(string str, char delimiter);   //선호,기피 string list를 vector로 만들어 주는 함수


class fire : public Gecode::IntMaximizeScript{
protected:
    Gecode::IntVar objective;   //선호 점수
    //variable
    IntVarArray agent;
public:
    fire(const Gecode::Options& opt) : Gecode::IntMaximizeScript(opt),agent(*this,8,0,303)//생성자
    {                  //domain은 1~7(9~15)=> 강의 시작시간(최소 3시간 가정), 크기는 강의의 수만큼
        

        // for(int i=0;i<5;i++){
        //     element(accident,agent[0][i]%100-1-1)=ite(agent[0][i]<100&&element(accident,agent[0][i]%100-1-1)==1,0,1);
        // }
        
        objective=expr(*this,9*3600);

        for(int i=0;i<8;i++){
            for(int j=0;j<8;j++){
                if(i!=j)
                    rel(*this,!((agent[i]<100&&agent[i]>0)&&(agent[j]<100&&agent[j]>0)&&agent[i]==agent[j]));
            }
        }

        
        IntVar temp=expr(*this,0);
        for(int i=0;i<8;i++){
            rel(*this,!((agent[i]<100)&&((agent[i]<2&&agent[i]>0)||agent[i]>3)));
            rel(*this,agent[i]!=100);
            rel(*this,agent[0]/100==1);

            if(i>0){
                rel(*this,!((agent[i]>100)&&(agent[i]/100!=agent[i-1]%100)));
                rel(*this,!((agent[i]<100&&agent[i]>0)&&(agent[i]!=agent[i-1]%100)));
                
            }

            rel(*this,(agent[i]%100>=1&&agent[i]%100<=3)||agent[i]==0);
            
            rel(*this,!(agent[i]>100&&((agent[i]/100<1||agent[i]/100>3))));

            rel(*this,!(agent[i]>100&&agent[i]/100==agent[i]%100));

            temp=expr(*this,temp+ite(agent[i]<100&&agent[i]>0,1,0));

            if(i>0){
                
                rel(*this,!((temp==2&&(agent[i-1]==0||agent[i-1]%100==1))&&agent[i]!=0));
                //agent[i]=expr(*this,ite((temp==2)&&(agent[i-1]==0||agent[i-1]%100==1),0,agent[i]));
            }

        }


        for(int i=0;i<8;i++){
            if(i==7){
                rel(*this,agent[i]==0||agent[i]%100==1);
            }
            else{
                rel(*this,!((agent[i]!=0&&agent[i+1]==0)&&(agent[i]%100!=1)));
            }
        }
        rel(*this,temp==2);
        // rel(*this,agent[1]==2);
        // rel(*this,agent[3]==3);
        // rel(*this,agent[4]%100==1);
        //rel(*this,agent[5]==0);
        //rel(*this,agent[7]==0);

        for(int i=0;i<8;i++){

        }



        
        branch(*this,agent,INT_VAR_SIZE_MIN(),INT_VAL_MIN()); 


        
        
        
    }

    fire(fire& v) : Gecode::IntMaximizeScript(v) {
        // for(int i=0;i<car;i++){
        //     agent[0].update(*this,v.agent[0]);
        // }
        // cout<<"hi : v"<<endl;
        // cout<<v.agent[0]<<endl;

        // agent=new IntVarArray[car];
        // for(int i=0;i<car;i++){
        //     agent[i]= IntVarArray(*this,10,0,4);
        //     for(int j=0;j<10;j++){
        //         agent[i][j]=v.agent[i][j];
        //     }
        //     cout<<endl<<"hello : new"<<endl<<agent[i]<<endl;
        //     //agent[i](v.agent[i]);
        // }
            //agent[0].update(*this,v.agent[0]);
        agent.update(*this,v.agent);
        // temp.update(*this,v.temp);
        // v.temp[1]=expr(*this,1);
        // cout<<"hi : o"<<endl<<temp<<endl;

        // cout<<"hello : v"<<endl<<v.temp<<endl;
    }

    virtual Space* copy(void) {
        return new fire(*this);
    }

    virtual Gecode::IntVar cost(void) const {

        return objective;
    }

    void print(std::ostream& os) const {
        //os<<temp<<endl;
        // for(int i=0;i<car;i++){
        //     os<<agent[i]<<endl;
        // }  
        //os<<temp<<endl;
        os<<agent<<endl;
    }
};

int main(int argc, char* argv[]) {
     ifstream fs;
    string s="data.csv";
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
                scenes.push_back(temp2);

                max++;
                getline(fs,temp);
            }
        }
        else if(temp=="Distance Matrix"){
            getline(fs,temp);
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
                    cout<<temp2<<" ";
                    temp3.push_back(stoi(temp2));
                    com=com2;
                }
                matrix.push_back(temp3);
                cout<<endl;
                getline(fs,temp);
                if(fs.eof()){
                    break;
                }
             }

        }
        
    }

    fs.close();
   
    Gecode::Options opt("");
    opt.time(-1);
    opt.solutions(0);
    opt.threads(5);
    opt.interrupt(false);
    opt.parse(argc, argv);
    opt.mode(Gecode::SM_GIST);

    Gecode::Script::run<fire, Gecode::DFS, Gecode::Options>(opt);  //DFS=>BAB(branch and bound)(분기한정 -> 백트래킹)

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