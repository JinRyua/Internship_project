팩맨 게임을 구현해보는 프로젝트
4명의 ai agent가 1명의 플레이어를 잡는 게임
popf를 사용하지 않고 직접 코드를 작성하여 csp와 비슷한 느낌으로 플랜을 작성

노드 설명
rosplan
기본적인 구조는 popf(pddl)이므로 domain,problem이 있으며, 이를 kb에 저장하고 planner가 이를 읽어 변환한 뒤, 코드를 이용하여 가야할 곳을 계산한뒤 dispatch
=> 새롭게 rosplan_planning_system에 CSPPlannerInterface.cpp로 플래너 인터페이스 구현
dispatch되는 내용은 누가 어디로 가

ai_agent 	ai_manager에게서 이동 plan을 dispatch를 받아 action을 수행 
		grid cell 중심에 도착하면 그 위치를 kb에 등록
		board에게는 움직일 때마다(frame) 위치 전송
ai_manager	dispatch받은 agent의 현재 위치와 목적지를 가지고 astar 알고리즘을 통해 구체적 플랜을 만든
		뒤 각각의 ai_agent들에게 플랜을 dispatch

board		전체적인 게임의 관리를 하고 있음 
		display에게 게임 상태를 전송하여 출력하게 함 
		player에게 어디로 가고싶다 는 내용을 받아 가능한지 체크 해줌
		player와 ai에게 어디에 있다는 정보를 받아 상태 update
		별을 먹는 기능(작은별,큰별) 별을 먹었을 때마다, 상태 KB에 update해줌
		작은 별은 점수 오르고, 큰별은 유령화가 됨 
		충돌 체크도 board가 함
		주기적으로 replanner가 상태를 달라고 할 때 상태를 줌
		아니면 갑작스럽게 replanning이 필요해지면 (충돌 이벤트) replanner에게 자발적으로도 상태전송 
		
navi		다익스트라 알고리즘을 이용하여 dist_mat을 만들고, ai_manager가 물어보는 자세한 경로 플랜을 제공
		
player		플레이어가 자동적으로 이동
		키보드(방향키) 입력을 받아 저장하고 다음 프레임때 board에게 물어봐 이동방향을 바꿔서 이동
		ai_agent와 마찬가지로 grid cell 중심에 도착할 때마다 KB에 update

display		현재 사용되지 않음 => js를 이용하여 웹에서 구현 -> board에게서 받은 정보를 가지고 그림을 그려주는 노드
		js를 이용하므로 roslib.js가 따로 필요

replanner	board에게서 상태를 요구하여 받거나, 그냥 받았을 때 리플래닝이 필요한 상황인지 체크하고, 맞으면 현 상태를 update 하여 replanning을 수행하게 함


구현된 기능
	js와 canvas를 이용한 웹상에서의 display 구현 
	작은별, 큰별 구현 및 먹었을 때의 효과 구현
	플레이어와 ai는 벽을 넘어 이동할 수 없게하는 기능
	플레이어는 벽쪽으로 방향을 바꿀 수 없음
	리플래닝 상황이어서 ai가 잠시 멈췄을 때는 player도 멈추는 기능
	리플래닝 기능 
	A* 알고리즘을 이용하여 자세한 경로 플랜을 세우는 기능
	자동으로 이동하는 기능, 그 때 벽에 막히면 자동으로 방향을 바꿔주는 기능
	시간의 흐름에 따라 점수가 오르는 기능
	일정 점수에 도달하면 게임이 종료되는 기능
	유령화 기능 => 유령화가 되면 행동이 달라지게 되며(도망), 잡아 먹을 수 있게 되고, 속도가 느려짐
	충돌기능(유령에게 죽어서 게임이 초기위치에서 재시작), (유령화 된 적은 초기위치에서 혼자 재시작)
	ai들은 최대한 플레이어를 포위하여 잡아먹으려고 하게 구현
	중간 양끝 통로를 이동할 수있는 기능
	TIL을 이용하여 KB에 상태 update(미래의 행동)

미구현된 기능
	중간 양끝 통로를 이용할 때 planner에 문제가 생김
	ai_agent가 플랜을 다 마치면 더이상 이동하지 않음
	리플래닝중에도 ai가 정지하여, 플레이어도 같이 짧은 시간동안 정지
	메뉴 화면을 구현하지 못했음 
 
