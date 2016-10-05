function wnanmean = weighted_nanmean(datenvektor, gewichtsvektor)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This functions calculates a weighted mean of the values contained in
% "datenvektor" using the weights contained in "gewichtsvektor".
%
% Any NaNs contained in the datenvektor is ignored. 
% The gewichtsvektor must not contain any NaN.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if any(isnan(gewichtsvektor)) || length(datenvektor)~=length(gewichtsvektor)    
    error('weighted_nanmean: invalid input arguments')
end

wnanmean = nansum(gewichtsvektor.*datenvektor)/sum(gewichtsvektor);

clear datenvektor
clear gewichtsvektor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%