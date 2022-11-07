function [fft_data,varargout] = TDTfft(data, channel, varargin)
%TDTFFT  performs a frequency analysis of the data stream
%   [fft_data, fft_freq] = TDTfft(DATA, CHANNEL), where DATA is a stream 
%   from the output of TDT2mat and CHANNEL is an integer.
%
%   fft_data    contains power spectrum array
%   fft_freq    contains the frequency list (optional)
%
%   fft_data = TDTfft(DATA, CHANNEL, 'parameter', value,...)
%   [fft_data, fft_freq] = TDTfft(DATA, CHANNEL, 'parameter', value,...)
%
%   'parameter', value pairs
%      'PLOT'       boolean, set to false to disable figure
%      'NUMAVG'     scalar, number of subsets of data to average together
%                   in fft_data (default = 1)
%      'SPECPLOT'   boolean, include spectrogram plot (default = false)
%      'FREQ'       Two-element vector, Spectral Power within specificed
%                   frequencies will be returned instead of full scale
%                   (default = [0 FS/2])
%      'RESOLUTION' scalar, the frequency resolution, (default = 1)
%      'LEGEND'     Add a string to describe the data trace
%
%   Example
%      data = TDTbin2mat('C:\TDT\OpenEx\Tanks\DEMOTANK2\Block-1');
%	   TDTfft(data.streams.Wave, 1);

if nargout > 2
    error('too many output arguments, only 1 or 2 output arguments allowed')
end

% defaults
PLOT     = true;
NUMAVG   = 1;
SPECPLOT = false;
FREQ = [0, data.fs/2];
RESOLUTION = 1;
LEGEND = false;

VALID_PARS = {'PLOT','NUMAVG','SPECPLOT','FREQ','RESOLUTION','LEGEND'};

% parse varargin
for ii = 1:2:length(varargin)
    if ~ismember(upper(varargin{ii}), VALID_PARS)
        error('%s is not a valid parameter. See help TDTfft.', upper(varargin{ii}));
    end
    eval([upper(varargin{ii}) '=varargin{ii+1};']);
end

if length(FREQ) ~= 2
    error('FREQ must be a two-element vector');
else
    if FREQ(2) < FREQ(1)
        error('Second element of FREQ must be smaller than first element');
    end
    if FREQ(1) < 0 || FREQ(2) > data.fs/2
        error('FREQ outside of bounds (0, %.2f)', data.fs/2);
    end
end

% resample it if FREQ is specified
if FREQ(2) < data.fs/2 && 2*FREQ(2) < data.fs
    %data = TDTdigitalfilter(data, FREQ(2), 'low');
    new_fs = min(2*FREQ(2),data.fs);
    [p, q] = rat(data.fs/new_fs, 0.0001);
    y = resample(double(data.data(channel,:)), q, p);
    Fs = new_fs;
else
    y = data.data(channel,:);
    Fs = data.fs;
end

NFFT = round(Fs/RESOLUTION);
if rem(NFFT,2) ~= 0
    NFFT = NFFT+1;
end

if SPECPLOT
    numplots = 4;
else
    numplots = 3;
end

T = 1/Fs;       % Sample time
L = numel(y);   % Length of signal
t = (0:L-1)*T;  % Time vector

% do averaging here, if we are doing it
if NUMAVG > 1
    step = floor(L/NUMAVG);
    for i = 0:NUMAVG-1
        d = y(1+(i*step):(i+1)*step);
        Y = fft(d,NFFT)/numel(d);
        f = Fs/2*linspace(0,1,NFFT/2+1);
        d = 2*abs(Y(1:NFFT/2+1));
        if i == 0
            fft_data = d;
        else
            fft_data = fft_data + d;
        end
    end
    fft_data = fft_data/NUMAVG;
else
    Y = fft(y,NFFT)/L;
    f = Fs/2*linspace(0,1,NFFT/2+1);
    fft_data = 2*abs(Y(1:NFFT/2+1));    
end

if length(FREQ) == 1 
    fft_freq = f;
else
    [temp,ind1] = min(abs(f-FREQ(1)));
    [temp,ind2] = min(abs(f-FREQ(2)));
    fft_freq = f(ind1:ind2);
    fft_data = fft_data(ind1:ind2); 
end

if nargout == 2
    varargout{1} = fft_freq;
end

if ~PLOT
    return
end

taper_params=[8 15]; %Time bandwidth and number of tapers
      window_params=[4 1]; %Window size is 4s with step size of 1s
      min_nfft=0; %No minimum nfft
      detrend_opt='constant' %detrend each window by subtracting the average
      weighting='unity' %weight each taper at 1
      plot_on=true; %plot spectrogram
      verbose=true; %print extra info
figure;
%spectrogram(double(y),256,240,256,Fs,'yaxis'); 
multitaper_spectrogram(double(y),Fs,FREQ, taper_params, window_params, min_nfft, detrend_opt, weighting, plot_on, verbose);

colormap('turbo')
caxis([-105 -80])
title('Spectrogram')
