function arrayND = diagMD(arrayMD)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This reads in a MD array with M=N+1, extracts the diagonal elements 
% of each matrix (ie. first 2 dimensions) along all extra (ie. those 
% beyond the first 2) dimensions, and returns a ND array with the diags 
% in the first dimension followed by the former extra dimensions.
%
% Note: for 3D input arrays, you can equivalently use the diag3D routine.
% 
% Author: Kay
% Date: Nov 2009
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% get the size and dimensionality of the input array
sizeMD = size(arrayMD);
M = ndims(arrayMD);

% for all input of max. 2 dimension use the Matlab built-in command
if M <= 2
    arrayND = diag(arrayMD);
    return
end

% size of "extra" dimensions in input array
sizextra = sizeMD(3:M);

% "total" length of first 2 dimensions in input array
siz1 = sizeMD(1);
siz2 = sizeMD(2);
siz1x2 = siz1 * siz2;

% size of first dimension in output array
siz0 = min(sizeMD(1:2));

% set the size of the output array, N=M-1
sizeND = [siz1, sizextra];
arrayND = zeros(sizeND);

% use linear indexing as we cannot specify something like
% arrayND(n,:,:,:) here, as we don't know the number of ":"
totextra = prod(sizextra); % "total" length of all extra dims

% populate the output array
for n = 1:totextra
    idxblockN = (n-1)*siz0+1:n*siz0;
    idxblockM = (n-1)*siz1x2+1:n*siz1x2;    
    arrayND(idxblockN) = diag(reshape(arrayMD(idxblockM),[siz1 siz2]));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%