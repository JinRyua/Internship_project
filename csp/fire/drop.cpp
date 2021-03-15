#include <gecode/int.hh>
#include <gecode/minimodel.hh>
#include <gecode/search.hh>
//#include <gecode/gist.hh>
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
static int car = 3;
static int scene = 20;
int temp = 0;

IntVarArray select_number;
IntVarArray select_area;

int a = 2;
vector<string> split(string str, char delimiter); //선호,기피 string list를 vector로 만들어 주는 함수

class assign_spot : public Gecode::IntMinimizeScript{
protected:
    Gecode::IntVar objective;    
    IntVarArray area;
    IntVarArray agent;
    IntVarArray time;
public:
    assign_spot(const Gecode::Options &opt) : Gecode::IntMinimizeScript(opt),
        agent(*this,car,1,scenes.size())
        ,time(*this,car,0,0)
        ,area(*this,scenes.size(),2,1+scenes.size())
    {
        IntVar temp_agent=expr(*this,0);
        for(int i=0;i<car;i++){
            temp_agent=expr(*this,temp_agent+agent[i]);
        }
        rel(*this,temp_agent==scenes.size());
        distinct(*this,area);
        temp_agent=expr(*this,0);
        IntVar before_agent=expr(*this,0);
        for(int i=0;i<car;i++){
            time[i]=expr(*this,0);
            temp_agent=expr(*this,temp_agent+agent[i]);
            cout<<temp_agent<<endl;
            for(int j=0;j<scenes.size();j++){
                for(int k=0;k<scenes.size();k++){
                    if(j>1){
                        for(int l=0;l<scenes.size();l++){
                            if(l!=k){
                                time[i]=expr(*this,time[i]+ite(temp_agent>j&&j>=before_agent
                                    &&area[j]==k+2&&area[j-1]==l+2,matrix[l+1][k+1],0));
                            }
                        }   
                    }
                    else{
                        time[i]=expr(*this,time[i]+ite(temp_agent>j&&j>=before_agent
                                    &&area[j]==k+2,matrix[0][k+1],0));
                    }
                }
            }
            before_agent=temp_agent;
            cout<<time[i]<<endl;
        }

        IntVar min_time=expr(*this,0);
        IntVar max_time=expr(*this,0);
        IntVar max_agent=expr(*this,0);
    
        cout<<time<<endl;
        max_agent=expr(*this,0);
        min_time=expr(*this,18*3600);
        for(int i=0;i<car;i++){
            min_time=expr(*this,ite(min_time>time[i],time[i],min_time));
            max_time=expr(*this,ite(max_time<time[i],time[i],max_time));
            max_agent=expr(*this,ite(max_agent<agent[i],agent[i],max_agent));
        }
        objective=expr(*this,max_agent*100000+max_time*10+max_time-min_time);
        branch(*this, area, INT_VAR_SIZE_MIN(), INT_VAL_MIN());

        branch(*this,agent,INT_VAR_SIZE_MIN(),INT_VAL_SPLIT_MIN());
    }

    assign_spot(assign_spot &v) : Gecode::IntMinimizeScript(v)
    {
        area.update(*this,v.area);
        agent.update(*this,v.agent);
        time.update(*this,v.time);
        objective.update(*this, v.objective);
        
    }

    virtual Space *copy(void)
    {
        return new assign_spot(*this);
    }

    virtual Gecode::IntVar cost(void) const
    {

        return objective;
    }

    void print(std::ostream &os) const
    {
        os<<agent<<endl;
        os<<area<<endl;
        os<<time<<endl;
        os<<objective<<endl;

    }
};


class data
{
public:
    IntVarArray agent;
    IntVar spot;
    IntVar idx_i;
    IntVar lunch;
    IntVar time;

    data(Gecode::Home a, vector<int>::size_type matsize) : 
    agent(a, matrix.size() + 1, 0, matrix.size()), idx_i(a, 0, 0), time(a, 13 * 3600, 13 * 3600), spot(a, 0, 0), lunch(a, 11 * 3600, 11 * 3600)
    {
        lunch = expr(a, 0);
        time = expr(a, 9 * 3600);
        idx_i = expr(a, 0);
    }
};

class fire : public Gecode::IntMaximizeScript
{
protected:
    Gecode::IntVar objective; //선호 점수
    IntVar hour, min, sec;
    //IntVar time;
    //variable
    vector<data> data_fire;

    IntVar max_time;
    IntVar max_spot;
    IntVar min_spot;
    IntVar total_spot;
    // vector<IntVarArray> agent;
    // IntVar spot;
    // IntVar idx_i;
    // IntVar lunch;

public:
    fire(const Gecode::Options &opt) : Gecode::IntMaximizeScript(opt) //,agent(*this,matrix.size()+1,0,matrix.size())
    //,idx_i(*this,0,0),time(*this,13*3600,13*3600),spot(*this,0,0),lunch(*this,11*3600,11*3600)
    //,temp(*this,3,2,4)//생성자
    {
        
        for (int l = 0; l < car; l++)
        {
            data temp(*this, matrix.size());
            data_fire.push_back(temp);
            distinct(*this, data_fire[l].agent);
            for (int i = 0; i < matrix.size() + 1; i++)
            {
                data_fire[l].idx_i = expr(*this, ite(data_fire[l].agent[i] == 1, i, data_fire[l].idx_i));
            }
            cout << data_fire[l].idx_i << endl;
        }
        rel(*this,data_fire[0].agent[6]==1);
        rel(*this,data_fire[1].agent[3]==1);
        //rel(*this,data_fire[2].agent[5]==1);
        for(int i=0;i<car;i++){
            for(int l=0;l<car;l++){
                for(int j=0;j<matrix.size()+1;j++){
                    for(int k=0;k<matrix.size()+1;k++){
                        if(i!=l){
                            rel(*this,!((j<=data_fire[i].idx_i&&k<=data_fire[l].idx_i&&
                                data_fire[i].agent[j]>1&&data_fire[l].agent[k]>1)&&
                                data_fire[i].agent[j]==data_fire[l].agent[k]));
                        }
                    
                    }
                }
            }
            
        }
        for (int l = 0; l < car; l++)
        {
            // lunch=expr(*this,0);
            // time=expr(*this,10*3600);
            // idx_i=expr(*this,0);
            // for (int i = 0; i < matrix.size() + 1; i++)
            // {
            //     data_fire[l].idx_i = expr(*this, ite(data_fire[l].agent[i] == 1, i, data_fire[l].idx_i));
            // }
            // cout << data_fire[l].idx_i << endl;
            for (int i = 0; i < matrix.size() + 1; i++)
            {
                for (int j = 0; j < matrix.size(); j++)
                {
                    if (i == 0)
                    {
                        data_fire[l].time = expr(*this, data_fire[l].time 
                            + ite(i <= data_fire[l].idx_i && (data_fire[l].agent[i] == j + 1), matrix[0][j], 0));
                    }
                    else if (i > 0)
                    {
                        for (int k = 0; k < matrix.size(); k++)
                        {
                            if (j != k)
                            {
                                data_fire[l].time = expr(*this, data_fire[l].time 
                                    + ite(i <= data_fire[l].idx_i && (data_fire[l].agent[i] == k + 1) && (data_fire[l].agent[i - 1] == j + 1)
                                    , matrix[j][k], 0));
                            }
                        }
                        if (i == 1)
                            data_fire[l].time = expr(*this, data_fire[l].time + 
                                ite(i <= data_fire[l].idx_i && data_fire[l].agent[i - 1] == 0 && data_fire[l].agent[i] == j + 1
                                , matrix[0][j], 0));
                        else
                            for (int k = 0; k < matrix.size(); k++)
                                data_fire[l].time = expr(*this, data_fire[l].time + 
                                    ite(i <= data_fire[l].idx_i && data_fire[l].agent[i - 1] == 0 && data_fire[l].agent[i] == j + 1 && data_fire[l].agent[i - 2] == k + 1
                                    , matrix[k][j], 0));
                    }
                }
                if (scenes[0].size() > 1)
                    for (int j = firestation.size(); j < matrix.size(); j++)
                    {
                        rel(*this, !(i <= data_fire[l].idx_i && (data_fire[l].agent[i] == j + 1) && data_fire[l].time > scenes[j - 1][1]));
                    }
                data_fire[l].time = expr(*this, data_fire[l].time + ite(i <= data_fire[l].idx_i && (data_fire[l].agent[i] > 1), 19 * 60, 0));
                data_fire[l].lunch = expr(*this, ite(i <= data_fire[l].idx_i && data_fire[l].agent[i] == 0, data_fire[l].time, data_fire[l].lunch));
                data_fire[l].time = expr(*this, data_fire[l].time + ite(i <= data_fire[l].idx_i && (data_fire[l].agent[i] == 0), 1 * 3600, 0));
            }
            rel(*this, (data_fire[l].lunch >= 11 * 3600 && data_fire[l].lunch <= 13 * 3600)||data_fire[l].lunch==0);
            //rel(*this,(lunch>=44000));
            //rel(*this,agent[matrix.size()-1]==0);
            rel(*this, !(data_fire[l].time > 13 * 3600 && data_fire[l].lunch == 0)); //점심시간 지나서 일하는데 lunch안먹으면 안됨
            data_fire[l].spot = expr(*this, data_fire[l].idx_i);
            data_fire[l].spot = expr(*this, ite(data_fire[l].lunch != 0, data_fire[l].spot - 1, data_fire[l].spot));
            
            rel(*this, data_fire[l].time <= 18 * 3600);
        }
        min_spot=expr(*this,matrix.size());
        max_time=expr(*this,0);
        max_spot=expr(*this,0);
        total_spot=expr(*this,0);
        for(int l=0;l<car;l++){
            max_time=expr(*this,ite(max_time<data_fire[l].time,data_fire[l].time,max_time));
            max_spot=expr(*this,ite(max_spot<data_fire[l].spot,data_fire[l].spot,max_spot));
            min_spot=expr(*this,ite(min_spot>data_fire[l].spot,data_fire[l].spot,min_spot));
            total_spot=expr(*this,total_spot+data_fire[l].spot);
        }
            objective = expr(*this, max_spot * 18 * 3600*100- max_time - 
            (max_spot-min_spot)*18*3600);

        for(int i=0;i<car;i++)
            branch(*this, data_fire[i].agent, INT_VAR_SIZE_MIN(), INT_VAL_SPLIT_MIN());
    }

    fire(fire &v) : Gecode::IntMaximizeScript(v)
    {
        objective.update(*this, v.objective);
        data_fire.reserve(car);
        for (int i = 0; i < car; i++)
        {
            data_fire[i].agent.update(*this, v.data_fire[i].agent);
            data_fire[i].idx_i.update(*this, v.data_fire[i].idx_i);
            data_fire[i].spot.update(*this, v.data_fire[i].spot);
            data_fire[i].lunch.update(*this, v.data_fire[i].lunch);
            data_fire[i].time.update(*this, v.data_fire[i].time);
        }
        max_time.update(*this,v.max_time);
        max_spot.update(*this,v.max_spot);
        min_spot.update(*this,v.max_spot);
        total_spot.update(*this,v.max_spot);
        // agent.update(*this, v.agent);
        // idx_i.update(*this, v.idx_i);
        // spot.update(*this, v.spot);

        // objective.update(*this, v.objective);
        // lunch.update(*this, v.lunch);
        // // // min.update(*this,v.min);
        // // // sec.update(*this,v.sec);
        // time.update(*this, v.time);
        // //
    }

    virtual Space *copy(void)
    {
        return new fire(*this);
    }

    virtual Gecode::IntVar cost(void) const
    {

        return objective;
    }

    void print(std::ostream &os) const
    {
        for (int i = 0; i < car; i++)
        {
            os << data_fire[i].agent; //<< endl;
            os << " spot : " << data_fire[i].spot;
            os << " time : " << data_fire[i].time << " ";
            os << " lunch : " << data_fire[i].lunch << " ";
            cout<<endl;
        }
        os << " objective : " << objective <<" total_spot : "<<max_spot
        <<" total time : "<<max_time<< endl<<endl;
    }
};

int main(int argc, char *argv[])
{
    ifstream fs;
    string s = "data2.csv";
    string temp;
    fs.open(s, ios::in);
    int max = 0;
    while (!fs.eof())
    {
        getline(fs, temp);
        int com = temp.find(",");
        temp = temp.substr(0, com);
        cout << endl
             << temp << endl;
        if (temp == "Station")
        {
            getline(fs, temp);
            int a = 0;
            getline(fs, temp);
            while (temp[0] != ',' && !fs.eof())
            {
                com = temp.find(",");
                temp = temp.substr(0, com);
                firestation.push_back(a);
                a++;
                cout << temp << endl;
                max++;
                getline(fs, temp);
            }
        }
        else if (temp == "Fire Scenes")
        {
            vector<int> temp2;
            getline(fs, temp);
            getline(fs, temp);
            com = 0;
            while (temp[0] != ',' && !fs.eof())
            {
                temp2.clear();
                com = temp.find(",");
                int com2 = temp.find(",", com + 1);
                string temp3 = temp.substr(com + 1, com2 - com - 1);
                com = com2;
                temp2.push_back(stoi(temp3) * 60);
                cout << temp << endl
                     << stoi(temp3) * 60 << " ";

                com2 = temp.find(":", com + 1);

                if (com2 != -1)
                {
                    temp3 = temp.substr(com + 1, com2 - com - 1);
                    int temp4 = 0;
                    temp4 = stoi(temp3) * 3600;

                    com = com2;
                    com2 = temp.find(":", com + 1);
                    temp3 = temp.substr(com + 1, com2 - com - 1);
                    temp4 = temp4 + stoi(temp3) * 60;

                    com = com2;
                    com2 = temp.find(",", com + 1);
                    temp3 = temp.substr(com + 1, com2 - com - 1);
                    temp4 = temp4 + stoi(temp3);

                    temp2.push_back(temp4);
                    //cout<<temp4<<endl;
                }
                if (max <= scene)
                {
                    scenes.push_back(temp2);
                    max++;
                }
                getline(fs, temp);
            }
        }
        else if (temp == "Distance Matrix")
        {
            getline(fs, temp);
            cout << "max:" << max << endl;
            int count = 0;
            while (temp[0] != ',' && !fs.eof())
            {

                int com = 0;
                vector<int> temp3;
                temp3.clear();
                for (int i = 0; i < max; i++)
                {
                    com = temp.find(",", com);
                    int com2 = temp.find(",", com + 1);
                    string temp2 = temp.substr(com + 1, com2 - com - 1);
                    if (i == max - 1)
                        temp2 = temp.substr(com + 1);

                    if (i < max)
                    {
                        cout << stoi(temp2) / 27 << endl;
                        if (i != 0)
                            temp3.push_back(stoi(temp2) / 27); //+scenes[i-1][0]);
                        else
                            temp3.push_back(stoi(temp2) / 27);
                    }
                    com = com2;
                }
                if (count < max)
                    matrix.push_back(temp3);
                count++;
                cout << endl;
                getline(fs, temp);
                if (fs.eof())
                {
                    break;
                }
            }
        }
        else if (temp == "Fire Cars")
        {
            getline(fs, temp);
            while (temp[0] != ',' && !fs.eof())
            {
                getline(fs, temp);
            }
        }
    }
    for (int i = 0; i < matrix.size(); i++)
    {
        for (int j = 0; j < matrix.size(); j++)
        {
            cout << matrix[i][j] << " ";
        }
        cout << endl;
    }

    fs.close();

    Gecode::Options opt("");
    opt.time(30000);
    opt.solutions(0);
    opt.threads(5);
    opt.interrupt(false);
    opt.parse(argc, argv);
    //opt.mode(Gecode::SM_GIST);

    Gecode::Script::run<assign_spot, Gecode::BAB, Gecode::Options>(opt);

    cout<<endl<<"selected : "<<endl<<select_number<<select_area<<endl;
    //Gecode::Script::run<fire, Gecode::BAB, Gecode::Options>(opt); //DFS=>BAB(branch and bound)(분기한정 -> 백트래킹)

    return 0;
}

vector<string> split(string input, char delimiter)
{
    vector<string> answer;
    stringstream ss(input);
    string temp;

    while (getline(ss, temp, delimiter))
    {
        answer.push_back(temp);
    }

    return answer;
}