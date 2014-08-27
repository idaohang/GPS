function result = getPosLS2(SatPos, R , SatCorr, ReceiverPos_0)
% 각 변수는 32행의 데이터를 받는다
% SatPos : 위성 위치 데이터 x,y,z
% R : 위성과 수신기 사이의 거리
% SatCorr : clock bias
% ReceiverPos_0 : 수신기 초기의 위치값



if nargin < 4
    ReceiverPos_0 = zeros(1,4);
end

% 변수 초기화 및 세팅
del = SatCorr;
PresentPosition = ReceiverPos_0'; % 받는 행렬에 따라 transpose 결정을 해주어야 한다,

A = zeros(32,4);
l = zeros(32,1);
rho_0 = zeros(32,1);
Error = zeros(1,4);
%변수 세팅
c(1:32,1) = 1;
tol = 0.01; % tolerence

% 코드 시작
while(1)
    
    recentPosition = PresentPosition;
    
    for i = 1:32
        if(R(i) && SatCorr(i) && SatPos(i,1) && SatPos(i,2) && SatPos(i,3))
            rho_0(i) = sqrt( (SatPos(i,1) - recentPosition(1)).^2 + (SatPos(i,2)- recentPosition(2)).^2 + (SatPos(i,3) - recentPosition(3)).^2);
            A(i, 1) = - ( (SatPos( i, 1) - recentPosition(1) )/ rho_0(i) );
            A(i, 2) = - ( (SatPos( i, 2) - recentPosition(2) )/ rho_0(i) );
            A(i, 3) = - ( (SatPos( i, 3) - recentPosition(3) )/ rho_0(i) );
            A(i, 4) = c(i);
            l(i) = R( i ) - rho_0(i) + del( i );
        end
    end

    delta_x = pinv(A' * A) * A' * l ;
    PresentPosition = recentPosition + delta_x(1:4);
    % PresentPosition이 열함수 이므로 결과값을 행으로 쌓으려면 추후에 transpose 해주어야 한다.

    for i=1:4
        Error(i) = recentPosition(i) - PresentPosition(i);
    end
    
    if (Error(1) <= tol) && (Error(2) <= tol) && (Error(3) <= tol) && (Error(4) <= tol)
        break;
    end
    
end
%result = A;
result = PresentPosition';
end