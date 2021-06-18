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
        std::vector<int> cli_socket;  //접속 가능 프로세스
        std::vector<bool> can_work_process_flag;    //일할 수 있는 프로세스 
        std::vector<Queue_state> processing_state; //프로세스에 지정된 일
        int clnt_sock;                      //client socket

        struct sockaddr_in serv_addr;       //소켓 통신을 위한 구조체
        struct sockaddr_in clnt_addr;
        socklen_t clnt_addr_size;

        int process_num;        //연결 프로세스 개수

        fd_set fs_stat;         //select를 위한 fd_set

        std::string read_str;   //read buffer

        timeval timeout;        //select timeval


        std::queue<Queue_state>* que;           //해야할 일 queue
        std::vector<int>* processing_result;    //결과 저장할 vector


    public:
     MultiProcessing(std::queue<Queue_state>& use_queue, std::vector<int>& use_result, bool& flag);
     ~MultiProcessing();

     void RunMultiProcessing();     //멀티 프로세싱 기능

    };

}   //close namespace

#endif