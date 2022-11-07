load('ts.mat');
%% STD 
A1 = load('C:\Users\yding35\Desktop\Lab\MMN Group Average\Animal Average Data\8 Mon\13765R2CLN31600ms_STD.mat');
ch21STD1 = A1.mSTD(23,:);
A2 = load('C:\Users\yding35\Desktop\Lab\MMN Group Average\Animal Average Data\8 Mon\13765R2CLN31600ms_STD.mat');
ch21STD2 = A2.mSTD(23,:);
A3 = load('C:\Users\yding35\Desktop\Lab\MMN Group Average\Animal Average Data\10 Mon\13763R1CLN31600ms_STD.mat');
ch21STD3 = A3.mSTD(23,:);
A4 = load('C:\Users\yding35\Desktop\Lab\MMN Group Average\Animal Average Data\10 Mon\13763R1CLN31600ms_STD.mat'); 
ch21STD4 = A4.mSTD(23,:);
ch21STD = [ch21STD1;ch21STD2;ch21STD3;ch21STD4];
%% DEV
B1 = load('C:\Users\yding35\Desktop\Lab\MMN Group Average\Animal Average Data\8 Mon\13765R2CLN31600ms_DEV.mat');
ch21DEV1 = B1.mDEV(23,:);
B2 = load('C:\Users\yding35\Desktop\Lab\MMN Group Average\Animal Average Data\8 Mon\13765R2CLN31600ms_DEV.mat');
ch21DEV2 = B2.mDEV(23,:);
B3 = load('C:\Users\yding35\Desktop\Lab\MMN Group Average\Animal Average Data\10 Mon\13763R1CLN31600ms_DEV.mat');
ch21DEV3 = B3.mDEV(23,:);
B4 = load('C:\Users\yding35\Desktop\Lab\MMN Group Average\Animal Average Data\10 Mon\13763R1CLN31600ms_DEV.mat');
ch21DEV4 = B4.mDEV(23,:);
ch21DEV = [ch21DEV1;ch21DEV2;ch21DEV3;ch21DEV4];
%% Average and SEM 
mch21STD = mean(ch21STD);
semch21STD = std(ch21STD)/sqrt(4);
mch21DEV = mean(ch21DEV);
semch21DEV = std(ch21DEV)/sqrt(4);
mch21MMN = mch21DEV - mch21STD;
a=mch21STD+semch21STD;
b=mch21STD-semch21STD;
c=mch21DEV+semch21DEV;
d=mch21DEV-semch21DEV;
%% Plot 
figure; 
subplot(2,1,1);
line([0 0], [-275, 150], 'Color', 'r', 'LineStyle','-', 'LineWidth', 1);
hold on;
plot(ts,mch21STD,'b','LineWidth', 1);
hold on;
plot(ts,mch21DEV,'r','LineWidth', 1);
hold on;
fill([ts(:);flipud(ts(:))],[a(:); flipud(b(:))],'b','facealpha',0.2,'edgecolor','none','facecolor','blue');
hold on;
fill([ts(:);flipud(ts(:))],[c(:); flipud(d(:))],'r','facealpha',0.2,'edgecolor','none','facecolor','red');
hold on;
axis ([-0.05 0.35 -275 150])
xlabel('Time(s)','FontSize',8)
ylabel('ERP(µV)', 'FontSize', 8)
title('9 Mon CLN3 with 1600 ms ISI','FontSize',8);
subplot(2,1,2);
hold on;
line([-0.05 0.35],[0 0],'Color','red','LineStyle','--')
hold on;
plot(ts, mch21MMN, 'color',[0.9290 0.6940 0.1250], 'LineWidth', 1);
axis ([-0.05 0.35 -60 60]);
xlabel('Time(s)','FontSize',8);
ylabel('Difference in ERP(µV)', 'FontSize', 8);
set(gcf, 'Position',[100, 100, 300, 500]);
figure;
plot(ts,ch21STD);
[tstat,corx,orig,stats] = st_tmaxperm(ch21DEV,ch21STD);
figure;
hold on;
plot(ts,tstat);
axis([-0.05 0.35 -80 10]);
line([-0.05 0.35],[-4.3 -4.3],'Color','red','LineStyle','-');
hold off;