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


%for CHANNEL=1:nCHANNEL
% select Channel
CHANNEL=21;
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
%Baselinecorrection
BaselineST = allSignalsST(:,1:round((minLength/TRANGE(2))*abs(TRANGE(1))));
BaselinecorrectST = mean(BaselineST,2);
allSignalsSTBC = allSignalsST-BaselinecorrectST;
%%
%Baselinecorrection
BaselineDEV = allSignalsDEV(:,1:round((minLength/TRANGE(2))*abs(TRANGE(1))));
BaselinecorrectDEV = mean(BaselineDEV,2);
allSignalsDEVBC = allSignalsDEV-BaselinecorrectDEV;

allSignalsST = allSignalsSTBC';
allSignalsDEV = allSignalsDEVBC';

min_freq =  3;
max_freq = 50;
num_frex = 30;
times=TRANGE(1) + (1:minLength) / data.streams.(STREAM_STORE).fs;

% define wavelet parameters
time = -1:1/data.streams.EEGw.fs:1;
frex = logspace(log10(min_freq),log10(max_freq),num_frex);
s    = logspace(log10(3),log10(10),num_frex)./(2*pi*frex);
% s    =  3./(2*pi*frex); % this line is for figure 13.14
% s    = 10./(2*pi*frex); % this line is for figure 13.14


[pnts,trials]=size(allSignalsDEV);
% definte convolution parameters
n_wavelet            = length(time);
n_data               = pnts*trials;
n_convolution        = n_wavelet+n_data-1;
n_conv_pow2          = pow2(nextpow2(n_convolution));
half_of_wavelet_size = (n_wavelet-1)/2;

% get FFT of data
eegfft=fft(reshape(allSignalsDEV,1,pnts*trials),n_conv_pow2);
% initialize
eegpower = zeros(num_frex,pnts); % frequencies X time X trials

baseidx = dsearchn(times',[-0.05 0]');

% loop through frequencies and compute synchronization
for fi=1:num_frex
    
    wavelet = fft( sqrt(1/(s(fi)*sqrt(pi))) * exp(2*1i*pi*frex(fi).*time) .* exp(-time.^2./(2*(s(fi)^2))) , n_conv_pow2 );
    
    % convolution
    eegconv = ifft(wavelet.*eegfft);
    eegconv = eegconv(1:n_convolution);
    eegconv = eegconv(half_of_wavelet_size+1:end-half_of_wavelet_size);
    
    % Average power over trials (this code performs baseline transform,
    % which you will learn about in chapter 18)
    temppower = mean(abs(reshape(eegconv,pnts,trials)).^2,2);
    eegpower(fi,:) = 10*log10(temppower./mean(temppower(baseidx(1):baseidx(2))));
end

figure

contourf(times,frex,eegpower,40,'linecolor','none')
set(gca,'clim',[-1.5 1.5],'xlim',[-0.05 0.25],'yscale','log','ytick',logspace(log10(min_freq),log10(max_freq),6),'yticklabel',round(logspace(log10(min_freq),log10(max_freq),6)*10)/10)
title('DEV')

