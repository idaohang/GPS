
<핵심 목표>
	GPS수신기에서 데이터를 받아 수신기의 위치를 계산해보고, 아두이노 보드에 적용하여 본다.




<세부 목표>
	1. 기본적으로 Stand Alone상태에서 위치좌표를 계산하여본다.  (*구현)
	2. 기지국, 이동국을 두고 DGPS를 사용하여 수신기의 위치좌표를 계산하여 본다. (* 구현)
	3. least square, kalman filter, 각종 알고리즘을 사용하여 오차범위를 분석해 본다. (* 구현)
	4. Stand Alone 상태 일때와, DGPS를 사용한 상태와의 차이점을 분석해본다. (* 구현)
	5. 아두이노 보드에 적용을 시켜 본다. 




<실험 과정>
	1. GPS 수신기를 이용하여 GPS위성 데이터를 받는다.
	2. 받은 데이터를 매트랩 매트릭스 파일로 변환한다.
	3. 변환한 매트릭스 파일을 이용하여 수신기 안테나의 위치를 계산한다. 
	4. 계산한 위치좌표와 참 좌표와 비교해 보고 오차를 분석한다.	
	5. 다른 보정값, 다른 알고리즘(칼만 필터)을 사용하여 1번부터 다시 실험해 본다.	
	6. 기지국, 이동국을 두어 DGPS를 사용하여 다시 실험해 보고 차이점을 비교, 분석한다.




<주어진 데이터의 변환 및 설명>



기본적으로 모든 매트랩 파일은 매트랩 2008a 버전으로 작성하였다.


TruePos_1 = [-3166506.33266562   4279631.13405277   3500981.04586090];   % 기준국 1 의 좌표 (ECEF)
위의 좌표는 Exp_1_1.mat 파일내에 있는 수신기의 참 좌표값 이다.

TruePos_2 = [-3166695.19621868   4279580.73707923   3500872.60130786];	 % 기준국 2 의 좌표
위의 좌표는 Exp_2_2.mat 파일내에 있는 수신기의 참 좌표값 이다.


다음은 매트릭스 파일의 파라미터에 대한 설명이다.

기본적으로 단위는 미터이다.
파일을 보면 1200개의 열이 있는데 1200개의 열은 측정한 시간마다의 데이터를 담고 있다.
각 파라미터마다 행이 32개가 있는데 그 행 번호는 prn 넘버를 뜻하고 있다.

L1Pr		: L1 거리
L1Pr_Std	: L1 거리 표준편차
L1ADR		: L1 반송파 레인지
L1ADR_Std	: L1 반송파 레인지 표준편차
L1Dopp		: L1 도플러 값
CN01		: .
L2Pr		: L2 거리
L2Pr_Std	: L2 거리 표준편차
L2ADR		: L2 반송파 레인지
L2ADR_Std	: L2 반송파 레인지 표준편차
L2Dopp		: L2 도플러 값
CN02		: .
Satpos		: 위성 좌표
SatCorr		: Clock Bias
IonCorr		: 전리층 오차
TroCorr		: .
Week		: 측정한 주
Sec		: 측정한 시간(초)





 - 현재까지 진행중의 실험 설명


Exp_1_1.mat를 이용하여 먼저 정지한 stand alone 상태의 수신기의 위치를 계산하기로 하였다.

getPosLS.m 파일은 StandAlone 상태에서 수신기의 위치좌표를 찾는 함수이다.
getDataLS.m 파일은 Exp_1_1.mat 파일을 읽어들이고 getPos 함수를 호출하여 각 시간마다의 수신기의 좌표값을 계산하는 함수이다.

Textbook은 B.Hoffmann-Wellenhof의 GPS Theory and Practice 5th edition 으로 스터디를 하였다.

또한 8장 Mathmatical models for positioning, 9장 data handling 을 참조하여 코드를 작성 하였다.

사용된 알고리즘은 least square 이며, 매트랩에서 pinv 함수를 사용하였다. L1 거리, Clock 바이어스를 사용하여 위치좌표를 계산하였다.

아래의 기본적인 공식으로부터 시작하여 선형화, 최소자승법을 이용하여 수신기 위치좌표를 구하였다.

Range = sqrt( (GPS_x - Receiver_x)^2 + (GPS_y - Receiver_y)^2 + (GPS_z - Receiver_z)^2 ) + Clock bias

Range 는 수신기와 위성 사이의 거리
GPS_x,y,z 는 위성좌표
Receiver_x,y,z 는 수신기 좌표
Clock bias 는 clock bias 이다. 



 - 결과 분석

xy_error.fig 는 xy좌표의 오차를 나타내고 있다. 빨간색 십자는 정확한 위치를 나타내고 있고, 파란색 점들은 각 시간마다의 x, y (m)만큼의 오차를 나타낸 것이다. 

clock 바이어스만을 보정값으로 사용 하여 3~18미터 사이의 큰 오차를 나타내고 있는 것을 알 수 있다. 



- 앞으로 해야 할 일

Kalman Filter를 이용하여 Least Square를 사용했을때와의 오차의 비교, 계산 성능 분석 (완료)
DGPS 구현 (완료)
아두이노 보드에 올려, Standalone, DGPS 구현 








<DGPS>

1.  DGPS의 개요


DGPS(Differential GPS)는 상대 측위 방식의 GPS 측량기법으로서 이미 알고 있는 기준점 좌표를 이용하여 오차를 일으키는 요소들을 보정하고, 오차를 최대한 줄여서 보다 정확한 위치를 얻기 위한 방식이다.

■ 오차 요소

1) 구조적 요인
	6가지 주요 오차
	- 위성 궤도 오차 : 전달되는 위성궤도 정보 오차
	- 위성 시계 오차 : 전달되는 위성시각 정보 오차
	- 전리층 오차    : GPS 신호의 전리층 통과시 전달 시간 지연 오차
	- 대류권 오차    : GPS 신호의 대류권 통과시 전달 시간 지연 오차
	- 다중 경로 오차 : GPS 신호의 다중 경로에 의한 오차
	- 수신기 오차    : 열 잡음, 안테나 위상 오차, 채널간 간섭오차, S/W오차 등…

2) 위성배치에 의한 기하학적 오차

3) 고의 잡음 (S/A : 2000년 5월 해제)
 



2.  DGPS의 종류


- 정지궤도위성을 이용하는 DGPS
- 지상보정 기준국을 이용하는 DGPS 망


1) 정지 궤도 위성 이용

지구정지궤도 36,000Km 상공의 위성을 사용하여 보정정보를 제공하는 방식으로 광역 지상기준국과 통신위성이라는 두 개의 시스템으로 구성 되어 있으며 지상모니터링 기준국에서 GPS 위성측위신호를 수신하여 제어감시기지국에 데이터를 전송하고 광역 주제어기지국에서는 보정데이터를 생성하여 다시 지상국(위성지구국)을 통하여 지구정지궤도위성으로 전송하고 이 보정데이터를 사용자에게 제공하는 방식이다.
GPS 신호와 동일하게 L1 Signal 을 이용한다.
 
지구정지궤도위성을 이용한 시스템으로는
미국( WAAS, LAAS, OMNISTAR), 일본(MSAS), 유럽의 (EGNOS)가 있다.

 
2) 지상보정국 이용

위치를 알고 있는 기준점에 GPS 수신국을 설치하여 위성신호를 받아 오차를 보정한 후 그 보정 값을 지상의 무선통신망을 통하여 이동체 및 이용자에게 제공하는 방식이며 사용기술과 정해진 면적에 기준국의 수가 많을수록 수 cm까지 오차를 감소시킬 수 있는 처리 방식으로 기준국에 수신된 값을 보정처리하여 이동체 또는 이용자에게 실시간으로 보정값을 전송하는 방식의 실시간 처리방식과 관측을 먼저 행하고 난 후 저장했던 측량자료를 후처리하여 위치를 보정하는 후처리 방식으로 나눈다.
 



3.  DGPS 보정 정보 표준

    RTCA, RTCM의 표준권고안에서 RTCM SC-104표준은 Massage Type을 64개까지 지정할 수 있도록 되어 있으며 GPS 항법
    메세지와 같은 형태의 페리티 알고리즘을 그대로 사용하고 있다. 또한 RTCA표준은 항공기의 SCAT-Ⅰ을 지원하기 위한
    표준으로 주로 VHF를 이용하여 보정신호를 송출하는 시스템이다.
 
1) RTK 보정 정보는 실시간으로 이동체에서 사용하는 방식으로 그 정밀도가 아주 좋다. 이는 미지정수를 결정하지 않고 움직이면서 구한 측정치로 미지정수를 결정함으로서 이동측량을 실시간으로 수행할 수 있는 보정정보이다. 미지정수란 반송파의 위상측정치를 처음 획득하였을 때 알 수 없는 위성과 수신기 사이의 반송파의 파장개수로서 반송파위성측정치를 이용하기 위해서는 미지정수 결정을 선행해야 한다
 
2) DGPS 보정정보 전송 매체로는 중파(283.5~325kHz), VHF, FM 부반송파를 이용한 매체와 이동통신망인 셀룰러, PCS, TRS와 정지궤도위성을 이용한 극초단파대가 있다.
 



4. 우리나라의 DGPS 현황

 
1) 국토 해양부는 해양(11개소의 기준국, 8개소의 감시국) 내륙(6개소의 기준국)을 구축하고 해상중파(285 - 325 kHz) Radio Beacon을 이용하여 200bps의 전송속도와 300W의 송신출력으로 RTCM SC-104 Ver 2.2의 3.5.7.9.16 type을 채택하여 실시간으로 정보를 전송하고 있다.
       내륙 반경 : 80 ~ 100km, 해양 반경 : 185 ~ 200km
      상시 관측소는 국토지리 정보원(44곳)과 한국천문연구원(9곳)이 있다.
 
2) 국내에서도 일본 위성인 MSAS를 이용할 수 있는데, 측량쪽에는 많이 사용되는 듯 하나, 일반 Navi 쪽에는 사용 빈도수가 낮은 거 같다.
     -> 일반 Navigation에 사용되는 저가형 GPS 칩의 경우 수cm의 성능을 요하지 않고, 또한 Chip 성능의 향상 즉, DGPS사용하지 않더라도 만족할 만한 위치를 획득할 수 있어서가 아닐까?

출처 : http://kin.naver.com/open100/detail.nhn?d1id=1&dirId=1&docId=904156&qb=ZGdwcw==&enc=utf8&section=kin&rank=2&search_sort=0&spq=0&pid=gXa9fF5Y7tGssuWRtNsssc--277884&sid=TuF9SpR84U4AACtUBQM
