%% Load Data 
A = readtable('C:\Users\yding35\Desktop\N1 Amplitude Excel.xlsx');
t = table2array(A);
% N1 Variable 
AgeCLN3400msISI = t(1:12,2);
AgeCLN3800msISI = t(13:24,2);
AgeCLN31600msISI = t(25:36,2);
AgeWT400msISI = t(37:50,2);
AgeWT800msISI = t(51:64,2);
AgeWT1600msISI = t(65:78,2);
% N1 Variable 
N1CLN3400msISI = t(1:12,4);
N1CLN3800msISI = t(13:24,4);
N1CLN31600msISI = t(25:36,4);
N1WT400msISI = t(37:50,4);
N1WT800msISI = t(51:64,4);
N1WT1600msISI = t(65:78,4);
%% Plotting 
figure;
hold on;
scatter(AgeCLN3400msISI,N1CLN3400msISI,'filled');
scatter(AgeWT400msISI,N1WT400msISI,'filled');
hold off; 
xlabel('Age (month)','FontSize',12);
ylabel('ERP(µV)', 'FontSize', 12);
title('N1 Amplitude 400 ms ISI Scatter Plot','FontSize',12);
figure;
hold on; 
scatter(AgeCLN3800msISI,N1CLN3800msISI,'filled');
scatter(AgeWT800msISI,N1WT800msISI,'filled');
hold off;
xlabel('Age (month)','FontSize',12);
ylabel('ERP(µV)', 'FontSize', 12);
title('N1 Amplitude 800 ms ISI Scatter Plot','FontSize',12);
figure; 
hold on; 
scatter(AgeCLN31600msISI,N1CLN31600msISI,'filled');
scatter(AgeWT1600msISI,N1WT1600msISI,'filled');
hold off; 
xlabel('Age (month)','FontSize',12);
ylabel('ERP(µV)', 'FontSize', 12);
title('N1 Amplitude 1600 ms ISI Scatter Plot','FontSize',12);