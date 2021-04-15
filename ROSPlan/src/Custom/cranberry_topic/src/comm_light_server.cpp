// ~/catkin_ws/src/cranberry_topic/src/comm_light_server.cpp
// Written 2020-10-09 by whiteknight
// https://whiteknight3672.tistory.com
 
#include "ros/ros.h" // ROS 기본 헤더파일
#include "cranberry_topic/CommLight.h" // CommLight.srv 파일 헤더 (빌드 후 자동 생성됨)
 
int light[4] = {0,}; // 추후를 대비해 light 개수를 4개로 잡았습니다.
 
bool lightCallback(cranberry_topic::CommLight::Request &req, cranberry_topic::CommLight::Response &res){
    ROS_INFO("target : %d", req.target);
    ROS_INFO("state : %d", req.state);
    light[req.target -1] = req.state; // 받은 req.target에 해당하는 req.state를 저장합니다.
    res.result = light[req.target -1]; // 성공적으로 저장된 경우, 값을 반환합니다.
    return true;
}
 
int main(int argc, char **argv) // 노드 메인 함수
{
	ros::init(argc,argv,"comm_light"); // comm_light이름을 가진 node 생성
	ros::NodeHandle nh;
    
    ros::ServiceServer service = nh.advertiseService("comm_light", lightCallback); // comm_light 이름의 서비스와, 수행할 함수를 설정
    ROS_INFO("Ready to Send Callback : CommLightServer."); // 콘솔에 표시
 
    ros::spin(); // 값 대기
	return 0;   
}
