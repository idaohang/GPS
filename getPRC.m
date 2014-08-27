function result = getPRC(SatPos, R, SatCorr)

% 각 변수는 32행의 데이터를 받는다
% 시간 고려 안함 : PRC(t) = PRC(t_0) + PRC(t_0)*(t-t_0)
% SatPos : 위성 위치 데이터 x,y,z
% R : 위성과 수신기 사이의 거리
%TruePos : 기준국 좌표, 행렬에 따라 transpose 결정을 해주어야 한다,
%TruePos = [-3166506.33266562   4279631.13405277   3500981.04586090]'; %Exp_1_1 좌표

TruePos = [-3166695.19621868   4279580.73707923   3500872.60130786]'; %Exp_2_2 좌표

%변수 세팅
PRC = zeros(32,1);
% 코드 시작

for i = 1:32
    if(R(i) && SatPos(i,1) && SatPos(i,2) && SatPos(i,3))
        rho = sqrt( (SatPos(i,1) - TruePos(1)).^2 + (SatPos(i,2)- TruePos(2)).^2 + (SatPos(i,3) - TruePos(3)).^2);
        PRC(i) = rho - R(i) - SatCorr(i);
    end
end

result = PRC;


end