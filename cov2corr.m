function corrmat = cov2corr(covmat, varargin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This returns the correlation matrix for an input covariance matrix.
%
% When optionally set, the input matrix is being checked on:
% 1) squareness
% 2) symmetry
% 3) positive semi-definitness
% 
% 
% Author: Kay
% Date: Nov 2009
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% handle optional input
switch nargin
    case 1
        docheck = false;    % this is the default
    case 2
        docheck = logical(varargin{1});
        eps = 1e-10;
    case 3
        docheck = logical(varargin{1});
        eps = varargin{2};
    otherwise
        error('cov2corr: invalid arguments')
end

% optionally check on covariance characteristics
if docheck
    % is it a square matrix?
    if ~(isequal(ndims(covmat),2) && isequal(size(covmat,1),size(covmat,2)))
        error('cov2corr: covariance matrix is not square');
    end
    % is it symmetric?
    if any(any(abs(covmat - covmat') > eps))
        error('cov2corr: covariance matrix is not symmetric');
    end
    % is it positive semi-definit?
    if any(eig(covmat) < 0)
        error('cov2corr: covariance matrix is not positive semi-definit');
    end
end

% calculate correlation matrix
corrmat = diag(diag(covmat).^-0.5) * covmat * diag(diag(covmat).^-0.5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%