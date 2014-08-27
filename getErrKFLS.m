TruePos = [-3166506.33266562   4279631.13405277   3500981.04586090];
Temp = getDataKF();
DataKF = Temp(:,[1 3 5 7]);

DataLS = getDataLS();
N = size(DataKF);

tt = ['X', 'Y', 'Z'];
for ii = 1:3
    subplot(3,1,ii)
    plot(1:1200,DataKF(:,ii)-TruePos(ii),'-r')
    hold on
    plot(1:1200,DataLS(:,ii)-TruePos(ii))
    legend('EKF','LS')
    xlabel('Sampling index')
    label = [tt(ii), '-Position error(meters)'];
    ylabel(label)
end