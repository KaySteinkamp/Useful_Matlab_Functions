function r = sample_multi_gaussian(mu,cov,npoints,mflag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This script samples a multivariate normal distribution with mean 
% vector mu and covariance matrix cov.
% It returns a (npoints x dimensions) matrix.
%
% As long as the conditions symmetry and (semi-) positive definitness
% are sufficiently fulfilled (ie. within a prescribed bound, see below),
% a MatLab built-in routine is used, otherwise a Cholesky decomposition
% is used (but still the covariance matrix must be close to symmetric 
% and positive definit!)
% 
% Author: Kay
% Date: Sep 2008
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 4
    mflag = true;
end

tol = 10*eps(full(max(abs(diag(cov)))));

if any(any(abs(cov - cov') > 100*tol))
    error('sample_multi_gaussian: covariance matrix not symmetric!')
end

if any(any(abs(cov - cov') > tol))
    disp(strcat('sample_multi_gaussian: covariance matrix is not', ...
                ' perfectly symmetric -> using Cholesky decomposition'));
    mflag = false;
end

% use MatLab built-in function
if mflag
    r = mvnrnd(mu,cov,npoints);
    % plot(r(:,1),r(:,2),'+')

% Cholesky decomposition plus univariate standard normal random numbers
else
    ndim = length(mu);
    r = zeros(npoints,ndim);
    L = chol(cov,'lower');
    for i=1:npoints
        z = normrnd(0,1,ndim,1);
        r(i,:) = mu + L*z;
    end
end     
        
    