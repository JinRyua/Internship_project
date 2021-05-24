#include<iostream>
#include<fstream>
#include<string>
#include<vector>
#include<algorithm>
#include <cstdlib>
#include <ctime>
using namespace std;
struct axis{
    int row;
    int col;
};

int makerandom(int i) {
    return std::rand() % i;
}


int main()
{
     srand((unsigned int)time(NULL));        //set random seed
    std::ofstream writeFile;
    writeFile.open("game.h");
    if (writeFile.is_open()) //파일이 열렸는지 확인
    {
        string s;
        vector<int> temp;
        s = "#include<vector>\nusing namespace std;\nvector<vector<int>> nob = {";
        writeFile.write(s.c_str(), s.length());
        temp.resize(20);
        for (int i = 0; i < 20; i++) {
            for (int j = 0; j < 10; j++) {
                temp.push_back(j);
            }
            random_shuffle(temp.begin(),temp.end(),makerandom);
            s = "{";
            for(int j =0;j<temp.size();j++){
                s += to_string(temp[j]);
                if(j!=temp.size()-1)
                    s+= ", ";
            }
            s += "}";
        }
        s += "};";
        writeFile.write(s.c_str(), s.length());

    }

    writeFile.write("\n",1);

        
    writeFile.close(); //파일 닫기

    
    return 0;
}