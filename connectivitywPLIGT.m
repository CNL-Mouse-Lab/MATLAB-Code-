
close all; clear all; clc;
blockpath=uigetdir('F:\TDT DATA');
cd(blockpath);

STREAM_STORE = 'EEGw';

% load data

data = TDTbin2mat(blockpath, 'TYPE', {'epocs', 'scalars', 'streams'});
nCHANNEL=data.streams.(STREAM_STORE).channel(end); 
fs= data.streams.EEGw.fs; 
Streamdata= data.streams.EEGw.data;

n_data=round(5*60*fs);
Streamdata= Streamdata(:,1:n_data); 

electrode_locs_X =[-3 -2 -1 -2.5 -1.5 -0.5 -3 -2 -1 -2.5 -1.5 -0.5 -2 -1 -1.5 -0.5 0.5 1.5 1 2 0.5 1.5 2.5 1 2 3 0.5 1.5 2.5 1 2 3];

electrode_locs_Y =[-5 -5 -5 -3.5 -3.5 -3.5 -2 -2 -2 -0.5 -0.5 -0.5 1 1 2.5 2.5 2.5 2.5 1 1 -0.5 -0.5 -0.5 -2 -2	-2 -3.5 -3.5 -3.5 -5 -5 -5];


% specify time-frequency parameters
center_freq   = 10; % Hz

% wavelet and FFT parameters
time          = -1:1/fs:1;
half_wavelet  = (length(time)-1)/2;
n_wavelet     = length(time);
n_convolution = n_wavelet+n_data-1;
n_channel=data.streams.(STREAM_STORE).channel(end);

% initialize connectivity output matrix
connectivitymat = zeros(n_channel,n_channel);


% create wavelet and take FFT
s = 5/(2*pi*center_freq);
wavelet_fft = fft( exp(2*1i*pi*center_freq.*time) .* exp(-time.^2./(2*(s^2))) ,n_convolution);

% compute analytic signal for all channels
analyticsignals = zeros(n_channel,n_data);
for chani=1:n_channel
    
    % FFT of data
    data_fft = fft(Streamdata(chani,:),n_convolution);
    
    % convolution
    convolution_result = ifft(wavelet_fft.*data_fft,n_convolution);
    convolution_result = convolution_result(half_wavelet+1:end-half_wavelet);
    
    analyticsignals(chani,:) = convolution_result;
end

% compute all-to-all connectivity
for chani=1:n_channel
    for chanj=chani:n_channel 
        xsd =analyticsignals(chani,:) .* conj(analyticsignals(chanj,:));
  
        cdi = imag(xsd);
        
        % connectivity matrix (ISPC on Lower triangle; PLI/wPLI/dwPLI on Upper triangle)
          connectivitymat(chani,chanj) = abs( mean( abs(cdi).*sign(cdi) ,2) )./mean(abs(cdi),2); %wPLI
          connectivitymat(chanj,chani) = abs(mean(exp(1i*angle(xsd)))); %ISPC 

        

%         imagsum      = sum(cdi,2);
%         imagsumW     = sum(abs(cdi),2);
%         debiasfactor = sum(cdi.^2,2);
%         connectivitymat(chanj,chani)=(imagsum.^2 - debiasfactor)./(imagsumW.^2 - debiasfactor); %dwPLI

    end
end

figure
imagesc(connectivitymat)
set(gca,'clim',[0 1]);
axis square
colorbar 


figure

subplot(221)
% get upper part of matrix
temp = nonzeros(triu(connectivitymat));
temp(temp==1)=[]; % clear 1's from the diagonal

% threshold is one std above median connectivity value
wPLI_thresh = std(temp)+median(temp);

% plot histogram and vertical line at threshold
[y,x] = hist(temp,30);
h = bar(x,y,'histc');
hold on
plot([wPLI_thresh wPLI_thresh],get(gca,'ylim'),'m','linew',2)

% make nice
set(h,'linestyle','none')
set(gca,'xtick',0:.2:1,'xlim',[0 1])
xlabel('wPLI'), ylabel('Count')



subplot(222)
% get lower part of matrix
temp = nonzeros(tril(connectivitymat));
temp(temp==1)=[]; % clear 1's on the diagonal

% find 1 std above median connectivity value
ISPC_thresh = std(temp)+median(temp);

% plot histogram and vertical line at threshold
[y,x] = hist(temp,30);
h=bar(x,y,'histc');
hold on
plot([ISPC_thresh ISPC_thresh],get(gca,'ylim'),'m','linew',2)

% make nice
set(h,'linestyle','none')
set(gca,'xtick',0:.2:1,'xlim',[0 1])
xlabel('ISPC'), ylabel('Count') 


subplot(223)

% make symmetric wPLI connectivity matrix
wPLI_mat = connectivitymat;
wPLI_mat(logical(tril(wPLI_mat))) = 0; % eliminate lower triangle
wPLI_mat = wPLI_mat + triu(wPLI_mat)';  % mirror lower triangle to upper triangle
wPLI_mat(wPLI_mat<wPLI_thresh)=0;
imagesc(wPLI_mat)
set(gca,'clim',[0 1]);
axis square
colorbar


subplot(224)

% make symmetric ISPC connectivity matrix
ISPC_mat = connectivitymat;
ISPC_mat(logical(triu(ISPC_mat))) = 0; % eliminate UPPER triangle
ISPC_mat = ISPC_mat + tril(ISPC_mat)';  % mirror lower triangle to upper triangle
ISPC_mat(ISPC_mat<ISPC_thresh)=0;
imagesc(logical(ISPC_mat)) % logical converts to 0's and 1's, thus binarizing connectivity matrix
set(gca,'clim',[0 1]);
axis square 
% 
% interpolation_levelX = 50; 
% interpolation_levelY = 150;% you can try changing this number, but 100 is probably good
% interpX = linspace((min(electrode_locs_X)-0.5),(max(electrode_locs_X)+0.5),interpolation_levelX);
% interpY = linspace((min(electrode_locs_Y)-0.5),(max(electrode_locs_Y)+0.5),interpolation_levelY);
% 
% % meshgrid is a function that creates 2D grid locations based on 1D inputs
% [gridX,gridY] = meshgrid(interpX,interpY);




figure 
G = graph(wPLI_mat);
D=degree(G);
p=plot(G, 'XData',electrode_locs_X,'YData', electrode_locs_Y); 
p.MarkerSize=D;


% subplot(1,2,2); 
% D=degree(G);
% interpolated_degree = griddata(electrode_locs_X,electrode_locs_Y,D,gridX,gridY);
% contourf(interpX,interpY,interpolated_degree,100,'linecolor','none');hold on
% scatter(electrode_locs_X,electrode_locs_Y);
% axis square
% set(gca,'clim',[0 32],'xlim',[min(interpX) max(interpX)]*1.1,'ylim',[min(interpY) max(interpY)]*1.1)
% title('Connectivity degree')
% colorbar
% 
