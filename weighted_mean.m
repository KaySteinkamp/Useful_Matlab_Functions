function wmean = weighted_mean(datenvektor, gewichtsvektor)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This functions calculates a weighted mean of the values contained in
% "datenvektor" using the weights contained in "gewichtsvektor".
%
% In case any of the two vectors contains NaNs, the script returns NaN.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if any(isnan(datenvektor)) || any(isnan(gewichtsvektor)) || ...
   length(datenvektor)~=length(gewichtsvektor)    

    error('weighted_mean: invalid input arguments')
end

wmean = sum(gewichtsvektor.*datenvektor)/sum(gewichtsvektor);

clear datenvektor
clear gewichtsvektor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%