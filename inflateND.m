function arrayMD = inflateND(arrayND, sizeM)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This reads in a N-dimensional array (e.g. a 2D matrix) and returns
% a M=N+1-dimensional array with its extra dimension filled with copies
% of the original array.
% The length of the extra dimension (i.e. the number of copies) is 
% given by sizeM.
% 
% Author: Kay
% Date: Oct 2009
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% check desired size of extra dimension
if sizeM <= 0
    error('inflateND: invalid input size of extra dimension')
elseif sizeM == 1
    % simply return input array in this case
    arrayMD = arrayND;
    return
end

% get the size and dimensionality of the input array
sizeND = size(arrayND);
N = ndims(arrayND);

% handle scalars and vecrors
% NOTE that Matlab assigns 2 dimensions also for vectors and scalars
if N == 2 && any(sizeND == 1)
    if all(sizeND == 1)   % input is a scalar
        arrayMD = arrayND * ones(sizeM,1);
        return
    elseif sizeND(1) == 1 % input is a row vector
        arrayMD = ones(sizeM,1) * arrayND;
        return            
    else                  % input is a column vector
        arrayMD = arrayND * ones(1,sizeM);
        return
    end
end

% handle matrices and multi-dimensional arrays
if any(sizeND == 1)
    disp('Multi-dimensional input array must not have singleton dimensions')
    error('inflateND: invalid input array')
else
    % set the size of the output array
    sizeMD = [sizeND, sizeM];
    arrayMD = zeros(sizeMD);

    % use linear indexing as we cannot specify something like
    % arrayMD(:,:,:,:,m) here, as we dont know the number of ":"
    linidx = prod(sizeND);

    % populate the output array
    for m = 1:sizeM
        idxblock = (m-1)*linidx+1:m*linidx;
        arrayMD(idxblock) = arrayND;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%