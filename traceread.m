close all; clear all; clc;

%point to directory with CSV and ARF files
LOCATION = 'D:\Case Files\Yu Fu Chen\TDT\TDT'; 
ddd = dir(LOCATION);

%parse the files
for ii = 3:length(ddd)
    [filepath, name, ext] = fileparts(ddd(ii).name);
    if strcmpi(ext, '.csv')
        name = ddd(ii).name(1:end-4);
        parts = strread(name,'%s','delimiter', '-');
        if length(parts) < 5
            continue
        end
        repeat = str2num(parts{end})
        channel = str2num(parts{end-1})
        sgi = str2num(parts{end-2})
        group = str2num(parts{end-3})
        arf = [sprintf('%s-',parts{1:end-5}),parts{end-4}]
    end
end

ARF = 'test'; %header
TYPE = 'ABR'; % 'ABR' or 'DPOAE'
GROUP = 0; %these are going to be the trace comparisons
SIG = 1;
CHANNEL = 1;
REPEAT = 1;

ARFFILE = fullfile(LOCATION, sprintf('%s.arf', ARF));
CSVFILE = fullfile(LOCATION, sprintf('%s-%d-%d-%d-%d.csv', ARF, GROUP, SIG, CHANNEL, REPEAT));

if ~exist(CSVFILE,'file')
    error('%s file does not exist', CSVFILE);
end

if ~exist(ARFFILE,'file')
    error('%s file does not exist', ARFFILE);
end

% read arf and individual trace data
data = arfread(ARFFILE);
individual = single(csvread(CSVFILE, 2, 0));

% find arf data
bFound = 0;
for ii = 1:numel(data.groups)
    if data.groups(ii).grpn == GROUP
        for jj = 1:numel(data.groups(ii).recs)
            if data.groups(ii).recs(jj).sgi == SIG && data.groups(ii).recs(jj).chan == CHANNEL
                bFound = 1;
                ddd = data.groups(ii).recs(jj).data;
            end
        end
    end
end

if ~bFound
    error('group: %d sgi: %d channel: %d could not be found in %s', GROUP, SIG, CHANNEL, ARFFILE);
end

% plot arf data
figure;
plot(ddd, 'b')
hold on;

% plot individual trace data
valid = individual(1:end-2,1:end-1);
xxx = mean(valid);
if strcmpi(TYPE, 'ABR')
    plot(xxx - mean(xxx), 'r')
elseif strcmpi(TYPE, 'DPOAE')
    rrr = blackman(numel(xxx)) .* xxx';
    rrr = abs(fft(rrr));
    rrr = rrr * 2 / numel(rrr);
    rrr = rrr(1:floor(numel(rrr)/2)); % left side only
    Y = 20*log10(rrr);
    plot(Y, 'r')
else
    error('unrecognized type %s', TYPE);
end

title('ARF vs CSV average')
xlabel('samples')
ylabel('V')
legend('ARF average','CSV average')

% plot all individual traces
figure;
plot(valid')
title('All Individual Traces')