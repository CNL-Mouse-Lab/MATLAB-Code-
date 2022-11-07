%% MMN CONTROLLER
function [seqmtx] = MMN_makeSequence(ntrls,nsections,nreps)

% make a sequence for oddball paradigm with the following rules:
% 1 = standard, 2 = deviant.
% No deviants in the first 2 trials
% A deviant has to be preceded by at least 2 standards
% standards comprise 85% of the sequence and deviants 15%
% the sequence is pseudorandom otherwise.
% constructs a matrix of multple rows (nreps) that you can randomly pick from :)

% code works by appending sections (nsections) of trials (ntrls) to optimize processing time. 
% chunks (a chunk = ntrls/nsections) of 100 trials seems to work ok. much
% longer and randomness becomes your enemy

seqmtx=[];
sequence=[];
lilbits=ntrls/nsections;

for b = 1:nreps
  for m = 1:nsections
        
        standard_vec = ones(1,lilbits*0.85);
        deviant_vec = 2.*ones(1,lilbits*0.15);
        seq = [standard_vec deviant_vec];
        
        valid_seq = 0;
        while ~valid_seq
            seq = seq(randperm(length(seq)));
            valid_seq = 1;

            for i = 2:length(seq)
                if i == 2 
                    if seq(i) == 2 && seq(i-1) == 2
                        valid_seq = 0;
                    end
                elseif seq(i) == 2 && (seq(i-1) == 2 || seq(i-2) == 2)
                    valid_seq = 0;
                end
            end
            if seq(end) == 2 || seq(end-1) == 2
                valid_seq = 0;
            end 
            if seq(1)==2 || seq(2)==2
                valid_seq = 0;
        end
    end
sequence=horzcat(sequence,seq);
  end
     if any(diff(find(sequence==2))<3)
        disp('Something''s wrong here!!')
        keyboard
    end  
seqmtx=vertcat(seqmtx,sequence);
sequence=[];
end

end