function dist = geoDistance(lat1, lon1, lat2, lon2)

%#######################################################################
% Calculates distance between two points on the earth's surface,  
% assuming spherical earth.
%
% Kay Steinkamp 21/09/2012
%-----------------------------------------------------------------------
% Inputs:
%  lat1/2        : latitudes of both points, can be vectors
%  lon1/2        : longitudes of both points, can be vectors
%
% Outputs:
%  dist          : geographic distance 
%                 (vector output if inputs are vectors)
%#######################################################################

r = 6371.0;

% Check for appropriate coordinates
if ~isequal(size(lat1),size(lon1)) || ~isequal(size(lat1),size(lat2)) ...
   || ~isequal(size(lat1),size(lon2))

    error('Distance fatal error: input arrays must have equal size')
end

if any(lat1 > 90) || any(lat1 < -90) || any(lat2 > 90) || ...
   any(lat2 < -90) || any(lon1 > 360) || any(lon1 < -180) || ...
   any(lon2 > 360) || any(lon2 < -180)

    error('Distance fatal error: coordinate out of range')
end 

phi1 = pi/180.0 .* (90.0-double(lat1));
phi2 = pi/180.0 .* (90.0-double(lat2));
theta1 = pi/180.0 .* double(lon1);
theta2 = pi/180.0 .* double(lon2);

dist = r * acos(sin(phi1).*cos(theta1).*sin(phi2).*cos(theta2) ...
                + sin(phi1).*sin(theta1).*sin(phi2).*sin(theta2) ...
                + cos(phi1).*cos(phi2));  

end 

%-----------------------------------------------------------------------