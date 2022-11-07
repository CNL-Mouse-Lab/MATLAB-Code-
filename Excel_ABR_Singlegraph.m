A = readtable('07022021_WT_ABR_0_1_1_1.csv','range','A3:BWB516');
m1 = table2array(A);
ColumnMean1 = mean(m1,1);
plot(ColumnMean1);
title('Auditory Brainstem Response WT M1 90dB','FontSize',16);
xlabel('Time (microsecond)','FontSize',16);
ylabel('Amplitude (volt)','FontSize',16);
set(gca,'xlim',[0 2000]);
set(gca,'ylim',[-5*10^-6 3*10^-6]);