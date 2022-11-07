function data = arfread(path, varargin)
%ARFREAD  TDT arf file reader.
%   data = arfread(PATH), where PATH is a string containing the path to an 
%   arf file, retrieves all data from specified arf file in struct format.
%
%   data.groups
%     contains array of all group information 
%
%   data.groups(..).recs
%     contains array of all record information from the indexed group
%
%   data.groups(..).recs(..).data
%     contains the actual ABR data from the indexed group and record
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

data = struct('RecHead', [], 'groups', []);

%open file
fid = fopen(path,'r');
if fid == -1, error(['error opening file ' path]), end

%open RecHead data
data.RecHead.ftype=fread(fid,1,'int16');
data.RecHead.ngrps=fread(fid,1,'int16');
data.RecHead.nrecs=fread(fid,1,'int16');
data.RecHead.grpseek=fread(fid,200,'int32');
data.RecHead.recseek=fread(fid,2000,'int32');
data.RecHead.file_ptr=fread(fid,1,'int32');

data.groups = [];
bFirstPass = true;
for x = 1:data.RecHead.ngrps
    
    % jump to the group location in the file
    fseek(fid,data.RecHead.grpseek(x),'bof');

    % open the group
    data.groups(x).grpn=fread(fid,1,'int16');
    data.groups(x).frecn=fread(fid,1,'int16');
    data.groups(x).nrecs=fread(fid,1,'int16');
    data.groups(x).ID=char(fread(fid,16,'char')');
    data.groups(x).ref1=char(fread(fid,16,'char')');
    data.groups(x).ref2=char(fread(fid,16,'char')');
    data.groups(x).memo=char(fread(fid,50,'char')');

    % read temporary timestamp
    if bFirstPass
        ttt = fread(fid,1,'int64');
        fseek(fid, -8, 0);
        % make sure timestamps make sense
        data.fileTime = datestr(ttt/86400+datenum(1970,1,1));
        data.fileType = 'BioSigRZ';
        bFirstPass = false;
    end
    
    data.groups(x).beg_t=fread(fid,1,'int64');
    data.groups(x).end_t=fread(fid,1,'int64');

    data.groups(x).sgfname1=char(fread(fid,100,'char')');
    data.groups(x).sgfname2=char(fread(fid,100,'char')');

    data.groups(x).VarName1=char(fread(fid,15,'char')');
    data.groups(x).VarName2=char(fread(fid,15,'char')');
    data.groups(x).VarName3=char(fread(fid,15,'char')');
    data.groups(x).VarName4=char(fread(fid,15,'char')');
    data.groups(x).VarName5=char(fread(fid,15,'char')');
    data.groups(x).VarName6=char(fread(fid,15,'char')');
    data.groups(x).VarName7=char(fread(fid,15,'char')');
    data.groups(x).VarName8=char(fread(fid,15,'char')');
    data.groups(x).VarName9=char(fread(fid,15,'char')');
    data.groups(x).VarName10=char(fread(fid,15,'char')');

    data.groups(x).VarUnit1=char(fread(fid,5,'char')');
    data.groups(x).VarUnit2=char(fread(fid,5,'char')');
    data.groups(x).VarUnit3=char(fread(fid,5,'char')');
    data.groups(x).VarUnit4=char(fread(fid,5,'char')');
    data.groups(x).VarUnit5=char(fread(fid,5,'char')');
    data.groups(x).VarUnit6=char(fread(fid,5,'char')');
    data.groups(x).VarUnit7=char(fread(fid,5,'char')');
    data.groups(x).VarUnit8=char(fread(fid,5,'char')');
    data.groups(x).VarUnit9=char(fread(fid,5,'char')');
    data.groups(x).VarUnit10=char(fread(fid,5,'char')');

    data.groups(x).SampPer_us=fread(fid,1,'float');

    data.groups(x).cc_t=fread(fid,1,'int32');
    data.groups(x).version=fread(fid,1,'int16');
    data.groups(x).postproc=fread(fid,1,'int32');
    data.groups(x).dump=char(fread(fid,92,'char')');

    %disp(data.groups(x).ID)
    %disp(data.groups(x).ref1)
    %disp(data.groups(x).ref2)
    
    data.groups(x).recs = [];%cell(1, data.groups(x).nrecs);
    for i=1:data.groups(x).nrecs
        data.groups(x).recs(i).recn=fread(fid,1,'int16');
        data.groups(x).recs(i).grpid=fread(fid,1,'int16');

        data.groups(x).recs(i).grp_t=fread(fid,1,'int64');

        data.groups(x).recs(i).newgrp=fread(fid,1,'int16');
        data.groups(x).recs(i).sgi=fread(fid,1,'int16');
        data.groups(x).recs(i).chan=fread(fid,1,'char');
        data.groups(x).recs(i).rtype=fread(fid,1,'char');

        data.groups(x).recs(i).npts=fread(fid,1,'uint16');
        data.groups(x).recs(i).osdel=fread(fid,1,'float');
        data.groups(x).recs(i).dur_ms=fread(fid,1,'float');
        data.groups(x).recs(i).SampPer_us=fread(fid,1,'float');

        data.groups(x).recs(i).artthresh=fread(fid,1,'float');
        data.groups(x).recs(i).gain=fread(fid,1,'float');
        data.groups(x).recs(i).accouple=fread(fid,1,'int16');

        data.groups(x).recs(i).navgs=fread(fid,1,'int16');
        data.groups(x).recs(i).narts=fread(fid,1,'int16');

        data.groups(x).recs(i).beg_t=fread(fid,1,'int64');
        data.groups(x).recs(i).end_t=fread(fid,1,'int64');
        
        data.groups(x).recs(i).Var1=fread(fid,1,'float');
        data.groups(x).recs(i).Var2=fread(fid,1,'float');
        data.groups(x).recs(i).Var3=fread(fid,1,'float');
        data.groups(x).recs(i).Var4=fread(fid,1,'float');
        data.groups(x).recs(i).Var5=fread(fid,1,'float');
        data.groups(x).recs(i).Var6=fread(fid,1,'float');
        data.groups(x).recs(i).Var7=fread(fid,1,'float');
        data.groups(x).recs(i).Var8=fread(fid,1,'float');
        data.groups(x).recs(i).Var9=fread(fid,1,'float');
        data.groups(x).recs(i).Var10=fread(fid,1,'float');

        % skip all 10 cursors placeholders
        fseek(fid,36*10,'cof');
        
        data.groups(x).recs(i).data=fread(fid,data.groups(x).recs(i).npts,'float');
    end
    
    if PLOT
        figure;
        
        % determine reasonable spacing between plots
        d = arrayfun(@(x)(x.data), data.groups(1).recs, 'UniformOutput', false);
        plot_offset = max(max(abs(cell2mat(d))))*1.2;
        
        for i = 1:data.groups(x).nrecs
            plot(data.groups(x).recs(i).data - plot_offset*i);
            hold on;
        end
        
        % use Var2 as the Y-axis label
        %set(gca,'YTick',(-plot_offset*data.groups(x).nrecs):plot_offset:0)
        %d = arrayfun(@(x)(num2str(x.Var2)), data.groups(x).recs, 'UniformOutput', false);
        %set(gca,'YTickLabel',fliplr(d))
        
        title(['Group ' num2str(data.groups(x).grpn)]);
        axis 'off';
    end
end

fclose(fid);

