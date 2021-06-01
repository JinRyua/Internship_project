#include<iostream>
#include<fstream>
#include<sstream>
#include<string>
#include<vector>
using namespace std;

struct card{
    string token = "";
    char point = 0;
    char white = 0;
    char blue = 0;
    char green = 0;
    char red = 0;
    char black = 0;
};

#define NAME 0
#define TOKEN 1
#define POINT 2
#define WHITE 3
#define BLUE 4
#define GREEN 5
#define RED 6
#define BLACK 7

std::vector<std::string> split(std::string input, char delimiter);
string change_color(const string& color);

int main()
{
    std::ifstream readFile;
    std::ofstream writeFile;
    readFile.open("game.csv");  //game proposition
    writeFile.open("problem_splendor.pddl");    //output for problem pddl

    vector<card> nobility;  //cards
    vector<card> level1;
    vector<card> level2;
    vector<card> level3;

    if (writeFile.is_open()&&readFile.is_open()) //파일이 열렸는지 확인
    {
        string temp;
    
        
        struct card origin;
        getline(readFile, temp);
        while(getline(readFile, temp)){
            vector<string> line = split(temp, ','); //line => vector

            struct card card_temp = origin; //init
            for (int i = 0; i < line.size(); i++) {
                if(line[i] != ""){
                    if (i == TOKEN)
                        card_temp.token = line[i];
                    else if (i == POINT)
                        card_temp.point = stoi(line[i]);
                    else if (i == WHITE)
                        card_temp.white = stoi(line[i]);
                    else if (i == BLUE)
                        card_temp.blue = stoi(line[i]);
                    else if (i == GREEN)
                        card_temp.green = stoi(line[i]);
                    else if (i == RED)
                        card_temp.red = stoi(line[i]);
                    else if (i == BLACK)
                        card_temp.black = stoi(line[i]);
                }
            }

            if(line[NAME] == "NOBILITY")            //make card
                nobility.push_back(card_temp);
            else if (line[NAME] == "LEVEL1")
                level1.push_back(card_temp);
            else if (line[NAME] == "LEVEL2")
                level2.push_back(card_temp);
            else if (line[NAME] == "LEVEL3")
                level3.push_back(card_temp);
        }
    }

    string s = ""; //print txt for pddl

    s = "(define (problem problem_splendor) (:domain splendor)\n(:objects\n";   //make problem
    writeFile.write(s.c_str(), s.length());


    s="player1 -player\n";          //make player
    writeFile.write(s.c_str(), s.length());

    s="ai1 -ai\n";                  //make ai
    writeFile.write(s.c_str(), s.length());

    s="white blue green red black none -token\n";                  //make token
    writeFile.write(s.c_str(), s.length());
    
    s="order1 order2 order3 order4 -order\n";                  //make order
    writeFile.write(s.c_str(), s.length());

    s="buy_level1 buy_level2 buy_level3 -buylevel\n";          //make buylevel
    writeFile.write(s.c_str(), s.length());


    for (int i = 0; i < nobility.size(); i++) {         //make nobility card
        s = "nobility_" + to_string(i) + " ";
        writeFile.write(s.c_str(), s.length());
    }
    s="-nobility\n";
    writeFile.write(s.c_str(), s.length());

    for (int i = 0; i < level1.size(); i++) {         //make level1 card
        s = "level1_" + to_string(i) + " ";
        writeFile.write(s.c_str(), s.length());
    }
    s="-level1\n";
    writeFile.write(s.c_str(), s.length());

    for (int i = 0; i < level2.size(); i++) {         //make level2 card
        s = "level2_" + to_string(i) + " ";
        writeFile.write(s.c_str(), s.length());
    }
    s="-level2\n";
    writeFile.write(s.c_str(), s.length());

    for (int i = 0; i < level3.size(); i++) {         //make level3 card
        s = "level3_" + to_string(i) + " ";
        writeFile.write(s.c_str(), s.length());
    }
    s="-level3\n)\n";       //end object
    writeFile.write(s.c_str(), s.length());

    s = "(:init\n";   //make init proposition
    writeFile.write(s.c_str(), s.length());

    for (int i = 0; i < nobility.size(); i++) {  //nobility propostion
        s = "(fold nobility_" + to_string(i) + ")\n";
        s += "(=(s-point nobility_" + to_string(i) + ") " + to_string(nobility[i].point) + ")\n";
        s += "(=(need-token nobility_" + to_string(i) + " white) " + to_string(nobility[i].white) + ")\n";
        s += "(=(need-token nobility_" + to_string(i) + " blue) " + to_string(nobility[i].blue) + ")\n";
        s += "(=(need-token nobility_" + to_string(i) + " green) " + to_string(nobility[i].green) + ")\n";
        s += "(=(need-token nobility_" + to_string(i) + " red) " + to_string(nobility[i].red) + ")\n";
        s += "(=(need-token nobility_" + to_string(i) + " black) " + to_string(nobility[i].black) + ")\n";
        writeFile.write(s.c_str(), s.length());
    }

    for (int i = 0; i < level1.size(); i++) {  //level1 propostion
        s = "(fold level1_" + to_string(i) + ")\n";
        s += "(s-color level1_" + to_string(i) + " " + change_color(level1[i].token) + ")\n";
        s += "(=(s-point level1_" + to_string(i) + ") " + to_string(level1[i].point) + ")\n";
        s += "(=(need-token level1_" + to_string(i) + " white) " + to_string(level1[i].white) + ")\n";
        s += "(=(need-token level1_" + to_string(i) + " blue) " + to_string(level1[i].blue) + ")\n";
        s += "(=(need-token level1_" + to_string(i) + " green) " + to_string(level1[i].green) + ")\n";
        s += "(=(need-token level1_" + to_string(i) + " red) " + to_string(level1[i].red) + ")\n";
        s += "(=(need-token level1_" + to_string(i) + " black) " + to_string(level1[i].black) + ")\n";
        writeFile.write(s.c_str(), s.length());
    }

    for (int i = 0; i < level2.size(); i++) {  //level2 propostion
        s = "(fold level2_" + to_string(i) + ")\n";
        s += "(s-color level2_" + to_string(i) + " " + change_color(level2[i].token) + ")\n";
        s += "(=(s-point level2_" + to_string(i) + ") " + to_string(level2[i].point) + ")\n";
        s += "(=(need-token level2_" + to_string(i) + " white) " + to_string(level2[i].white) + ")\n";
        s += "(=(need-token level2_" + to_string(i) + " blue) " + to_string(level2[i].blue) + ")\n";
        s += "(=(need-token level2_" + to_string(i) + " green) " + to_string(level2[i].green) + ")\n";
        s += "(=(need-token level2_" + to_string(i) + " red) " + to_string(level2[i].red) + ")\n";
        s += "(=(need-token level2_" + to_string(i) + " black) " + to_string(level2[i].black) + ")\n";
        writeFile.write(s.c_str(), s.length());
    }

    for (int i = 0; i < level3.size(); i++) {  //level3 propostion
        s = "(fold level3_" + to_string(i) + ")\n";
        s += "(s-color level3_" + to_string(i) + " " + change_color(level3[i].token) + ")\n";
        s += "(=(s-point level3_" + to_string(i) + ") " + to_string(level3[i].point) + ")\n";
        s += "(=(need-token level3_" + to_string(i) + " white) " + to_string(level3[i].white) + ")\n";
        s += "(=(need-token level3_" + to_string(i) + " blue) " + to_string(level3[i].blue) + ")\n";
        s += "(=(need-token level3_" + to_string(i) + " green) " + to_string(level3[i].green) + ")\n";
        s += "(=(need-token level3_" + to_string(i) + " red) " + to_string(level3[i].red) + ")\n";
        s += "(=(need-token level3_" + to_string(i) + " black) " + to_string(level3[i].black) + ")\n";
        writeFile.write(s.c_str(), s.length());
    }

    s = "(=(have-token field white) 4)\n";      //field token
    s += "(=(have-token field blue) 4)\n";
    s += "(=(have-token field green) 4)\n";
    s += "(=(have-token field red) 4)\n";
    s += "(=(have-token field black) 4)\n";
    s += "(=(have-token ai1 white) 0)\n";       //ai token
    s += "(=(have-token ai1 blue) 0)\n";
    s += "(=(have-token ai1 green) 0)\n";
    s += "(=(have-token ai1 red) 0)\n";
    s += "(=(have-token ai1 black) 0)\n";
    s += "(=(have-token player1 white) 0)\n";   //player token
    s += "(=(have-token player1 blue) 0)\n";
    s += "(=(have-token player1 green) 0)\n";
    s += "(=(have-token player1 red) 0)\n";
    s += "(=(have-token player1 black) 0)\n";
    s += "(=(have-score player1) 0)\n";     //player score
    s += "(=(have-score ai1) 0)\n";   //ai score
    s += ")\n";  //end init
    writeFile.write(s.c_str(), s.length());

    s = "(:goal (and\n(=(timer)4)\n))\n)";  //goal and end problem
    writeFile.write(s.c_str(), s.length());

   

    writeFile.write("\n",1);

        
    writeFile.close(); //파일 닫기
    readFile.close();  

    
    return 0;
}

std::vector<std::string> split(std::string input, char delimiter)
{
  std::vector<std::string> answer;
  std::stringstream ss(input);
  std::string temp;

  while (getline(ss, temp, delimiter))
  {
	//if(temp != "" && temp !=" ")
    	answer.push_back(temp);
  }

  return answer;
}

string change_color(const string& color){
    if (color == "K")
        return "black";
    else if (color == "U")
        return "blue";
    else if (color == "G")
        return "green";
    else if (color == "R")
        return "red";
    else if (color == "W")
        return "white";
}