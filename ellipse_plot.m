function [ell,cen,scat,val] = ellipse_plot(mu, D, cb, varargin)
%
%  ellipse_Plot(D,mu,k,N) plots a 2D ellipse represented by the 
%  quadratic form:  
%               
%                   (x-mu)' D^-1 (x-mu) = k
%
%  Inputs: 
%  D: 2x2 matrix --> covariance matrix
%  mu: 2D vector which represents the center of the ellipse.
%  cb: confidence bounds, e.g. cb=0.68 for 68%
%  (k is derived from cb using the "inverse chi squared cdf")
%  N: number of grid points for plotting the ellipse; Default: N = 20. 
%  nsam: number of samples drawn from the underlying MVN distribution
%
%   Kay Steinkamp
% Sep 10, 2008
%   extended by confidence bounds (e.g. 68% or 95%) for the 2D case.
%   underlying multivariate normal distribution assumed.
% Sep 11, 2008
%   added a scatter plot for (1000) samples of the pdf.
%   added also a test regarding the conf.bnds. (by counting those
%   samples lying inside (or on) the ellipse). 
%   val should be very close to cb
%%%%%%%%%%%  start  %%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 20;             % Default value for grid
nsam = 1000;        % Default value for sampling size
scatplot = true;    % Draw scatter plot by default

% See if the user wants a different value for N.
%----------------------------------------------
if nargin > 3
 	scatplot = logical(varargin{1});
end
if nargin > 4
 	N = varargin{2};
end
if nargin > 5
 	nsam = varargin{3};
end

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
[U S V] = svd(D);

% compute k from confidence bounds 
% using chi^2 statistics
%----------------------------------------
% k is prescribed if access to statistics toolbox functions
% is denied (e.g. due to license manager problems)
try
    k = chi2inv(cb,2);    % 2 degrees of freedom as D is 2x2 matrix
catch
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
% ell=patch(X(1,:),X(2,:),[1 1 1]);
ell=m_patch(X(1,:),X(2,:),[.8 .8 .08],'FaceAlpha',0.99);
hold on;
% cen=plot(mu(1),mu(2),'blue+');
% cen=m_plot(mu(1),mu(2),'blue+','MarkerSize',5);
% axis equal

% Sample PDF and validate confidence
%----------------------------------------
if scatplot
    sam = sample_multi_gaussian(mu,D,nsam);
    scat=scatter(sam(:,1),sam(:,2),'.','g');
    set(gca, 'Children',[ell,cen,scat]);
    hold off

    qf = [sam(:,1)'-mu(1); sam(:,2)'-mu(2)]'*inv(D)*[sam(:,1)'-mu(1); sam(:,2)'-mu(2)];
    qf = diag(qf);
    % The following code can also be used (it's more intuitive, but slower)
    % qf=zeros(nsam,1);
    % for i=1:nsam
    %     qf(i)=[sam(i,1)-mu(1);sam(i,2)-mu(2)]'*inv(D)*[sam(i,1)-mu(1);sam(i,2)-mu(2)];
    % end
    val=length(find(qf<=k))/nsam;
else
    scat=-99;
    val=-99;
end
%%%%%%%%%%%  end  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%