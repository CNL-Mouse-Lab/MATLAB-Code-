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
nCHANNEL=data.streams.(STREAM_STORE).channel(end);


for CHANNEL=1:nCHANNEL
    TDTfftspectrogram(data.streams.EEGw, CHANNEL, 'FREQ', [0, 30],  'SPECPLOT', 1);

set(gcf, 'Position',[100, 100, 400, 300])
resultAll{CHANNEL,1}=gcf;
resultAll{CHANNEL,2}=['CH' num2str(CHANNEL,'%d') 'spectrogram'];


end
%% save image
% select output folder
mkdir spectrogram;
cd spectrogram;

for i = 1:size(resultAll,1)
    %%
    outFile = [resultAll{i,2},'.tif'];
    saveas(resultAll{i,1},outFile);
    
end
close all 


