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
#include "board/types.h"

#include "boost/serialization/serialization.hpp"
#include "boost/serialization/vector.hpp"
#include "boost/serialization/string.hpp"

#ifndef MULTI_PROCESSING
#define MULTI_PROCESSING

#define MULTI_PROCESS_MAX 4
#define SERV_PORT 8888
const char SERV_IP[] = "127.0.0.1";  //loopback

namespace Custom
{   
    
    

    class MultiProcessing{

    private:
        bool* end_flag;

        int serv_sock;    //socket server
        int descriptor;     //디스크립터 저장
        int maxds;
        int accept_value;
        std::vector<int> cli_socket;  //접속 가능 프로세스
        std::vector<bool> can_work_process_flag;    //일할 수 있는 프로세스 
        std::vector<Queue_state> processing_state; 
        int clnt_sock;                      //client socket

        struct sockaddr_in serv_addr;
        struct sockaddr_in clnt_addr;
        socklen_t clnt_addr_size;
        int process_num;

        fd_set fs_stat;

        std::string read_str;

        timeval timeout;
        /* params */


        std::queue<Queue_state>* que;
        std::vector<int>* processing_result;


    public:
     MultiProcessing(std::queue<Queue_state>& use_queue, std::vector<int>& use_result, bool& flag);
     ~MultiProcessing();

     void RunMultiProcessing();

    };

}   //close namespace

#endif