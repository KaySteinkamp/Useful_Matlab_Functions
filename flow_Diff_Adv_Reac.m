function c = flow_Diff_Adv_Reac(D, u, R)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This routine calculates the steady-state concentration distribution 
% for a 1D system with advection, diffusion and reaction (first-order).
%
% boundary conditions are:
% 1) c(x=0) = 1
% 2) c(x=1) = 0
%
% D: diffusion coefficient
% u: advection velocity
% R: reaction rate (first-order)
% 
% Author: Kay
% Date: Feb 2010
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% parameters
l1 = u/(2*D)+sqrt((u/(2*D))^2+R/D);
l2 = u/(2*D)-sqrt((u/(2*D))^2+R/D);
a = (exp(l1-l2) - 1)^-1;

% coordinates
xx = 0:0.001:1;

% concentration function
fc = @(x) (exp(l2*x) + a*(exp(l2*x) - exp(l1*x)));

% concentration as array
c = fc(xx);

% make plot
figure
plot(xx, c, 'blue')
set(gca,'xlim',[0,1],'ylim',[0 1])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
