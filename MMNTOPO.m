TRANGE = [-0.05, 0.40];
times2plot = 0.15;
%Convert times to plot into index
timepointidx = (times2plot-TRANGE(1))*1000+1;
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
figure;
interpolated_EEG_dataMMN = griddata(electrode_locs_X,electrode_locs_Y,meanMMN(:,timepointidx),gridX,gridY);
contourf(interpX,interpY,interpolated_EEG_dataMMN,100,'linecolor','none');hold on
scatter(electrode_locs_X,electrode_locs_Y);
axis square
set(gca,'clim',[-50 20],'xlim',[min(interpX) max(interpX)]*1.1,'ylim',[min(interpY) max(interpY)]*1.1)
title('9 Mon 13846 CTNS KO Topographical Map 1600ms ISI');
colorbar;
axis off;
a = colorbar;
a.Label.String = 'Difference in ERP(uv)';