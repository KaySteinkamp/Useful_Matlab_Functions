function [h] = pcolor_own(cx, cy, mat)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% My own pcolor routine to bypass Matlab's pcolor routine's interpretation
% of matrix dimensions as cell borders instead of cell centers.
%
% 
% Author: Kay
% Date: Dec 2012
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% get input dimensions
[nx ny] = size(mat);

if nx == 0 || ny == 0 || nx ~= length(cx) || ny ~= length(cy)
    error('Invalid matrix dimensions')
end

% expand matrix and vectors to get interpreted correctly later by pcolor
matexpanded = zeros(nx+1,ny+1);
matexpanded(1:nx,1:ny) = mat;

% shift vectors to reflect borders instead of centers of cells
bx = zeros(nx+1,1);
by = zeros(ny+1,1);

bx(1) = cx(1) - (cx(2)-cx(1))/2;
for i = 1:nx-1
    bx(i+1) = (cx(i)+cx(i+1))/2;
end
bx(nx+1) = cx(nx) + (cx(nx)-cx(nx-1))/2;
       
by(1) = cy(1) - (cy(2)-cy(1))/2;
for i = 1:ny-1
    by(i+1) = (cy(i)+cy(i+1))/2;
end
by(ny+1) = cy(ny) + (cy(ny)-cy(ny-1))/2;

% use pcolor
[X,Y] = meshgrid(by,bx);
[h] = pcolor(X, Y, matexpanded);
% [h] = pcolor(bx, by, matexpanded);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%