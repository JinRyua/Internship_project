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
static int scene=100;


int a=2;
vector<string> split(string str, char delimiter);   //선호,기피 string list를 vector로 만들어 주는 함수


class fire : public Gecode::IntMinimizeScript{
protected:
    Gecode::IntVar objective;   //선호 점수
    IntVar hour,min,sec;
    IntVarArray time;
    //variable
    IntVarArray agent;
    IntVar car_number; 
public:
    fire(const Gecode::Options& opt) : Gecode::IntMinimizeScript(opt),agent(*this,matrix.size(),1,matrix.size()),
    time(*this,scenes.size(),9*3600,24*3600),car_number(*this,1,3)//생성자
    {                 
        
        objective=expr(*this,9*3600);

        distinct(*this,agent);
        // for(int i=0;i<matrix.size()*3;i++){
        //     for(int j=0;j<matrix.size()*3;j++){
        //         if(i!=j)
        //             rel(*this,!((agent[i]<100&&agent[i]>0)&&(agent[j]<100&&agent[j]>0)&&agent[i]==agent[j]));
        //             //소화단계(i<100일때 서로 같으면 안됨)는 한번만
        //     }
        // }

        rel(*this,agent[matrix.size()-1]==1); //

        //IntVar temp=expr(*this,0);
        // for(int i=0;i<scenes.size();i++){
        //     // rel(*this,!((agent[i]<100)&&((agent[i]<firestation.size()+1&&agent[i]>0)||agent[i]>matrix.size())));
        //     // //소화할 때는 100이하이어야 하며 소방서의 값이나 그 외의 값을 가지면 안된다.
        //     // rel(*this,agent[i]!=100);   //100은 존재할 수 없다
            

        //     // if(i>0){
        //     //     rel(*this,!((agent[i]>100)&&(agent[i]/100!=agent[i-1]%100)));   //이동 단계일 때는 전의 도착지점과 현재 출발지점이 같아야한다
        //     //     rel(*this,!((agent[i]<100&&agent[i]>0)&&(agent[i]!=agent[i-1]%100)));   //소화단계일 때는 전의 도착지점과 현재 지점과 같아야한다
        //     //     rel(*this,!((agent[i]>100&&agent[i-1]>100)&&agent[i]%100==agent[i-1]/100)); //이동을 연속으로 할때 똑같은 경로로 다시 돌아가선 안된다. 
                
        //     // }

        //     // rel(*this,(agent[i]%100>=1&&agent[i]%100<=matrix.size())||agent[i]==0); //도착 또는 소화 지점은 반드시 범위안에 있어야 하거나 0이어야 한다
            
        //     // rel(*this,!(agent[i]>100&&((agent[i]/100<1||agent[i]/100>matrix.size())))); //이동 단계일때 시작 지점은 반드시 범위안에 있어야 한다.

        //     // rel(*this,!(agent[i]>100&&agent[i]/100==agent[i]%100)); //이동단계일 때 도착지점과 시작 지점이 같으면 안된다.
            

        //     // temp=expr(*this,temp+ite(agent[i]<100&&agent[i]>0,1,0));    //소화 한 개수

        //     if(i>0){
                
        //         rel(*this,!((temp==scenes.size()&&(agent[i-1]==0||agent[i-1]%100==1))&&agent[i]!=0));
        //         //소화를 다 마치고 소방서에 돌아왔거나 끝난 상태면 뒤쪽 값들은 전부 0이다.
        //     }

        // }


        // for(int i=0;i<matrix.size()*3;i++){
        //     if(i==matrix.size()*3-1){
        //         rel(*this,agent[i]==0||agent[i]%100==1);    //행동 끝에는 0이거나  끝이나야한다
        //     }
        //     else{
        //         rel(*this,!((agent[i]!=0&&agent[i+1]==0)&&(agent[i]%100!=1)));  //0 바로 앞에 0이 아니면 반드시 1로 끝나야 한다.
        //     }
        // }
        // rel(*this,temp==scenes.size()); //모든 화재 현장을 돌아야함
        // rel(*this,agent[1]==2);
        // rel(*this,agent[3]==3);
        // rel(*this,agent[4]%100==1);
        //rel(*this,agent[5]==0);
        //rel(*this,agent[7]==0);
        IntVar count(0);
        cout<<"hi"<<endl;
        for(int i=0;i<matrix.size();i++){//3중 포문 쓸것
            for(int j=1;j<=matrix.size();j++){
                if(i==0){objective=expr(*this,objective+ite(agent[i]==j,
                            matrix[0][j-1],0));
                }
                else{
                    for(int k=1;k<=matrix.size();k++){
                            objective=expr(*this,objective+ite(agent[i]==k&&agent[i-1]==j,
                                matrix[j-1][k-1],0));
                    }
                }
                if(j>1){
                    //rel(*this,!(scenes[j-2][1]<=objective&&agent[i]==j));
                // IntVar t=expr(*this,time[j-2]);
                // time[j-2]=expr(*this,ite(agent[i]==j,objective,t));
                }
                // if(j>firestation.size()){
                //     objective=expr(*this,objective+ite(agent[i]<100&&agent[i]%100==j,
                //         scenes[j-firestation.size()-1][0],0));
                //     //cout<<objective<<" "<<scenes[j-firestation.size()-1][1]<<endl;
                //         //;
                //         //time[j-firestation.size()-1]=expr(*this,ite(agent[i]<100&&agent[i]%100==j,objective,t));
                //     rel(*this,!((agent[i]<100&&agent[i]%100==j)&&objective>scenes[j-firestation.size()-1][1]));
                // }
                
            }
            for(int j=0;j<scenes.size();j++){
                time[j]=expr(*this,ite(agent[i]==j+2,objective,time[j]));
            }
            if(i!=matrix.size()-1)
                    objective=expr(*this,objective+(19*60));

            

            
            
            
            //cout<<objective<<endl;
        }
        // for(int i=0;i<scenes.size();i++){
        //     rel(*this,time[i]<=scenes[i][1]);
        // }
        //cout<<objective<<endl;
        cout<<"hi"<<endl;

        hour=expr(*this,objective/3600);
        min=expr(*this,(objective-(hour*3600))/60);
        sec=expr(*this,objective-(hour*3600)-(min*60));


        //rel(*this,objective<24*3600);

        
        branch(*this,agent,INT_VAR_SIZE_MIN(),INT_VAL_MIN()); 


        
        
        
    }

    fire(fire& v) : Gecode::IntMinimizeScript(v) {

        agent.update(*this,v.agent);
        objective.update(*this,v.objective);
        hour.update(*this,v.hour);
        min.update(*this,v.min);
        sec.update(*this,v.sec);
        time.update(*this,v.time);

    }

    virtual Space* copy(void) {
        return new fire(*this);
    }

    virtual Gecode::IntVar cost(void) const {

        return objective;
    }

    void print(std::ostream& os) const {



        os<<agent<<" ";
        os.width(2); // 폭을 10으로 지정
        os.fill('0'); // 채움 문자는 '0'
        os<<hour<<":";
        os.width(2); // 폭을 10으로 지정
        os.fill('0');
        os<<min<<":";
        os.width(2); // 폭을 10으로 지정
        os.fill('0');
        os<<sec<<" "<<objective<<endl;

        for(int i=0;i<scenes.size();i++){
            os<<time[agent[i].val()-2]<<" ";
        }
        os<<endl;
        for(int i=0;i<scenes.size();i++){
            os<<scenes[agent[i].val()-2][1]<<" ";
        }
        os<<endl;
    }

};

int main(int argc, char* argv[]) {
     ifstream fs;
    string s="data2.csv";
    string temp;
    fs.open(s,ios::in);
    int max=0;
    while(!fs.eof())    //csv 파싱
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