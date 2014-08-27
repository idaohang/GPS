function result = getDataDGPS()

% 데이터 파일 로딩, 데이터 크기 구하기
load('Exp_1_1.mat', '-mat');
load('Exp_2_2.mat', '-mat');
[nDummy, nMatfileSize] = size(Exp_1_1); %#ok<NASGU>

% 변수 초기화
result = zeros(nMatfileSize,4);

% 코드 시작
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
