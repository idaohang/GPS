function result = getPRC(SatPos, R, SatCorr)

% �� ������ 32���� �����͸� �޴´�
% �ð� ��� ���� : PRC(t) = PRC(t_0) + PRC(t_0)*(t-t_0)
% SatPos : ���� ��ġ ������ x,y,z
% R : ������ ���ű� ������ �Ÿ�
%TruePos : ���ر� ��ǥ, ��Ŀ� ���� transpose ������ ���־�� �Ѵ�,
%TruePos = [-3166506.33266562   4279631.13405277   3500981.04586090]'; %Exp_1_1 ��ǥ

TruePos = [-3166695.19621868   4279580.73707923   3500872.60130786]'; %Exp_2_2 ��ǥ

%���� ����
PRC = zeros(32,1);
% �ڵ� ����

for i = 1:32
    if(R(i) && SatPos(i,1) && SatPos(i,2) && SatPos(i,3))
        rho = sqrt( (SatPos(i,1) - TruePos(1)).^2 + (SatPos(i,2)- TruePos(2)).^2 + (SatPos(i,3) - TruePos(3)).^2);
        PRC(i) = rho - R(i) - SatCorr(i);
    end
end

result = PRC;


end