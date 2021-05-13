#include <iostream>
#include<string>
#include<chrono>
using namespace std;

namespace Custom{
void print_log(string node_name, string func,string str){
	cout<< "[";
	cout.width(9);cout.fill(' ');cout<<fixed;cout.precision(3);
	cout<<std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::now().time_since_epoch()).count()<<"][";
	cout.width(13);cout.fill(' ');
	cout<<node_name<<"][";
	cout.width(17);cout.fill(' ');
	cout<<func<<"] ( "<<str<<" )"<<endl;
}
}