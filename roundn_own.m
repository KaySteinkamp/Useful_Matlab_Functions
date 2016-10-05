function rnum = roundn_own(num,n)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Round numbers to indicated decimal precision 
%
% Intended to replace Matlab's built-in routine 'roundn', which wasn't
% yet available in the 2009 version.
% 
% 
% Author: Kay
% Date: Aug 2012
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fac = double(10^(-int8(n)));

rnum = round(num*fac)/fac;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%