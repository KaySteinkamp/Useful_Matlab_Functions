function outstr = strgrow(instr, ncopies)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This script reads a string, and returns a (longer) string, that is built 
% by appending the input string several times (specified by ncopies).
% 
% Author: Kay
% Date: Jun 2008
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

outstr='';
for i=1:ncopies
    outstr=[outstr,instr];
end