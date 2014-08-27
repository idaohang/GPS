function result = getDataDGPS()

% ������ ���� �ε�, ������ ũ�� ���ϱ�
load('Exp_1_1.mat', '-mat');
load('Exp_2_2.mat', '-mat');
[nDummy, nMatfileSize] = size(Exp_1_1); %#ok<NASGU>

% ���� �ʱ�ȭ
result = zeros(nMatfileSize,4);

% �ڵ� ����
for i=1:nMatfileSize
%     result(i,:) = getPosLS(Exp_1_1(1,i).Satpos, Exp_1_1(1,i).L1Pr, Exp_1_1(1,i).SatCorr);
    if i==1
        PRC = getPRC(Exp_2_2(1,i).Satpos, Exp_2_2(1,i).L1Pr, Exp_2_2(1,i).SatCorr);
        result(i,:) = getDPosLS(Exp_1_1(1,i).Satpos, Exp_1_1(1,i).L1Pr, Exp_1_1(1,i).SatCorr, PRC);
    else
        PRC = getPRC(Exp_2_2(1,i).Satpos, Exp_2_2(1,i).L1Pr, Exp_2_2(1,i).SatCorr);
        result(i,:) = getDPosLS(Exp_1_1(1,i).Satpos, Exp_1_1(1,i).L1Pr, Exp_1_1(1,i).SatCorr, PRC, result(i-1,:));
    end
end

end
