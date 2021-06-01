#include<iostream>
#include<string>
#include<cstring>

#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
using namespace std;

#define PORT 7777
#define BUF_SIZE 1024
const char IP[] = "127.0.0.1";  //loopback


int main()
{
    int sock;
    struct sockaddr_in serv_addr;
    char buf[BUF_SIZE];
    int str_len;

    sock = socket(PF_INET, SOCK_STREAM, 0); //make socket
    if(sock == -1){
        cout<<"socket() error"<<endl;
        return 0;
    }

    memset(&serv_addr, 0 ,sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = inet_addr(IP);
    serv_addr.sin_port = htons(PORT);

    if(connect(sock,(struct sockaddr*)&serv_addr,sizeof(serv_addr))==-1){
        return 0;
    }

    str_len = read(sock, buf, sizeof(buf) - 1);

    cout << buf;
    close(sock);
    return 0;

    return 0;
}