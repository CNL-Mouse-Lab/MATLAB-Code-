function data = awfread(path, varargin)
%AWFREAD  TDT awf file reader.
%   data = awfread(PATH), where PATH is a string containing the path to an 
%   awf file, retrieves all data from specified awf file in struct format.
%
%   data.groups
%     contains array of all group information 
%
%   data.groups(..).wave
%     contains the actual ABR data from the indexed group
%
%   data = arfread(PATH, 'parameter', value,...)
%
%   'parameter', value pairs
%      'PLOT'       logical, turns plotting on or off (default = false)
%

% defaults
PLOT     = false;

% parse varargin
for i = 1:2:length(varargin)
    eval([upper(varargin{i}) '=varargin{i+1};']);
end

isRZ = false;

data = struct('RecHead', [], 'groups', []);

%open file
fid = fopen(path,'r');
if fid == -1, error(['error opening file ' path]), end

%open RecHead data
data.RecHead.nens=fread(fid,1,'int16');
data.RecHead.ymax=fread(fid,1,'single');
data.RecHead.ymin=fread(fid,1,'single');
data.RecHead.autoscale=fread(fid,1,'int16');

data.RecHead.size=fread(fid,1,'int16');
data.RecHead.gridsize=fread(fid,1,'int16');
data.RecHead.showgrid=fread(fid,1,'int16');

data.RecHead.showcur=fread(fid,1,'int16');

data.RecHead.TextMargLeft=fread(fid,1,'int16');
data.RecHead.TextMargTop=fread(fid,1,'int16');
data.RecHead.TextMargRight=fread(fid,1,'int16');
data.RecHead.TextMargBottom=fread(fid,1,'int16');

data.groups = [];
bFirstPass = true;

for x = 1:30

    data.groups(x).recn=fread(fid,1,'int16');
    data.groups(x).grpid=fread(fid,1,'int16');
    
    % read temporary timestamp
    if bFirstPass
        ttt = fread(fid,1,'int64');
        fseek(fid, -8, 0);
        % make sure timestamps make sense
        if now - (ttt / 86400 + datenum(1970, 1, 1)) > 0
            isRZ = true;
            data.fileTime = datestr(ttt/86400+datenum(1970,1,1));
            data.fileType = 'BioSigRZ';
        else
            ttt = fread(fid,1,'uint32');
            data.fileTime = datestr(ttt/86400+datenum(1970,1,1));
            fseek(fid, -4, 0);
            data.fileType = 'BioSigRP';
        end
        bFirstPass = false;
    end
    
    if isRZ
        data.groups(x).grp_t=fread(fid,1,'int64');
    else
        data.groups(x).grp_t=fread(fid,1,'int32');
    end
    
    data.groups(x).newgrp=fread(fid,1,'int16');
    data.groups(x).sgi=fread(fid,1,'int16');
    data.groups(x).chan=int16(fread(fid,1,'char'));
    data.groups(x).rtype=int16(fread(fid,1,'char'));
    
    data.groups(x).npts=fread(fid,1,'int16');
    data.groups(x).osdel=fread(fid,1,'single');
    data.groups(x).dur=fread(fid,1,'single');
    data.groups(x).srate=fread(fid,1,'single');
    
    data.groups(x).arthresh=fread(fid,1,'single');
    data.groups(x).gain=fread(fid,1,'single');
    data.groups(x).accouple=fread(fid,1,'int16');

    data.groups(x).navgs=fread(fid,1,'int16');
    data.groups(x).narts=fread(fid,1,'int16');
  
    if isRZ
        data.groups(x).beg_t=fread(fid,1,'int64');
        data.groups(x).end_t=fread(fid,1,'int64');
    else
        data.groups(x).beg_t=fread(fid,1,'int32');
        data.groups(x).end_t=fread(fid,1,'int32');
    end
    
    data.groups(x).vars = zeros(1,10);
    for jj = 1:10
        data.groups(x).vars(jj) = fread(fid,1,'single');
    end

    data.groups(x).cursors = [];
    for jj = 1:10
        data.groups(x).cursors(jj).tmark = fread(fid,1,'single');
        data.groups(x).cursors(jj).val = fread(fid,1,'single');
        data.groups(x).cursors(jj).desc = fread(fid,20,'*char')';
        data.groups(x).cursors(jj).xpos = fread(fid,1,'int16');
        data.groups(x).cursors(jj).ypos = fread(fid,1,'int16');
        data.groups(x).cursors(jj).hide = fread(fid,1,'int16');
        data.groups(x).cursors(jj).lock = fread(fid,1,'int16');
    end
    
    % open the group
    data.groups(x).grpn=fread(fid,1,'int16');
    data.groups(x).frecn=fread(fid,1,'int16');
    data.groups(x).nrecs=fread(fid,1,'int16');
    data.groups(x).ID=fread(fid,16,'*char')';
    data.groups(x).ref1=fread(fid,16,'*char')';
    data.groups(x).ref2=fread(fid,16,'*char')';
    data.groups(x).memo=fread(fid,50,'*char')';

    if isRZ
        data.groups(x).beg_t=fread(fid,1,'int64');
        data.groups(x).end_t=fread(fid,1,'int64');
    else
        data.groups(x).beg_t=fread(fid,1,'int32');
        data.groups(x).end_t=fread(fid,1,'int32');
    end

    data.groups(x).sgfname1=fread(fid,100,'*char')';
    data.groups(x).sgfname2=fread(fid,100,'*char')';

    data.groups(x).VarName1=fread(fid,15,'*char')';
    data.groups(x).VarName2=fread(fid,15,'*char')';
    data.groups(x).VarName3=fread(fid,15,'*char')';
    data.groups(x).VarName4=fread(fid,15,'*char')';
    data.groups(x).VarName5=fread(fid,15,'*char')';
    data.groups(x).VarName6=fread(fid,15,'*char')';
    data.groups(x).VarName7=fread(fid,15,'*char')';
    data.groups(x).VarName8=fread(fid,15,'*char')';
    data.groups(x).VarName9=fread(fid,15,'*char')';
    data.groups(x).VarName10=fread(fid,15,'*char')';

    data.groups(x).VarUnit1=fread(fid,5,'*char')';
    data.groups(x).VarUnit2=fread(fid,5,'*char')';
    data.groups(x).VarUnit3=fread(fid,5,'*char')';
    data.groups(x).VarUnit4=fread(fid,5,'*char')';
    data.groups(x).VarUnit5=fread(fid,5,'*char')';
    data.groups(x).VarUnit6=fread(fid,5,'*char')';
    data.groups(x).VarUnit7=fread(fid,5,'*char')';
    data.groups(x).VarUnit8=fread(fid,5,'*char')';
    data.groups(x).VarUnit9=fread(fid,5,'*char')';
    data.groups(x).VarUnit10=fread(fid,5,'*char')';

    data.groups(x).SampPer_us=fread(fid,1,'float');

    data.groups(x).cc_t=fread(fid,1,'int32');
    data.groups(x).version=fread(fid,1,'int16');
    data.groups(x).postproc=fread(fid,1,'int32');
    data.groups(x).dump=fread(fid,92,'*char')';
    
    data.groups(x).bid=fread(fid,1,'int16');
    data.groups(x).comp=fread(fid,1,'int16');
    data.groups(x).x=fread(fid,1,'int16');
    data.groups(x).y=fread(fid,1,'int16');

    data.groups(x).traceCM=fread(fid,1,'int16');
    data.groups(x).tokenCM=fread(fid,1,'int16');
    
    data.groups(x).col=fread(fid,1,'int32');
    data.groups(x).curcol=fread(fid,1,'int32');
    
    
    data.groups(x).blurb = [];
    for jj = 1:5
        data.groups(x).blurb(jj).type = fread(fid,1,'int16');
        data.groups(x).blurb(jj).incid = fread(fid,1,'int16');
        data.groups(x).blurb(jj).hide = fread(fid,1,'int16');
        data.groups(x).blurb(jj).x=fread(fid,1,'int16');
        data.groups(x).blurb(jj).y=fread(fid,1,'int16');
        data.groups(x).blurb(jj).manplace = fread(fid,1,'int16');
        data.groups(x).blurb(jj).txt = fread(fid,12,'*char')';
    end

    data.groups(x).ymax=fread(fid,1,'single');
    data.groups(x).ymin=fread(fid,1,'single');
    data.groups(x).equ = fread(fid,100,'*char')';
end

max_ind = 0;
for x = 1:30
    if data.groups(x).bid > 0 && data.groups(x).npts > 0
        npts = data.groups(x).npts;
        data.groups(x).wave = fread(fid,npts,'*single')';
        max_ind = x;
    end
end

if PLOT
    figure;

    % determine reasonable spacing between plots
    d = arrayfun(@(x)(x.wave), data.groups(1), 'UniformOutput', false);
    plot_offset = max(max(abs(cell2mat(d))))*1.2;

    for x = 1:max_ind
        plot(data.groups(x).wave - plot_offset*x);
        hold on;
    end

    % use Var2 as the Y-axis label
    %set(gca,'YTick',(-plot_offset*data.groups(x).nrecs):plot_offset:0)
    %d = arrayfun(@(x)(num2str(x.Var2)), data.groups(x).recs, 'UniformOutput', false);
    %set(gca,'YTickLabel',fliplr(d))

    title(['Group ' num2str(data.groups(x).grpn)]);
    axis 'off';
end

fclose(fid);

end