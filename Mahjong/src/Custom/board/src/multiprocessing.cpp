#include "board/multiprocessing.h"

using namespace std;

namespace Custom
{

    
    MultiProcessing::MultiProcessing(std::queue<Queue_state>& use_queue, std::vector<int>& result, bool& flag) {
        que = &use_queue;
        processing_result = &result;
        end_flag = &flag;
        process_num = 0;
        // for (int i = 0; i < MULTI_PROCESS_MAX; i++) {  //init cli_socket
        //     cli_socket[i] = -1;
        // }

        char buf[1024] = "Hello";
        string buff = "hello";

        serv_sock = socket(PF_INET, SOCK_STREAM, 0);  //make socket server
        if(serv_sock == -1){
            std::cout<<"socket() error"<<endl;
            return;
        }

        memset(&serv_addr, 0, sizeof(serv_addr));
        serv_addr.sin_family = AF_INET;
        serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);  //host to network
        serv_addr.sin_port = htons(SERV_PORT);   //port server

        if(bind(serv_sock,(struct sockaddr*)&serv_addr,sizeof(serv_addr))==-1){  //bind
            std::cout<<"bind() error"<<endl;
            return;
        }

        if(listen(serv_sock,MULTI_PROCESS_MAX)==-1){ //listen
            std::cout<<"listen() error"<<endl;
            return;
        }

        
    }
    MultiProcessing::~MultiProcessing(){
        for (int i = 0; i < cli_socket.size(); i++) {
            close(cli_socket[i]);
        }
        close(serv_sock);
    }

    void MultiProcessing::RunMultiProcessing() {  //run multiprocessing

        //set fd_set
        FD_ZERO(&fs_stat);
        FD_SET(serv_sock, &fs_stat);
        timeout.tv_sec = 0;
        timeout.tv_usec = 500;

        for (int i = 0; i < process_num; i++) {  //접속 인원 체크
            if (cli_socket[i] != -1){
                FD_SET(cli_socket[i], &fs_stat);
            }
        }
        if (select(serv_sock+MULTI_PROCESS_MAX+1, &fs_stat, NULL, NULL, &timeout) == -1) {  //select
            std::cout << "error select" << endl;
            return;
        }
        if (1==FD_ISSET(serv_sock, &fs_stat)) {  //receive accept
            std::cout<<"Accept"<<endl;
            clnt_addr_size = sizeof(clnt_addr);
            clnt_sock = accept(serv_sock, (struct sockaddr*)&clnt_addr, &clnt_addr_size);   //accept

            if(clnt_sock == -1){    //accept error
                std::cout<<"accept error"<<endl;
                return;
            }
            else{
                if(process_num<4){
                    std::cout<<"insert"<<endl;

                    cli_socket.push_back(clnt_sock);        //init sock container
                    can_work_process_flag.push_back(false);
                    Queue_state temp;
                    temp.result_num = -1;
                    processing_state.push_back(temp);

                    std::cout<<clnt_sock<<endl;
                    process_num++;
                }
                else{
                    std::cout<<"process 초과"<<endl;
                }
                return;
            }
        }

        for (int i = 0; i < process_num; i++) { //프로세스에서 들어온 것 검색
            if(1==FD_ISSET(cli_socket[i], &fs_stat)){   //read  프로세스 완료 여부
                char read_buf[3076];
                int str_len = read(cli_socket[i], read_buf, 7152 - 1);
                read_buf[str_len] = 0;
                read_str = read_buf;
                std::cout<<read_str<<endl;
                processing_result->at(processing_state[i].result_num) = stoi(read_str); //결과 저장
                processing_state[i].result_num = -1;

                can_work_process_flag[i] = false;   //유휴 상태
            }
        }

        int i;
        while(!que->empty()){       //queue가 있으면 가능한 프로세스에게 전달
            for(i = 0;i<cli_socket.size();i++){
                if(can_work_process_flag[i] == false){
                    std::ostringstream oss;
                    boost::archive::text_oarchive text_oa(oss); //직렬화
                    text_oa << que->front();

                    write(cli_socket[i], oss.str().c_str(), oss.str().size());  //전송 프로세스에게
                    cout<<oss.str()<<endl;
                    can_work_process_flag[i] = true;    //프로세스 일하는 중 
                    processing_state[i] = que->front(); //일하는 일 저장
                    que->pop(); //큐제거
                    continue;
                } 
                break;
            }
            if (i == cli_socket.size()) //전부다 사용중이면 넘김
                break;
        }
    }

        

}   //close namespace
