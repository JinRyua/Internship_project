스플렌더 게임 구현 및 ai 구현 프로젝트
구현된 기능 
	스플렌더의 전체적인 기능 구현(액션 코인 3,2개 가져가기 카드 사기, 귀족카드)
	액션의 예외 처리도 구현(정상적 액션을 할 수 없을 때)
	터미널로 display 구현 
	log를 볼 수 있는 log_display 구현 
	minimax와 시뮬레이션 두가지 기법으로 planner를 작성
	멀티 스레드를 이용하여 시뮬레이션을 할 수 있도록 구현
	ai와 player 둘 다에게 ai를 붙일 수 있도록 구현
	턴제로 구현됨
	턴이 시작될 때마다 planner를 이용하여 결과를 도출하는 기능
	FSM을 이용하여 구현 
	game을 원하는 대로 만드는 game_generator 구현
	여러번 게임을 자동으로 돌려 승률과 결과를 log로 도출하게 하고 파일로도 저장하게 구현

미구현된 기능
	실제 스플렌더의 기능중 조커 코인은 기능으로 구현하지 않았음 
	minimax에서 사용된 점수 계산 식이 완벽하게 완성된 것은 아님

노드 설명
	board 		전체적인 게임 기능 처리현
			display에게 정보를 보내 출력하게 함
			턴마다 rosplan을 이용하여 플랜을 도출하게하고 ai나 player에게 보내도록 함
			게임 상태를 KB에 update하는 기능

	ai, player	기능은 동일 => rosplan에서 플랜을 받고 이를 board가 알아 들을 수 있게 convert하는 역할

	display 	board에게서 데이터를 받아 terminal에서 display

	rosplan		기존과 동일하게 따로 코드로 작성하여 minimax방식과 monte-carlo simulation 방식으로 가장 나아보이는 plan을 도출하여 각각 연결된 ai 또는 player에게 dispatch
			simulation의 경우 멀티 스레드로 시뮬레이션 하도록 구현되어 있음
			minimax의 경우 하드웨어와 최적화 문제로 depth=3까지 밖에 보지 못함
			minimax의 경우 여러번의 시뮬레이션을 통해 정한 유리함 점수 계산 식을 이용하여 결정

기타 파일 설명 
	planner부분에 있는	MINIMAXPlannerInterface 는 minimax를 이용한 planner
				SIMULATIONPlannerInterface는 멀티 스레드와 simulation을 이용한 planner
	tuto.launch	=> minimax 게임 실행
	simulaton_tuto.launch	=> 시뮬레이션 게임 실행
	problem_generator => 게임상태를 h로 만들어주거나, pddl로 만들어 주는 코드
	log/		게임 결과가 log로 저장됨
		
			
			
