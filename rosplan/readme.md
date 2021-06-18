rosplan을 이용하여 재난구조 문제 구현
solver는 popf
클래스 개념을 거의 넣지 않고, 전역변수를 많이 사용하여 구현
헤더 또한 구현하지 않음

노드는 display, car_interface, agent_manager, rosplan으로 구현
구조는 wiki에 있음 rosplan이 플랜을 dispatch해주면 agent_manager가 agent(car_interface)들에게 뿌려주고
이를 display에 뿌려줌

구조, 화재 진압 중에는 차가 깜빡임
rosplan을 코드 분석해보았음 
프레임 개념을 넣어 시간에 비례하여 움직이게 하고, 정해진 프레임에 따라서 display하도록함
계산이 정해진 시간을 넘기면 그만큼 보정하여 움직이도록 구현

