%export data from arf to matrix%
A = arfread('C:\Users\yding35\Box\ABR\ABR raw data\01272022\13MonCLN3M2.arf');
m = squeeze(cell2mat(struct2cell(struct('data', {A.groups.recs(1:17).data}))));
m = m';
%plotting%
yinterval = 5.5e-6;
nFrame = 244;
timeV = (1:nFrame)/25000 * 1000;
for ii = 1:17
    hold on;
    plot(timeV,m(ii,:)-yinterval*(ii-1),'linewidth',2,'color','black');
    hold off;
    set(gca,'ytick',[]);
    ylim([-95e-6 8e-6]);
    xlabel('Time (ms)');
end 
