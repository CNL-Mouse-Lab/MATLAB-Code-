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
TDTfft(data.streams.EEGw, 19, 'FREQ', [0, 20], 'NUMAVG', 20, 'SPECPLOT', 1);
%% Filter
%data = TDTdigitalfilter(data, 'EEGw', [0, 100], 'ORDER', 10);
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
%resultAll =  cell(nCHANNEL,2);

CHANNEL = 21;
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

multiwaveplot(allSignalsDEVBC(101:150,:),'gain',10)