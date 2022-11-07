%import excel into a table%
A = readtable('07022021_WT_ABR_0_1_1_1.csv','range','A3:BWB516');
B = readtable('07022021_WT_ABR_0_2_1_1.csv','range','A3:BWB516');
C = readtable('07022021_WT_ABR_0_3_1_1.csv','range','A3:BWB516');
D = readtable('07022021_WT_ABR_0_4_1_1.csv','range','A3:BWB516');
E = readtable('07022021_WT_ABR_0_5_1_1.csv','range','A3:BWB516');
F = readtable('07022021_WT_ABR_0_6_1_1.csv','range','A3:BWB516');
G = readtable('07022021_WT_ABR_0_7_1_1.csv','range','A3:BWB516');
H = readtable('07022021_WT_ABR_0_8_1_1.csv','range','A3:BWB516');
%converge to vector%
m1 = table2array(A);
m2 = table2array(B);
m3 = table2array(C);
m4 = table2array(D);
m5 = table2array(E);
m6 = table2array(F);
m7 = table2array(G);
m8 = table2array(H);
%Average%
ColumnMean1 = mean(m1,1);
ColumnMean2 = mean(m2,1);
ColumnMean3 = mean(m3,1);
ColumnMean4 = mean(m4,1);
ColumnMean5 = mean(m5,1);
ColumnMean6 = mean(m6,1);
ColumnMean7 = mean(m7,1);
ColumnMean8 = mean(m8,1);
%Plot%
subplot(8,1,1);
plot(ColumnMean1);
title('90dB','Position',[2000,3*10^-6]);
set(gca,'xlim',[0 2000]);
set(gca,'ylim',[-5*10^-6 3*10^-6]);
ylabel('Amplitude (volt)','FontSize',16);
subplot(8,1,2);
plot(ColumnMean2);
title('80dB','Position',[2000,3*10^-6]);
set(gca,'xlim',[0 2000]);
set(gca,'ylim',[-5*10^-6 3*10^-6]);
subplot(8,1,3);
plot(ColumnMean3);
title('70dB','Position',[2000,3*10^-6]);
set(gca,'xlim',[0 2000]);
set(gca,'ylim',[-5*10^-6 3*10^-6]);
subplot(8,1,4);
plot(ColumnMean4);
title('60dB','Position',[2000,3*10^-6]);
set(gca,'xlim',[0 2000]);
set(gca,'ylim',[-5*10^-6 3*10^-6]);
subplot(8,1,5);
plot(ColumnMean5);
title('50dB','Position',[2000,3*10^-6]);
set(gca,'xlim',[0 2000]);
set(gca,'ylim',[-5*10^-6 3*10^-6]);
subplot(8,1,6);
plot(ColumnMean6);
title('40dB','Position',[2000,3*10^-6]);
set(gca,'xlim',[0 2000]);
set(gca,'ylim',[-5*10^-6 3*10^-6]);
subplot(8,1,7);
plot(ColumnMean7);
title('30dB','Position',[2000,3*10^-6]);
set(gca,'xlim',[0 2000]);
set(gca,'ylim',[-5*10^-6 3*10^-6]);
subplot(8,1,8);
plot(ColumnMean8);
title('20dB','Position',[2000,3*10^-6]);
xlabel('Time (microsecond)','FontSize',16);
set(gca,'xlim',[0 2000]);
set(gca,'ylim',[-5*10^-6 3*10^-6]);
sgtitle('Auditory Brainstem Response WT M1');






