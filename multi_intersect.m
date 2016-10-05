function [common, idx] = multi_intersect(multicell)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This script is an extension to the Matlab built-in function
% "intersect".
% In contrast to that function, this one is capable of generating the
% intersection of more than 2 cell arrays (or character arrays).
% 
% Author: Kay
% Date: Jul 2008
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% cd /home/kay/atmoinv/annualinv;
% read_paths_atmoinv;

% fclose all;

% **********************************************************************
% find intersection of all input cell arrays
% **********************************************************************
ncell = length(multicell);

% idx must be cell array because index vectors won't be of same length
idx = cell(ncell,1);

if ncell < 1
    error('Error in multi_intersect: At least 2 cell arrays as input required!');
elseif ncell == 1
    common = multicell{1};
    idx{1} = 1:length(multicell{1});
    return
end

[common,idx{1},idx{2}] = intersect(multicell{1},multicell{2});

if ncell > 2
    ic=cell(ncell-2,1);
    
    for n=3:ncell
        [common,ic{n-2},idx{n}] = intersect(common,multicell{n});
    end
    
    if ncell == 3
        for n=1:2
            for i=1:ncell-2
                idx{n}=idx{n}(ic{i});
            end
        end
        % Note: The last (ie. third) index remains as it is
        
    else  % now ncell > 3    
    % connect indices of common result with individual indices
    % first 2 indices
        for n=1:2
            for i=1:ncell-2
                idx{n}=idx{n}(ic{i});
            end
        end
        % the bulk of indices
        for n=3:ncell-1
            for i=n-1:ncell-2
                idx{n}=idx{n}(ic{i}); 
            end        
        end
        % Note: The last index remains as it is
    end
end

% **********************************************************************
% verify result
% **********************************************************************
check=true;
for n=1:ncell
    check = check && strcmp(char(multicell{n}(idx{n})),char(common));
end
if check
%     disp(' ');
%     disp('--Multi-intersection accomplished--');    
%     disp(' ');
else
    error('Error in multi_intersect: Result could not be verified!');
end
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%