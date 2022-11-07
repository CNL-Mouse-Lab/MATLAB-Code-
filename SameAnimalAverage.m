%% Load Data
%session 1 
A1 = load('/Users/gracerico/Downloads/9MoCTNSKO-old/13846CTNSKO1600ms_ST1.mat');
STD1 = A1.meanAllST;
B1 = load('/Users/gracerico/Downloads/9MoCTNSKO-old/13846CTNSKO1600ms_DEV1.mat');
DEV1 = B1.meanAllDEV;
% session 2 
A2 = load('/Users/gracerico/Downloads/9MoCTNSKO-old/13846CTNSKO1600ms_ST2.mat');
STD2 = A2.meanAllST;
B2 = load('/Users/gracerico/Downloads/9MoCTNSKO-old/13846CTNSKO1600ms_DEV2.mat');
DEV2 = B2.meanAllDEV;
% session 3 
A3 = load('/Users/gracerico/Downloads/9MoCTNSKO-old/13846CTNSKO1600ms_ST3.mat');
STD3 = A3.meanAllST;
B3 = load('/Users/gracerico/Downloads/9MoCTNSKO-old/13846CTNSKO1600ms_DEV3.mat');
DEV3 = B3.meanAllDEV;
%% Same Animal Average 
DEV = cat(3,DEV1,DEV2);
STD = cat(3,STD1,STD2);
meanDEV = mean(DEV,3);
meanSTD = mean(STD,3);
meanMMN = meanDEV - meanSTD;
%% Mean and SEM
ch21STD1 = STD1(21,:);
ch21STD2 = STD2(21,:);
ch21STD = [ch21STD1;ch21STD2];
ch21DEV1 = DEV1(21,:);
ch21DEV2 = DEV2(21,:);
ch21DEV = [ch21DEV1;ch21DEV2];
mch21STD = mean(ch21STD);
mch21DEV = mean(ch21DEV);
mch21MMN = mch21DEV - mch21STD;
n = size(ch21DEV,1);
semch21STD = std(ch21STD)/sqrt(n);
semch21DEV = std(ch21DEV)/sqrt(n);
a=mch21STD+semch21STD;
b=mch21STD-semch21STD;
c=mch21DEV+semch21DEV;
d=mch21DEV-semch21DEV;
%% Plot 
figure; 
subplot(2,1,1);
line([0 0], [-300, 150], 'Color', 'r', 'LineStyle','-', 'LineWidth', 1);
hold on;
plot(ts,mch21STD,'b','LineWidth', 1);
hold on;
plot(ts,mch21DEV,'r','LineWidth', 1);
hold on;
fill([ts(:);flipud(ts(:))],[a(:); flipud(b(:))],'b','facealpha',0.2,'edgecolor','none','facecolor','blue');
hold on;
fill([ts(:);flipud(ts(:))],[c(:); flipud(d(:))],'r','facealpha',0.2,'edgecolor','none','facecolor','red');
hold on;
axis ([-0.05 0.35 -300 150])
xlabel('Time(s)','FontSize',8)
ylabel('ERP(µV)', 'FontSize', 8)
title('9 Mon CTNS with 1600 ms ISI','FontSize',8);
subplot(2,1,2);
hold on;
line([-0.05 0.35],[0 0],'Color','red','LineStyle','--')
hold on;
plot(ts, mch21MMN, 'color',[0.9290 0.6940 0.1250], 'LineWidth', 1);
axis ([-0.05 0.35 -60 60]);
xlabel('Time(s)','FontSize',8);
ylabel('Difference in ERP(µV)', 'FontSize', 8);
set(gcf, 'Position',[100, 100, 300, 500]);
%[tstat,corx,orig,stats] = st_tmaxperm(ch21DEV,ch21STD);