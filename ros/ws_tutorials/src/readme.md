ros 예제 학습

service를 이용하지 않고 pub,sub 만으로 msg를 스스로 만들어보고 실제 예제를 구현해보면서 학습

ros_tutorials/	ros에 나와있는 tutorial을 따라해본것
chat_client/	ros를 이용하여 채팅 프로그램을 만들어본것
		1대1 통신 기능
		
		/launch		각각 서버, 채터1, 채터2를 만드는 launch
		/diagram	챗 클라이언트 , 구조 설계 
		/src/chatter.cpp	입력을 받고 server와 통신
		/src/server.cpp		채팅 서버
		/src/std_input.cpp	키보드를 입력받아 chatter에게 publish
