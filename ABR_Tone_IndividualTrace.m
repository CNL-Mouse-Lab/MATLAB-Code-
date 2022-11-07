A = arfread('C:\Users\yding35\Box\ABR\ABR raw data\01272022\13MonCLN3M2_Tone.arf');
m = squeeze(cell2mat(struct2cell(struct('data', {A.groups.recs(1:40).data}))));
m = m';
nFrame = 244;
timeV = (1:nFrame)/25000 * 1000;
yinterval = 15e-8;
figure;
for ii = 1:8
    hold on;
    plot(timeV,m(ii,:)-yinterval*(ii-1),'linewidth',2,'color','black');
    set(gca,'ytick',[]);
    xlabel('Time (ms)');
    title('4000 Hz');
    hold off;
end 
figure;
for ii = 1:8
    hold on;
    plot(timeV,m(ii+8,:)-yinterval*(ii-1),'linewidth',2,'color','black');
    set(gca,'ytick',[]);
    xlabel('Time (ms)');
    title('8000 Hz');
    hold off;
end 
figure;
for ii = 1:8
    hold on;
    plot(timeV,m(ii+16,:)-yinterval*(ii-1),'linewidth',2,'color','black');
    set(gca,'ytick',[]);
    xlabel('Time (ms)');
    title('16000 Hz');
    hold off;
end 
figure;
for ii = 1:8
    hold on;
    plot(timeV,m(ii+24,:)-yinterval*(ii-1),'linewidth',2,'color','black');
    set(gca,'ytick',[]);
    xlabel('Time (ms)');
    title('24000 Hz');
    hold off;
end 
figure;
for ii = 1:8
    hold on;
    plot(timeV,m(ii+32,:)-yinterval*(ii-1),'linewidth',2,'color','black');
    set(gca,'ytick',[]);
    xlabel('Time (ms)');
    title('32000 Hz');
    hold off;
end 