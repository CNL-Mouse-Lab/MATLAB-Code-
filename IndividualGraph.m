load('ts.mat');
load('C:\Users\yding35\Box\TDT\MMN Data\5 Mon\13763R1CLN3400ms_STD.mat');
load('C:\Users\yding35\Box\TDT\MMN Data\5 Mon\13763R1CLN3400ms_DEV.mat');
STD = meanAllST(:,:);
DEV = meanAllDEV(:,:);
MMN = DEV - STD;
figure; 
subplot(2,1,1);
line([0 0], [-275, 150], 'Color', 'r', 'LineStyle','-', 'LineWidth', 1);
hold on;
plot(ts,STD(21,:),'b','LineWidth', 1);
hold on;
plot(ts,DEV(21,:),'r','LineWidth', 1);
hold on;
axis ([-0.05 0.35 -275 150])
xlabel('Time(s)','FontSize',8)
ylabel('ERP(µV)', 'FontSize', 8)
title('13763R1CLN3 with 400ms ISI','FontSize',8);
subplot(2,1,2);
hold on;
line([-0.05 0.35],[0 0],'Color','r','LineStyle','--')
hold on;
plot(ts, MMN(21,:), 'color',[0.9290 0.6940 0.1250], 'LineWidth', 1);
axis ([-0.05 0.35 -60 60]);
xlabel('Time(s)','FontSize',8);
ylabel('Difference in ERP(µV)', 'FontSize', 8);
set(gcf, 'Position',[100, 100, 300, 500]);
[tstat,corx,orig,stats] = st_tmaxperm(STD,DEV);