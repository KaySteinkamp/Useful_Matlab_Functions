function p = erfcinv_own(z)
%ERFCINV Inverse incomplete error function.
%
%   X = ERFCINV(Y) is the inverse incomplete error function for each element of
%   Y.  The incomplete inverse error functions satisfies y = erfc(x), for 0 <=
%   y <= 2 and -inf <= x <= inf.
%

p = -ltqnorm(z / 2) / sqrt(2);
