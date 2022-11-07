%% define data folder
close all; clear all; clc;
blockpath=uigetdir('F:\TDT DATA');
cd(blockpath);
%% read data
data = TDTbin2mat(blockpath);
SENSOR = 'x465A';
ISOS = 'x405A';
LICK = 'Cam1';
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
legend([p1 p2], {'SENSOR','UV'});
%% remove the first few seconds of recording, which contain artifacts
% Tunable parameter
t = 5; % time threshold below which we will discard
ind = find(time>t,1); % find first index of when time crosses threshold
time1 = time(ind:end); % reformat vector to only include allowed time
SENSOR_data1 = data.streams.(SENSOR).data(ind:end);
ISOS_data1 = data.streams.(ISOS).data(ind:end);
% Plot again at new time range
figure('Position',[100, 100, 800, 400])
hold on;
p1 = plot(time1, SENSOR_data1,'color',green,'LineWidth',2);
p2 = plot(time1, ISOS_data1,'color',red,'LineWidth',2);
title('Raw Demodulated Responses with Artifact Removed','fontsize',16);
xlabel('Time (s)');
ylabel('mV');
axis tight;
legend([p1 p2], {'SENSOR','UV'});
%% downsample traces
% Tunable parameter
timeWindow = 0.25; % in unit of seconds
N = round(timeWindow.*data.streams.(SENSOR).fs); % multiplicative for downsampling
downSampleIdx = 1:N:length(ISOS_data1)-N+1;
SENSOR_data2 = arrayfun(@(i)...
    mean(SENSOR_data1(i:i+N-1)),...
    downSampleIdx);
ISOS_data2 = arrayfun(@(i)...
    mean(ISOS_data1(i:i+N-1)),...
    downSampleIdx);
time2 = time1(downSampleIdx);
%% background subtraction for detrending
bls = polyfit(ISOS_data2,SENSOR_data2,1);
Y_fit_all = bls(1) .* ISOS_data2 + bls(2);
Y_dF_all = SENSOR_data2 - Y_fit_all; %dF (units mV) is not dFF
dFF = 100*(Y_dF_all)./Y_fit_all;
std_dFF = std(double(dFF));
%% Turn Licking Events into Lick Bouts
% Make continuous time series for lick BOUTS for plotting
LICK_on_index = find(data.epocs.Cam1.notes.index == 1);
LICK_off_index = find(data.epocs.Cam1.notes.index == 2);
LICK_on = data.epocs.Cam1.notes.ts(LICK_on_index);
LICK_off = data.epocs.Cam1.notes.ts(LICK_off_index);
LICK_x = reshape(kron([LICK_on,LICK_off],[1, 1])',[],1);
sz = length(LICK_on);
d = ones(1,size(LICK_on_index,1));
y_scale = 10; %adjust according to data needs
y_shift = 0; %scale and shift are just for asthetics
LICK_y = reshape([zeros(1, sz); d; d; zeros(1, sz)], 1, []);
% First subplot in a series: dFF with lick epocs
figure('Position',[100, 100, 800, 400]);
hold on;
p1 = plot(time2, dFF, 'Color',green,'LineWidth',2);
line([LICK_on LICK_off],[-20 25],'Color','blue','LineWidth',2);
title('Detrended, y-shifted dFF','fontsize',16);
legend(p1,'SENSOR');
axis tight
%% Find differences in onsets and threshold for major difference indices
lick_on_diff = diff(LICK_on);
BOUT_TIME_THRESHOLD = 10; % example bout time threshold, in seconds
lick_diff_ind = find(lick_on_diff >= BOUT_TIME_THRESHOLD);
% Make an onset/ offset array based on threshold indices
diff_ind_i = 1;
for i = 1:length(lick_diff_ind)
    % BOUT onset is thresholded onset index of lick epoc event
    LICK_on(i) = LICK_on(diff_ind_i);
    % BOUT offset is thresholded offset of lick event before next onset
    LICK_off(i) = ...
        LICK_off(lick_diff_ind(i));
    %data.epocs.(LICK_EVENT).data(i) = 1; % set the data value, arbitrary 1
    diff_ind_i = lick_diff_ind(i) + 1; % increment the index
end
%%
% Now determine if it was a 'real' bout or not by thresholding by some
% user-set number of licks in a row
MIN_LICK_THRESH = 4; % four licks or more make a bout
licks_array = zeros(length(LICK_on),1);
for i = 1:length(LICK_on)
    % Find number of licks in licks_array between onset ond offset of
    % Our new lick BOUT (LICK_EVENT)
    licks_array(i) = numel(find(LICK_on >=...
        LICK_on(i) & LICK_on <=...
        LICK_off(i)));
end
%% Next step: dFF with newly defined lick bouts
clf;
p1 = plot(time2, dFF,'Color',green,'LineWidth',2);
hold on;
p2 = plot(LICK_x, y_scale*(LICK_y) + y_shift,...
    'color',cyan,'LineWidth',2);
title('Detrended, y-shifted dFF','fontsize',16);
legend([p1 p2],'SENSOR', 'Lick Bout');
axis tight
% Making nice area fills instead of epocs for asthetics. Newer versions of
% Matlab can use alpha on area fills, which could be desirable
clf;
hold on;
dFF_min = min(dFF);
dFF_max = max(dFF);
for i = 1:size(LICK_on,1)
    h1(i) = area([LICK_on(i) ...
        LICK_off(i)], [dFF_max dFF_max], ...
        dFF_min, 'FaceColor',cyan,'edgecolor', 'none');
end
p1 = plot(time2, dFF,'Color',green,'LineWidth',2);
title('Detrended, y-shifted dFF','fontsize',16);
legend([p1 h1(1)],'SENSOR', 'Lick Bout');
ylabel('\DeltaF/F','fontsize',16)
xlabel('Seconds','fontsize',16);
axis tight
%% Time Filter Around Lick Bout Epocs
% Note that we are using dFF of the full time-series, not peri-event dFF
% where f0 is taken from a pre-event baseline period. That is done in
% another fiber photometry data analysis example.
PRE_TIME = 5; % ten seconds before event onset
POST_TIME = 10; % ten seconds after
fs = data.streams.(SENSOR).fs/N; % recall we downsampled by N = 100 earlier
% time span for peri-event filtering, PRE and POST
TRANGE = [-1*PRE_TIME*floor(fs),POST_TIME*floor(fs)];
% Pre-allocate memory
trials = numel(LICK_on);
dFF_snips = cell(trials,1);
array_ind = zeros(trials,1);
pre_stim = zeros(trials,1);
post_stim = zeros(trials,1);
%% Make stream snips based on trigger onset
for i = 1:trials
    % If the bout cannot include pre-time seconds before event, make zero
    if LICK_on(i) < PRE_TIME
        dFF_snips{i} = single(zeros(1,(TRANGE(2)-TRANGE(1))));
        continue
    else
        % Find first time index after bout onset
        array_ind(i) = find(time2 > LICK_on(i),1);
        % Find index corresponding to pre and post stim durations
        pre_stim(i) = array_ind(i) + TRANGE(1);
        post_stim(i) = array_ind(i) + TRANGE(2);
        dFF_snips{i} = dFF(pre_stim(i):post_stim(i));
    end
end
%% Make all snippet cells the same size based on minimum snippet length
minLength = min(cellfun('prodofsize', dFF_snips));
dFF_snips = cellfun(@(x) x(1:minLength), dFF_snips, 'UniformOutput',false);
% Convert to a matrix and get mean
allSignals = cell2mat(dFF_snips);
mean_allSignals = mean(allSignals);
std_allSignals = std(mean_allSignals);
% Make a time vector snippet for peri-events
peri_time = (1:length(mean_allSignals))/fs - PRE_TIME;
%% Make a Peri-Event Stimulus Plot and Heat Map
% Make a standard deviation fill for mean signal
figure('Position',[100, 100, 600, 600])
subplot(2,1,1)
xx = [peri_time, fliplr(peri_time)];
yy = [mean_allSignals + std_allSignals,...
    fliplr(mean_allSignals - std_allSignals)];
h = fill(xx, yy, 'g'); % plot this first for overlay purposes
hold on;
set(h, 'facealpha', 0.25, 'edgecolor', 'none');
% Set specs for min and max value of event line.
% Min and max of either std or one of the signal snip traces
linemin = min(min(min(allSignals)),min(yy));
linemax = max(max(max(allSignals)),max(yy));
% Plot the line next
l1 = line([0 0], [linemin, linemax],...
    'color','cyan', 'LineStyle', '-', 'LineWidth', 2);
% Plot the signals and the mean signal
p1 = plot(peri_time, allSignals', 'color', gray1);
p2 = plot(peri_time, mean_allSignals, 'color', green, 'LineWidth', 3);
hold off;
% Make a legend and do other plot things
legend([l1, p1(1), p2, h],...
    {'Lick Onset','Trial Traces','Mean Response','Std'},...
    'Location','northeast');
title('Peri-Event Trial Responses','fontsize',16);
ylabel('DeltaF/F','fontsize',16);
axis tight;
% Make an invisible colorbar so this plot aligns with one below it
temp_cb = colorbar('Visible', 'off');
% Heat map
subplot(2,1,2)
imagesc(peri_time, 1, allSignals); % this is the heatmap
set(gca,'YDir','normal') % put the trial numbers in better order on y-axis
%colormap(gray()) % colormap otherwise defaults to perula
title('Lick Bout Heat Map','fontsize',16)
ylabel('Trial Number','fontsize',16)
xlabel('Seconds from lick onset','fontsize',16)
cb = colorbar;
ylabel(cb, 'dFF','fontsize',16)
axis tight;