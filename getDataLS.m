function result = getDataLS()

% 데이터 파일 로딩, 데이터 크기 구하기
load('Exp_1_1.mat', '-mat');
[nDummy, nMatfileSize] = size(Exp_1_1); %#ok<NASGU>

% 변수 초기화
result = zeros(nMatfileSize,4);

% 코드 시작
for i=1:nMatfileSize
%     result(i,:) = getPosLS(Exp_1_1(1,i).Satpos, Exp_1_1(1,i).L1Pr, Exp_1_1(1,i).SatCorr);
    if i==1
        result(i,:) = getPosLS(Exp_1_1(1,i).Satpos, Exp_1_1(1,i).L1Pr, Exp_1_1(1,i).SatCorr);
    else
        result(i,:) = getPosLS(Exp_1_1(1,i).Satpos, Exp_1_1(1,i).L1Pr, Exp_1_1(1,i).SatCorr, result(i-1,:));
    end
end

end
