#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <fstream>
#include <random>

const int swapSize = 100000;
const int dx[4] = { -1, 0, 0, 1 };
const int dy[4] = { 0, -1, 1, 0 };

int main(int argc, char* argv[]) {    
    int puzzleSize = 3;
    std::cout << "puzzle size(n: n * n puzzle)?" << std::endl;
    std::cin >> puzzleSize;

    std::string domainName = "puzzle";
    std::string problemName = "puzzle_problem";
    std::string problemFileName = "problem";
    std::stringstream problem;
    
    std::vector<std::vector<int>> rooms(puzzleSize);
    for (int i = 0; i < puzzleSize; i++) {
        for (int j = 0; j < puzzleSize; j++) {
            rooms[i].push_back(i * puzzleSize + j);
        }
    }

    std::pair<int, int> empty = { 0, 0 };
    for (int i = 0; i < swapSize; i++) {
        std::vector<std::pair<int, int>> swapIndex;
        for (int j = 0; j < 4; j++) {
            int nx = empty.first + dx[j];
            int ny = empty.second + dy[j];

            if (nx < 0 || nx >= puzzleSize)
                continue;

            if (ny < 0 || ny >= puzzleSize) 
                continue;

            swapIndex.push_back(std::make_pair(nx, ny));
        }

        const int randomSize = swapIndex.size();
        std::random_device rd;
        std::mt19937 gen(rd());
        std::uniform_int_distribution<> dist(0, randomSize - 1);
        std::pair<int, int>& next = swapIndex[dist(gen)];

        // swap.
        std::swap(rooms[empty.first][empty.second], rooms[next.first][next.second]);
        empty.first = next.first;
        empty.second = next.second;
    }

    for (int i = 0; i < puzzleSize; i++) {
        for (int j = 0; j < puzzleSize; j++) {
            std::cout << rooms[i][j] << " ";
        }
        std::cout << std::endl;
    }



    // define.
    problem << "(define (problem " << problemName << ") (:domain " << domainName << ")\n";

    // objects.
    problem << "(:objects\n\t";
    for (int i = 1; i <= puzzleSize * puzzleSize; i++) {
        problem << "room" << i << " ";
    }
    problem << "- room\n\t";
    for (int i = 1; i < puzzleSize * puzzleSize; i++) {
        problem << "num" << i << " "; 
    }
    problem << "- num\n";
    problem << ")\n\n";

    // init.
    problem << "(:init\n";
    for (int i = 0; i < puzzleSize; i++) {
        problem << "\t";
        for (int j = 0; j < puzzleSize; j++) {
            if (rooms[i][j] == 0)
                continue;

            problem << "(at num" << rooms[i][j] << " room" << i * puzzleSize + j + 1 << ") ";
        }
        problem << "\n";
    }
    problem << "\t(empty room" << empty.first * puzzleSize + empty.second + 1 << ")\n\n";
    for (int i = 0; i < puzzleSize; i++) {
        for (int j = 0; j < puzzleSize; j++) {
            problem << "\t";
            std::vector<std::pair<int, int>> adjacent;
            for (int k = 0; k < 4; k++) {
                int x = i + dx[k];
                int y = j + dy[k];

                if (x < 0 || x >= puzzleSize)
                continue;

                if (y < 0 || y >= puzzleSize) 
                    continue;

                adjacent.push_back(std::make_pair(x, y));
            }
            const int adjacentSize = adjacent.size();
            for (int k = 0; k < adjacentSize; k++) {
                problem << "(adjacent room" << i * puzzleSize + j + 1
                        << " room" << adjacent[k].first * puzzleSize + adjacent[k].second + 1 << ") ";
            }
            problem << "\n";
        }        
    }

    problem << ")\n\n";

    // goal.
    problem << "(:goal (and\n";
    for (int i = 0; i < puzzleSize; i++) {
        problem << "\t";
        for (int j = 0; j < puzzleSize; j++) {
            if (i == puzzleSize - 1 && j == puzzleSize - 1) {
                problem << "(empty room" << puzzleSize * puzzleSize << ")";
            }
            else {
                problem << "(at num" << i * puzzleSize + j + 1 << " room" << i * puzzleSize + j + 1 << ") ";
            }            
        }
        problem << "\n";
    }
    
    problem << "))\n\n)";

    try {
        std::ofstream file(problemFileName + ".pddl");

        file << problem.str();

        file.close();
    }
    catch (const std::exception& e) {
        std::cout << e.what() << std::endl;
    }
    



    return 0;
}