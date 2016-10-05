function [wmean, wstd] = weighted_stdev(datenvektor, gewichtsvektor)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This functions calculates a weighted standard deviation of the values 
% in "datenvektor" using the weights contained in "gewichtsvektor".
% The weighted mean value is also returned.
%
% "gewichtsvektor" must contain nonzero, nonNaN, positive values.
% "datenvektor" must contain nonNaN values.
% The length of both vectors must match.
%
% It is discriminated between three cases:
% 1) length(datenvektor) == 1: 
%    just take the inverse of gewichtsvektor (single value) as wstd
% 2) length(datenvektor) == 2:
%    as case 3, but normalize with 1.
% 3) length(datenvektor) >= 3:
%    compute wstd using the common weighted standard deviation formula
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if any(isnan(datenvektor)) || any(isnan(gewichtsvektor)) || ...
   length(datenvektor) ~= length(gewichtsvektor) || ...
   any(gewichtsvektor <= 0)

    error('weighted_stdev: invalid input arguments')   
end

switch length(datenvektor)
    
    case 1
        % now gewichtsvektor and datenvektor are single values
        wmean = datenvektor;
        wstd = 0.;
        
    case 2
        norm = 1;
        wmean = weighted_mean(datenvektor,gewichtsvektor);
        devsum = sum(gewichtsvektor.*(datenvektor - wmean).^2);
        wstd = sqrt(devsum/norm);
        
    otherwise
        norm = sum(gewichtsvektor) - 1;
        wmean = weighted_mean(datenvektor,gewichtsvektor);
        devsum = sum(gewichtsvektor.*(datenvektor - wmean).^2);
        wstd = sqrt(devsum/norm);

end

clear datenvektor
clear gewichtsvektor
clear norm
clear devsum

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%