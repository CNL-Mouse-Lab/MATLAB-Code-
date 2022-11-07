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
%TDTfft(data.streams.EEGw, 19, 'FREQ', [0, 20], 'NUMAVG', 20, 'SPECPLOT', 1);
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
meanSignalST = mean(allSignalsSTBC)*10^6;
semSignalST = (std(double(allSignalsSTBC))/sqrt(850))*10^6;
a=meanSignalST+semSignalST;
b=meanSignalST-semSignalST;
%%
%Averaging
meanSignalDEV = mean(allSignalsDEVBC)*10^6;
semSignalDEV = (std(double(allSignalsDEVBC))/sqrt(150))*10^6;
c=meanSignalDEV+semSignalDEV;
d=meanSignalDEV-semSignalDEV;

%MMN
meanSignalMMN = meanSignalDEV-meanSignalST;

meanAllST(CHANNEL,1:minLength)= meanSignalST;
meanAllDEV(CHANNEL,1:minLength)= meanSignalDEV;
meanAllMMN(CHANNEL,1:minLength)= meanSignalMMN;

end

times2plot = 0;

% color_limitU = 20; % more-or-less arbitrary, but this is a good value
% color_limitD = -100;
% convert time point from ms to index
timepointidx = round((times2plot-TRANGE(1))*data.streams.(STREAM_STORE).fs);

% First step is to get X and Y coordinates of electrodes
% These must be converted to polar coordinates
electrode_locs_X =[-3 -2 -1 -2.5 -1.5 -0.5 -3 -2 -1 -2.5 -1.5 -0.5 -2 -1 -1.5 -0.5 0.5 1.5 1 2 0.5 1.5 2.5 1 2 3 0.5 1.5 2.5 1 2 3];

electrode_locs_Y =[-5 -5 -5 -3.5 -3.5 -3.5 -2 -2 -2 -0.5 -0.5 -0.5 1 1 2.5 2.5 2.5 2.5 1 1 -0.5 -0.5 -0.5 -2 -2	-2 -3.5 -3.5 -3.5 -5 -5 -5];


% interpolate to get nice surface
interpolation_levelX = 50; 
interpolation_levelY = 150;% you can try changing this number, but 100 is probably good
interpX = linspace((min(electrode_locs_X)-0.5),(max(electrode_locs_X)+0.5),interpolation_levelX);
interpY = linspace((min(electrode_locs_Y)-0.5),(max(electrode_locs_Y)+0.5),interpolation_levelY);

% meshgrid is a function that creates 2D grid locations based on 1D inputs
[gridX,gridY] = meshgrid(interpX,interpY);


% now interpolate the data on a 2D grid

figure


subplot(1,3,1);
%set(gcf,'number','off','name',[ 'Topographical data from trial ' num2str(trial2plot) ', time=' num2str(round(EEG.times(timepointidx))) ]);
interpolated_EEG_dataST = griddata(electrode_locs_X,electrode_locs_Y,meanAllST(:,timepointidx),gridX,gridY);
contourf(interpX,interpY,interpolated_EEG_dataST,100,'linecolor','none');hold on
scatter(electrode_locs_X,electrode_locs_Y);
axis square
set(gca,'clim',[-80 20],'xlim',[min(interpX) max(interpX)]*1.1,'ylim',[min(interpY) max(interpY)]*1.1)
title('ST')
colorbar

subplot(1,3,2);
interpolated_EEG_dataDEV = griddata(electrode_locs_X,electrode_locs_Y,meanAllDEV(:,timepointidx),gridX,gridY);
contourf(interpX,interpY,interpolated_EEG_dataDEV,100,'linecolor','none');hold on
scatter(electrode_locs_X,electrode_locs_Y);
axis square
set(gca,'clim',[-80 20],'xlim',[min(interpX) max(interpX)]*1.1,'ylim',[min(interpY) max(interpY)]*1.1)
title('DEV')
colorbar

subplot(1,3,3);
interpolated_EEG_dataMMN = griddata(electrode_locs_X,electrode_locs_Y,meanAllMMN(:,timepointidx),gridX,gridY);
contourf(interpX,interpY,interpolated_EEG_dataMMN,100,'linecolor','none');hold on
scatter(electrode_locs_X,electrode_locs_Y);
axis square
set(gca,'clim',[-50 20],'xlim',[min(interpX) max(interpX)]*1.1,'ylim',[min(interpY) max(interpY)]*1.1)
title('MMN')
colorbar

