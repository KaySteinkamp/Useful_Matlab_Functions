function p = erfcinv(z)
%ERFCINV Inverse incomplete error function.
%
%   X = ERFCINV(Y) is the inverse incomplete error function for each element of
%   Y.  The incomplete inverse error functions satisfies y = erfc(x), for 0 <=
%   y <= 2 and -inf <= x <= inf.
%
%   See also ERFC, ERF.

%   Author:      Peter J. Acklam
%   Time-stamp:  2003-04-13 11:45:24 +0200
%   E-mail:      pjacklam@online.no
%   URL:         http://home.online.no/~pjacklam

p = -ltqnorm(z / 2) / sqrt(2);
