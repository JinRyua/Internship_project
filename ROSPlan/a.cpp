#include<iostream>
#include<fstream>
#include<string>
#include<vector>
using namespace std;
struct axis{
    int row;
    int col;
};
int main()
{
    std::ifstream readFile;
    std::ofstream writeFile;
    readFile.open("map.csv");
    writeFile.open("words.txt");
    if (writeFile.is_open()&&readFile.is_open()) //파일이 열렸는지 확인
    {
        string temp;
        int row,col;
        int player_row, player_col;
        int count_agent;
        vector<axis> agent;
        vector<axis> block;
        vector<axis> scookie;
        vector<axis> lcookie;
        vector<axis> blank;
        vector<axis> menu;
        struct axis start;
        struct axis end;
        while(getline(readFile, temp)){
            if(temp.find("map size")!=-1){
                getline(readFile,temp,',');
                row = stoi(temp);
                getline(readFile,temp,',');
                col = stoi(temp);
                cout<<"size : "<<row<<" "<<col<<endl;
            }
            else if(temp.find("player")!=-1){
                getline(readFile,temp,',');
                player_row = stoi(temp);
                getline(readFile,temp,',');
                player_col = stoi(temp);
                cout<<"player : "<<player_row<<" "<<player_col<<endl;
            }
            else if (temp.find("map diagram") != -1){
                for (int i = 1; i <= row; i++){
                    for (int j = 1; j < col; j++){
                        getline(readFile, temp, ',');
                        struct axis a;
                        a.row = i;
                        a.col = j;
                        if (temp == "n"){
                            blank.push_back(a);
                        }
                        else if (temp == "b"){
                            block.push_back(a);
                        }
                        else if (temp == "s"){
                            scookie.push_back(a);
                        }
                        else if (temp == "l"){
                            lcookie.push_back(a);
                        }
                    }
                    getline(readFile, temp);
                    struct axis a;
                    a.row = i;
                    a.col = col;
                    if (temp == "n"){
                        blank.push_back(a);
                    }
                    else if (temp == "b"){
                        block.push_back(a);
                    }
                    else if (temp == "s"){
                        scookie.push_back(a);
                    }
                    else if (temp == "l"){
                        lcookie.push_back(a);
                    }
                    cout << temp;
                    cout << endl;
                }
            }
            else if(temp.find("menu")!=-1){
                for (int i = 1; i <= row; i++){
                    for (int j = 1; j < col; j++){
                        getline(readFile, temp, ',');
                        struct axis a;
                        a.row = i;
                        a.col = j;
                        if (temp == "a"){
                            menu.push_back(a);
                        }
                        else if (temp == "s"){
                            start=a;
                        }
                        else if (temp == "e"){
                            end=a;
                        }
                    }
                    getline(readFile, temp);
                    struct axis a;
                        a.row = i;
                        a.col = col;
                        if (temp == "a"){
                            menu.push_back(a);
                        }
                        else if (temp == "s"){
                            start=a;
                        }
                        else if (temp == "e"){
                            end=a;
                        }
                }
            }
            else if(temp.find("agent")!=-1){
                getline(readFile, temp, ',');
                count_agent = stoi(temp);
                struct axis a;
                getline(readFile, temp, ',');
                a.row = stoi(temp);
                getline(readFile, temp, ',');
                a.col = stoi(temp);
                for (int i = 0; i < count_agent; i++)
                {
                    agent.push_back(a);
                    cout << "agent : " << a.row << " " << a.col << endl;
                }
            }
        }
        string s;
        for(int i=1;i<=row;i++){
            for(int j=1; j<=col; j++){
                s="point"+ to_string(i) + "_" + to_string(j)+" ";
                writeFile.write(s.c_str(), s.length());
            }
            s="-point\n";
            writeFile.write(s.c_str(), s.length());
        }
        s = " ( in-block player point" + to_string(player_row) + "_" + to_string(player_col) + " )\n";
        writeFile.write(s.c_str(), s.length());
        s = " (=(direction player)"+ to_string(1) + " )\n";
        writeFile.write(s.c_str(), s.length());
        for (int i = 1; i <= count_agent; i++){
            s = "( in-block agent" + to_string(i) + " point" + to_string(agent[i - 1].row) + "_" + to_string(agent[i - 1].col) + " )\n";
            writeFile.write(s.c_str(), s.length());
            s = " (=(direction agent"+ to_string(i) + ")1)\n";
            writeFile.write(s.c_str(), s.length());
        }
        s = "(=(row)" + to_string(row) + ")\n";
        writeFile.write(s.c_str(), s.length());
        s = "(=(col)" + to_string(col) + ")\n";
        writeFile.write(s.c_str(), s.length());
        s = "(=(timer)3)\n";
        writeFile.write(s.c_str(), s.length());
        for (int i = 0; i < block.size(); i++){
            s = "(is-wall point" + to_string(block[i].row) + "_" + to_string(block[i].col) + " )\n";
            writeFile.write(s.c_str(), s.length());
        }
        for (int i = 0; i < blank.size(); i++){
            s = "(is-blank point" + to_string(blank[i].row) + "_" + to_string(blank[i].col) + " )\n";
            writeFile.write(s.c_str(), s.length());
        }
        for (int i = 0; i < scookie.size(); i++){
            s = "(is-scookie point" + to_string(scookie[i].row) + "_" + to_string(scookie[i].col) + " )\n";
            writeFile.write(s.c_str(), s.length());
        }
        for (int i = 0; i < lcookie.size(); i++){
            s = "(is-lcookie point" + to_string(lcookie[i].row) + "_" + to_string(lcookie[i].col) + " )\n";
            writeFile.write(s.c_str(), s.length());
        }
        for (int i = 0; i < menu.size(); i++){
            s = "(is-menu point" + to_string(menu[i].row) + "_" + to_string(menu[i].col) + " )\n";
            writeFile.write(s.c_str(), s.length());
        }
        s = "(is-start point" + to_string(start.row) + "_" + to_string(start.col) + " )\n";
        writeFile.write(s.c_str(), s.length());
        s = "(is-end point" + to_string(end.row) + "_" + to_string(end.col) + " )\n";
        writeFile.write(s.c_str(), s.length());
    }

    writeFile.write("\n",1);

        
    writeFile.close(); //파일 닫기

    
    return 0;
}