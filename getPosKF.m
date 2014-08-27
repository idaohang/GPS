function [X P] = getPosKF(Satpos, PseudoRange, SatCorr, x, p)
%{
    Satpos : 32*4, 위성 위치좌표 x,y,z
    PseudoRange : 의사거리
    SatCorr : 32*1, 위성 시계보정값
    X, x : [x, Vx, y, Vy, z, Vz, b, d]
%}

S_f = 36;
S_g = 0.01;
sigma = 5;
deltat = 1;


if nargin<5
    x = [-3166509 0 4279640 0 3500988 0 1228492 0];
    deltat = 1;
    %P 계산
    p = eye(8)*10;
end

%의사거리, 위성 위치좌표와 시계보정값 재구성
cnt = 0;
for i=1:32
    if Satpos(i,1)&&Satpos(i,2)&&Satpos(i,3)&&SatCorr(i) ~=0
        cnt = cnt +1;
    end
end
Satcnt = cnt;
SatXYZ = zeros(Satcnt,3);
%R = zeros(Satcnt,1);
  % Set R
    Rhoerror = 36;                                               % variance of measurement error(pseudorange error)
    R=eye(Satcnt) * Rhoerror; 

z = zeros(Satcnt,1);
cnt = 1;
for i=1:32
    if Satpos(i,1)&&Satpos(i,2)&&Satpos(i,3)&&SatCorr(i) ~=0
        SatXYZ(cnt,1) = Satpos(i,1);
        SatXYZ(cnt,2) = Satpos(i,2);
        SatXYZ(cnt,3) = Satpos(i,3);
        z(cnt,1) = PseudoRange(i)+SatCorr(i);
        cnt = cnt +1;
    end
end
PosXYZ = zeros(3,1);
cnt =1;
for i=1:2:5
    PosXYZ(cnt) = x(i);
    cnt = cnt+1; 
end

%행렬 A 계산
a = [1, deltat ; 0, 1];
A = blkdiag(a, a, a, a);

%Q 계산
Q_b = [S_f*deltat+(S_g*deltat^3)/3, S_g*(deltat^2)/2; S_g*(deltat^2)/2, S_g];
Q_xyz = sigma^2.*[(deltat^3)/3, (deltat^2)/2; (deltat^2)/2, 1];
Q = blkdiag(Q_xyz, Q_xyz, Q_xyz, Q_b);

%H 계산
H = zeros(Satcnt, 8);
for i=1:Satcnt
    k = 1;
    for j =1:2:5
        H(i, j) = (x(j)-SatXYZ(i,k))/z(i);
        k = k+1;
    end
    H(i,7) = 1;
end


%칼만필터 알고리즘
xp = x';

Pp = A*p*(A')+Q;
K = Pp*H'*inv(H*Pp*H.'+R);

X = xp+K*(z-fx(PosXYZ, SatXYZ));
X = X';
P = Pp - K*H*Pp;


%의사거리 계산함수 fx
    function fxResult = fx(fxPos, fxSatpos)

        fxSatcnt = size(fxSatpos);
        fxRho = zeros(fxSatcnt(1),1);
        for fxi=1:fxSatcnt(1)
            fxRho(fxi) = sqrt( (fxSatpos(fxi,1) - fxPos(1))^2 + (fxSatpos(fxi,2) - fxPos(2))^2 + (fxSatpos(fxi,3) - fxPos(3))^2 );
        end
        fxResult = fxRho;
        %end of fx
    end

% end of getPosKF
end



