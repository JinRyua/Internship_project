#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/select.h>
#include <sys/types.h>
#include <vector>
#include <iostream>
#include <string>
#include <cstring>
#include <queue>
using namespace std;
#define PORT 8888
#define BUF_SIZE 3076
const char IP[] = "127.0.0.1";  //loopback
int main() {
    int sock;
    struct sockaddr_in serv_addr;
    char buf[BUF_SIZE];
    string buff(BUF_SIZE, 0);
    int str_len;

    sock = socket(PF_INET, SOCK_STREAM, 0);  //make socket
    if (sock == -1) {
        cout << "socket() error" << endl;
        return 0;
    }

    memset(&serv_addr, 0, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = inet_addr(IP);
    serv_addr.sin_port = htons(PORT);

    if (connect(sock, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) == -1) {
        cout<<"error"<<endl;
        return 0;
    }
    for (int i = 0; i < 100000000; i++) {
        string buffer = "hello";
        char a[3000];
        int b = read(sock,&a,3000-1);
        write(sock, buffer.c_str(), buffer.size());
    }
    close(sock);
    return 0;
}