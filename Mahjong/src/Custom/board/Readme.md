ros를 거의 사용하지 않으므로 msg, srv는 아무 파일도 없음 

build하려면 멀티 프로세스 기능때문에 boost의 serialization 라이브러리가 필요함
또한 마작 시뮬레이터의 함수를 사용하기 때문에 https://github.com/critter-mj/akochan의 파일들이 있어야 build가능

src/
	board.cpp	전체적인 게임 기능 구현 및 시뮬레이션 기능, 마작 시뮬레이터와 소켓 통신 기능
			시뮬레이션은 단일 프로세스로 board.cpp만 이용해서 가능하며,
			queue와 result vector를 만들고 multiprocessing.h의 
			multiprocessing class를 이용하여 멀티 프로세스로 시뮬레이션 가능
			이경우 다른 스레드로 빼서 프로세스 관리 기능을 사용	-> 포트 7777

	multiprocessing.cpp
			멀티프로세스 시뮬레이션을 위한 class cpp 
			자체 루프기능은 없으며 따로 무한 루프를 돌려줘야함 
			현재 최대 프로세스 제한은 4개이며, define 값을 바꿔 줄 수 있음
			늦게 소켓을 연결해도 가능하나, 소켓 연결 해지시 처리는 미구현

	simulation_process.cpp
			멀티 프로세스 시뮬레이션을 하기위한 프로세스 생성 cpp용
			기능은 board와 같으며, 시뮬레이션에 포함되지 않는 부분은 없음
			main에서 multiprocessing class와 통신	=> 포트 8888

include/
	board.h		board.cpp의 헤더
	multiprocess.h	multiprocessing.cpp의 헤더
	simulation_process.h	simulation_process.h의 헤더
	types.h		전체적인 데이터 저장에 사용되는 클래스들이 있는 헤더

	
