close all; clear all; clc;
blockpath=uigetdir('F:\TDT DATA');
cd(blockpath);
%subjectpath=uigetdir('D:\')
%cd(subjectpath)
%block='test1-210507-121011 MMN with pupil tracking';
%blockpath=fullfile(subjectpath,block);
%% 
%Setting up parameters 
REF_EPOC = 'Pdur';
STREAM_STORE = 'EEGw';
%CHANNEL =2;
ST=50;
DEV=100;
ARTIFACT = Inf;
%ARTIFACT = Inf; % optionally set an artifact rejection level
TRANGE = [-0.05, 0.30];

%% 
%import data
data = TDTbin2mat(blockpath, 'TYPE', {'epocs', 'scalars', 'streams'});
%data = TDTdigitalfilter(data, STREAM_STORE, [0.1, 100]); % very slow if
%useing multichannel raw data for this digitial filter
%data = TDTdigitalfilter(data, STREAM_STORE, 'NOTCH', 60);
%%
% spectrum check
%TDTfft(data.streams.EEGw, 19, 'FREQ', [0, 100],  'SPECPLOT', 1);
%% Filter
data = TDTdigitalfilter(data, 'EEGw', [0, 50], 'ORDER', 10);
%%
%Epocing ST
dataST = TDTfilter(data, REF_EPOC, 'VALUES',ST);
dataST = TDTfilter(dataST, REF_EPOC, 'TIME', TRANGE);

%%
%Epocing DEV
dataDEV = TDTfilter(data, REF_EPOC, 'VALUES',DEV);
dataDEV= TDTfilter(dataDEV, REF_EPOC, 'TIME', TRANGE);

%CAR
%CAR=cellfun(@(x) mean(x,1),data.streams.(STREAM_STORE).filtered,'UniformOutput',false);
%%
nCHANNEL=data.streams.(STREAM_STORE).channel(end);
%% Run a loop to plot each channel


for CHANNEL=1:nCHANNEL
% select Channel
ChannleEEGwST = cellfun(@(x) x(CHANNEL,:), dataST.streams.(STREAM_STORE).filtered, 'UniformOutput',false) ;
ChannleEEGwDEV = cellfun(@(x) x(CHANNEL,:), dataDEV.streams.(STREAM_STORE).filtered, 'UniformOutput',false) ;
%rereferencing
%ChannleEEGw = cellfun(@minus,ChannleEEGw,CAR,'UniformOutput',false);

%%
%Artifact rejection 
art1 = ~cellfun('isempty', cellfun(@(x) x(x>ARTIFACT), ChannleEEGwST, 'UniformOutput',false));
art2 = ~cellfun('isempty', cellfun(@(x) x(x<-ARTIFACT), ChannleEEGwST, 'UniformOutput',false));
good = ~art1 & ~art2;
ChannleEEGwST =ChannleEEGwST(good);
numArtifactsST = sum(~good);

minLength = min(cellfun('prodofsize', ChannleEEGwST));
ChannleEEGwST = cellfun(@(x) x(1:minLength), ChannleEEGwST, 'UniformOutput',false);

allSignalsST = cell2mat(ChannleEEGwST');
%%
%Artifact rejection 
art1 = ~cellfun('isempty', cellfun(@(x) x(x>ARTIFACT), ChannleEEGwDEV, 'UniformOutput',false));
art2 = ~cellfun('isempty', cellfun(@(x) x(x<-ARTIFACT), ChannleEEGwDEV, 'UniformOutput',false));
good = ~art1 & ~art2;
ChannleEEGwDEV =ChannleEEGwDEV(good);
numArtifactsDEV = sum(~good);

minLength = min(cellfun('prodofsize', ChannleEEGwDEV));
ChannleEEGwDEV = cellfun(@(x) x(1:minLength), ChannleEEGwDEV, 'UniformOutput',false);

allSignalsDEV = cell2mat(ChannleEEGwDEV');

%%
%Baselinecorrection
BaselineST = allSignalsST(:,1:round((minLength/TRANGE(2))*abs(TRANGE(1))));
BaselinecorrectST = mean(BaselineST,2);
allSignalsSTBC = allSignalsST-BaselinecorrectST;
%%
%Baselinecorrection
BaselineDEV = allSignalsDEV(:,1:round((minLength/TRANGE(2))*abs(TRANGE(1))));
BaselinecorrectDEV = mean(BaselineDEV,2);
allSignalsDEVBC = allSignalsDEV-BaselinecorrectDEV;

%%
%Averaging
%meanSignalST = mean(allSignalsSTBC)*10^6;
meanSignalST = median(allSignalsSTBC)*10^6;
semSignalST = mad(allSignalsSTBC)*10^6;
%semSignalST = (std(double(allSignalsSTBC))/sqrt(850))*10^6;
a=meanSignalST+semSignalST;
b=meanSignalST-semSignalST;
%%
%Averaging
%meanSignalDEV = mean(allSignalsDEVBC)*10^6;
meanSignalDEV = median(allSignalsDEVBC)*10^6;
%semSignalDEV = (std(double(allSignalsDEVBC))/sqrt(150))*10^6;
semSignalDEV = mad(allSignalsDEVBC)*10^6;
c=meanSignalDEV+semSignalDEV;
d=meanSignalDEV-semSignalDEV;

%MMN
meanSignalMMN = meanSignalDEV-meanSignalST;

%% Ready to plot
% Create the time vector.
ts = TRANGE(1) + (1:minLength) / data.streams.(STREAM_STORE).fs;
figure;
%plot(ts, allSignalsSTBC','Color', [.85 .85 .85]); axis tight
    %axis off;

subplot(2,1,1);
%line([0 0], [min(allSignalsST(:)), max(allSignalsST(:))], 'Color', 'r', 'LineStyle','-', 'LineWidth', 3);hold on
line([0 0], [-140, 140], 'Color', 'r', 'LineStyle','-', 'LineWidth', 1);hold on
%%
% Plot the average signal.
% hold on
% plot(ts, meanSignalST, 'b', 'LineWidth', 1); 
% hold on;
% 
% %%
% % Plot the standard deviation bands.
% plot(ts, meanSignalST+semSignalST, 'b--', ts, meanSignalST-semSignalST, 'b--');
% hold on;
% plot(ts, meanSignalDEV, 'r', 'LineWidth', 1);
% hold on;
% plot(ts, meanSignalDEV+semSignalDEV, 'R--', ts, meanSignalDEV-semSignalDEV, 'R--');
plot(ts,meanSignalST,'b','LineWidth', 1);hold on
plot(ts,meanSignalDEV,'r','LineWidth', 1);hold on
fill([ts(:);flipud(ts(:))],[a(:); flipud(b(:))],'b','facealpha',0.2,'edgecolor','none','facecolor','blue');hold on
fill([ts(:);flipud(ts(:))],[c(:); flipud(d(:))],'r','facealpha',0.2,'edgecolor','none','facecolor','red');hold on
hold on

axis ([-0.05 0.25 -140 140])
xlabel('Time(s)','FontSize',8)
ylabel('ERP(µV)', 'FontSize', 8)
title(sprintf('Ch %d' , CHANNEL),'FontSize',8)
%%
subplot(2,1,2);
hold on;
line([-0.05 0.25],[0 0],'Color','red','LineStyle','--')
hold on;
plot(ts, meanSignalMMN, 'color',[0.9290 0.6940 0.1250], 'LineWidth', 1);

axis ([-0.05 0.25 -60 60])
xlabel('Time(s)','FontSize',8)
ylabel('Difference in ERP(µV)', 'FontSize', 8)
set(gcf, 'Position',[100, 100, 300, 500])
resultAll{CHANNEL,1}=gcf;
resultAll{CHANNEL,2}=['CH' num2str(CHANNEL,'%d') 'ST&DEV'];
meanAllST(CHANNEL,1:305)= meanSignalST;
meanAllDEV(CHANNEL,1:305)= meanSignalDEV;
meanAllMMN(CHANNEL,1:305)= meanSignalMMN;

end
%% save image
% select output folder
mkdir DEV-STmd;
cd DEV-STmd;

for i = 1:size(resultAll,1)
    %%
    outFile = [resultAll{i,2},'.tif'];
    saveas(resultAll{i,1},outFile);
    
end
close all 


