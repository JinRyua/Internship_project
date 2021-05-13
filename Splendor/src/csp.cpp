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


vector<int> state;

class Planner : public Gecode::IntMinimizeScript{
protected:
    Gecode::IntVar objective;   //선호 점수
    Gecode::IntVarArray action; 
public:
    Planner(const Gecode::Options& opt) : Gecode::IntMinimizeScript(opt), action(*this,1,1,5) //생성자
    {    
        objective = action[0];
        int ghost_num = 0;             
        for(int i = 0; i < state.size(); i++){
            if(state[i] == 1)
                ghost_num++;
        }
        IntVar temp = expr(*this,1 + ghost_num);
        rel(*this,action[0] == temp);
        
    }

    Planner(Planner& v) : Gecode::IntMinimizeScript(v) {
        action.update(*this,v.action);
        objective.update(*this,v.objective);
    }

    virtual Space* copy(void) {
        return new Planner(*this);
    }

    virtual Gecode::IntVar cost(void) const {

        return objective;
    }

    void print(std::ostream& os) const {
        os<<"action : "<<action<<endl;
    }

};

int main(int argc, char* argv[]) {
    double time = 30000;
    string s="problem.pddl";
    if(argc <= 2){
        s = argv[1];
    }
    ifstream fs;
    
    string temp;
    fs.open(s,ios::in);
    int max=0;
    cout<<"csp"<<endl;
    while(!fs.eof())
    {
        getline(fs,temp);
        cout<<temp<<endl;
        if( temp == "ghost")
            state.push_back(1);
        else if(temp == "non_ghost"){
            state.push_back(0);
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

    Gecode::Script::run<Planner, Gecode::DFS, Gecode::Options>(opt);  //DFS=>BAB(branch and bound)(분기한정 -> 백트래킹)

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