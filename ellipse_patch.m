function X = ellipse_patch(mu, D, cb)
%
%  ellipse_patch(D,mu,k,N) calculates patch verteces for a 2D ellipse 
%  represented by the quadratic form:  
%               
%                   (x-mu)' D^-1 (x-mu) = k
%
%  Inputs: 
%  D: 2x2 matrix --> covariance matrix
%  mu: 2D vector which represents the center of the ellipse.
%  cb: confidence bounds, e.g. cb=0.68 for 68%
%  (k is derived from cb using the "inverse chi squared cdf")
%
% To actually plot the ellipse, use m_patch (or patch) with the 
% vertex data contained in X.
%
%%%%%%%%%%%  start  %%%%%%%%%%%%%%%%%%%%%%%%%%%

N = 20;   % Default value for grid

% check the dimension of the inputs: 2D or 3D
%--------------------------------------------
if length(mu)~=2,
    display('Cannot plot an ellipse with other than 2 dimensions!');
    return
end
if cb<0 || cb>1
    display('Give confidence bounds between 0 and 1');
    return
end

% "singular value decomposition" to extract the orientation and the
% axes of the ellipse
[U S V] = svd(D); %#ok<ASGLU>

% compute k from confidence bounds 
% using chi^2 statistics
%----------------------------------------
% k is prescribed if access to statistics toolbox functions
% is denied (e.g. due to license manager problems)
try
    k = chi2inv(cb,2);    % 2 degrees of freedom as D is 2x2 matrix
catch %#ok<CTCH>
    k = 2.28;   % for cb=0.68
end

% get the major and minor axes
%----------------------------------------
a = sqrt(k*S(1,1));
b = sqrt(k*S(2,2));

% Parametric equation of the ellipse
%----------------------------------------
theta = 0 : 1/N : 2*pi+1/N;

state(1,:) = a*cos(theta); 
state(2,:) = b*sin(theta);

% Coordinate transform (rotate ellipse)
%----------------------------------------
X = V * state;
X(1,:) = X(1,:) + mu(1);
X(2,:) = X(2,:) + mu(2); 

% Plot the ellipse
%----------------------------------------
% ell = m_patch(X(1,:),X(2,:),[.8 .8 .8],'FaceAlpha',0.5);

%%%%%%%%%%%  end  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%