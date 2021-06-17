#include<iostream>
#include<fstream>
#include<string>
#include<vector>
#include<algorithm>
#include <cstdlib>
#include <ctime>
using namespace std;
 #include <sys/shm.h> 
 #include <sys/ipc.h> 


struct s{
    int aa;
};

int main()
{
    int shmid = shmget((key_t)1234, sizeof(struct s),0666|IPC_CREAT);
    void* shmem = shmat(shmid, (void*)0, 0);
    
    struct s* msg;
    msg = (struct s*) shmem;
    cout<<msg->aa<<endl;
    msg->aa = 0;
    
    return 0;
}