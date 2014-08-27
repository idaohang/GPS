function result = getPosLS(SatPos, R , SatCorr, ReceiverPos_0)
% �� ������ 32���� �����͸� �޴´�
% SatPos : ���� ��ġ ������ x,y,z
% R : ������ ���ű� ������ �Ÿ�
% SatCorr : clock bias
% ReceiverPos_0 : ���ű� �ʱ��� ��ġ��



if nargin < 4
    ReceiverPos_0 = zeros(1,4);
end

% ���� �ʱ�ȭ �� ����
del = SatCorr;
PresentPosition = ReceiverPos_0'; % �޴� ��Ŀ� ���� transpose ������ ���־�� �Ѵ�,
nSizeOfA = 0; % �����͸� ������ �ִ� ������ ����
nAlivePRN = zeros(32,1); % 1~nSizeOfA���� prn �ѹ��� ����� 
for i = 1:32
    if(R(i) && SatCorr(i) && SatPos(i,1) && SatPos(i,2) && SatPos(i,3))
        nSizeOfA = nSizeOfA +1;
        nAlivePRN(nSizeOfA) = i;
    end
end
A = zeros(nSizeOfA);
l = zeros(nSizeOfA,1);
rho_0 = zeros(nSizeOfA,1);
Error = zeros(1,4);
%���� ����
c(1:nSizeOfA,1) = 1;
tol = 0.01; % tolerence

% �ڵ� ����
while(1)
    
    recentPosition = PresentPosition;
    
    for i = 1:nSizeOfA
        rho_0(i) = sqrt( (SatPos(nAlivePRN(i),1) - recentPosition(1)).^2 + (SatPos(nAlivePRN(i),2)- recentPosition(2)).^2 + (SatPos(nAlivePRN(i),3) - recentPosition(3)).^2);
        A(i, 1) = - ( (SatPos( nAlivePRN(i), 1) - recentPosition(1) )/ rho_0(i) );
        A(i, 2) = - ( (SatPos( nAlivePRN(i), 2) - recentPosition(2) )/ rho_0(i) );
        A(i, 3) = - ( (SatPos( nAlivePRN(i), 3) - recentPosition(3) )/ rho_0(i) );
        A(i, 4) = c(i);
        l(i) = R( nAlivePRN(i) ) - rho_0(i) + del( nAlivePRN(i) );
    end

    delta_x = pinv(A' * A) * A' * l ;
    PresentPosition = recentPosition + delta_x(1:4);
    % PresentPosition�� ���Լ� �̹Ƿ� ������� ������ �������� ���Ŀ� transpose ���־�� �Ѵ�.

    for i=1:4
        Error(i) = recentPosition(i) - PresentPosition(i);
    end
    
    if (Error(1) <= tol) && (Error(2) <= tol) && (Error(3) <= tol) && (Error(4) <= tol)
        break;
    end
    
end

result = PresentPosition';
end