function result = getDataLS()

% ������ ���� �ε�, ������ ũ�� ���ϱ�
load('Exp_1_1.mat', '-mat');
[nDummy, nMatfileSize] = size(Exp_1_1); %#ok<NASGU>

% ���� �ʱ�ȭ
result = zeros(nMatfileSize,4);

% �ڵ� ����
for i=1:nMatfileSize
%     result(i,:) = getPosLS(Exp_1_1(1,i).Satpos, Exp_1_1(1,i).L1Pr, Exp_1_1(1,i).SatCorr);
    if i==1
        result(i,:) = getPosLS(Exp_1_1(1,i).Satpos, Exp_1_1(1,i).L1Pr, Exp_1_1(1,i).SatCorr);
    else
        result(i,:) = getPosLS(Exp_1_1(1,i).Satpos, Exp_1_1(1,i).L1Pr, Exp_1_1(1,i).SatCorr, result(i-1,:));
    end
end

end
