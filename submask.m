function mask = submask(matrix, part)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This masks out some part of a (square) matrix.
% part can be:
% - ‘diagonal’
% - ‘offdiag’
% - ‘uppertria’
% - ‘lowertria’
% 
% Author: Kay
% Date: Oct 2009
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% handle input matrix
if ~isequal(ndims(matrix), 2) 
    error('submask: input is not a matrix')
end

[rows, cols] = size(matrix);
if ~isequal(rows, cols) 
    error('submask: input matrix is not square')
else
    siz = rows;
    clear rows cols
end

% possible parts
switch part
    case 'diagonal'
        mask = logical(eye(siz));               
    case 'offdiag'
        mask = ~logical(eye(siz));
    case 'uppertria'
        mask = logical(triu(ones(siz,siz)));
    case 'lowertria'
        mask = logical(tril(ones(siz,siz)));
    otherwise
        error('submask: unsupported part of matrix')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%