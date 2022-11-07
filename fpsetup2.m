% Edited by Yue/Kuan 10/27/2022

%% define data folder
close all; clear all; clc;
blockpath=uigetdir('F:\TDT DATA');
cd(blockpath);

%% read data
data = TDTbin2mat(blockpath);
SENSOR = 'x465C';
ISOS = 'x405C';
time = (1:length(data.streams.(SENSOR).data))/data.streams.(SENSOR).fs;

%% plot raw data
red = [0.8500, 0.3250, 0.0980];
green = [0.4660, 0.6740, 0.1880];
cyan = [0.3010, 0.7450, 0.9330];
gray1 = [.7 .7 .7];
gray2 = [.8 .8 .8];

figure('Position',[100, 100, 800, 400])
hold on;
p1 = plot(time, data.streams.(SENSOR).data,'color',green,'LineWidth',2);
p2 = plot(time, data.streams.(ISOS).data,'color',red,'LineWidth',2);
title('Raw Demodulated Responses','fontsize',16);
xlabel('Time (s)');
ylabel('mV');
axis tight;
legend([p1 p2], {'dlight1.1','UV'}); 

%% remove the first few seconds of recording, which contain artefacts
% Tunable parameter
t = 5; % time threshold below which we will discard

ind = find(time>t,1); % find first index of when time crosses threshold
time1 = time(ind:end); % reformat vector to only include allowed time
SENSOR_data1 = data.streams.(SENSOR).data(ind:end);
ISOS_data1 = data.streams.(ISOS).data(ind:end);

% clf;
% hold on;
% p1 = plot(time, data.streams.(DLIGHT).data,'color',green,'LineWidth',2);
% p2 = plot(time, data.streams.(ISOS).data,'color',red,'LineWidth',2);
% title('Raw Demodulated Responses with Artifact Removed','fontsize',16);
% xlabel('Seconds','fontsize',16)
% ylabel('mV','fontsize',16);
% axis tight;
% legend([p1 p2], {'DLIGHT','UV'});

%% downsample traces
% Tunable parameter
timeWindow = 0.25; % in unit of seconds

N = round(timeWindow.*data.streams.(SENSOR).fs);  % multiplicative for downsampling
% N = 1000; % multiplicative for downsampling
downSampleIdx = 1:N:length(ISOS_data1)-N+1;
SENSOR_data2 = arrayfun(@(i)...
    mean(SENSOR_data1(i:i+N-1)),...
    downSampleIdx);
ISOS_data2 = arrayfun(@(i)...
    mean(ISOS_data1(i:i+N-1)),...
    downSampleIdx);
time2 = time1(downSampleIdx);

%% check downsampled data
 figure('Position',[100, 100, 800, 400])
 hold on;
 p1 = plot(time1, SENSOR_data1,'color',cyan,'LineWidth',1);
 p2 = plot(time2, SENSOR_data2,'color',red,'LineWidth',2);

 p3 = plot(time1, ISOS_data1,'color','g','LineWidth',1);
 p4 = plot(time2, ISOS_data2,'color','m','LineWidth',2);

 axis tight;
 xlabel('time (s)');
 ylabel('Raw data (mV)');
 legend({'raw SENSOR','downsampled SENSOR','raw ISOS','downsampled ISOS'})

 %% background subtraction for detrending
bls = polyfit(ISOS_data2,SENSOR_data2,1);
Y_fit_all = bls(1) .* ISOS_data2 + bls(2);
Y_dF_all = SENSOR_data2 - Y_fit_all; %dF (units mV) is not dFF

dFF = 100*(Y_dF_all)./Y_fit_all;
std_dFF = std(double(dFF));

%% check polyfit 
figure('Position',[100, 100, 800, 400]);
plot(ISOS_data2,SENSOR_data2,'.');
hold on;
plot(ISOS_data2,Y_fit_all,'r-')
xlabel('ISOS (mV)');
ylabel('SENSOR (mV)');

figure('Position',[100, 100, 800, 400]);
plot(time2,Y_dF_all);
xlabel('time (s)');
ylabel('corrected SENSOR (dF)');
axis tight;

%% check detrended data
figure('Position',[100, 100, 800, 400]);
p1 = plot(time2, dFF, 'Color',green,'LineWidth',2);
hold on;
% p2 = plot(LICK_x, y_scale*(LICK_y) + y_shift,'color',cyan,'LineWidth',2);
title('Detrended, y-shifted dFF','fontsize',16);
% legend([p1 p2],'DLIGHT','Lick Epoc');
axis tight;
xlabel('time (s)');
ylabel('dF/F');