function result = getDataKF()

% ������ ���� �ε�, ������ ũ�� ���ϱ�
load('Exp_1_1.mat', '-mat');
[nDummy, nMatfileSize] = size(Exp_1_1); %#ok<NASGU>

% ���� �ʱ�ȭ
X = zeros(nMatfileSize,8);
P = cell(nMatfileSize, 1);
% �ڵ� ����
for i=1:nMatfileSize
%     result(i,:) = getPosLS(Exp_1_1(1,i).Satpos, Exp_1_1(1,i).L1Pr, Exp_1_1(1,i).SatCorr);
    if i==1
        [X(i,:) P{i}] = getPosKF(Exp_1_1(1,i).Satpos, Exp_1_1(1,i).L1Pr, Exp_1_1(1,i).SatCorr);
    else
        [X(i,:) P{i}] = getPosKF(Exp_1_1(1,i).Satpos, Exp_1_1(1,i).L1Pr, Exp_1_1(1,i).SatCorr, X(i-1,:), P{i-1});
    end
end
result = X;
end