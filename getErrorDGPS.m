function result = getErrorDGPS()
CalcPos = getDataDGPS();
TruePos = [-3166506.33266562   4279631.13405277   3500981.04586090];

result = zeros(1200,3);

result(:,1) = CalcPos(:,1) - TruePos(1);
result(:,2) = CalcPos(:,2) - TruePos(2);
result(:,3) = CalcPos(:,3) - TruePos(3);

end