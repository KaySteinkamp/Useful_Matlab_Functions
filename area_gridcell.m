function acell = area_gridcell(lon,lat)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This script calculates grid cell area in m^2 from lon/lat coordinates, 
% using the Haversine formula on a spherical earth of radius 6378.137km.
%
% Distances are probably good to better than 1% of the "true" distance 
% on the ellipsoidal earth. Code based on (and extended upon) m_lldist 
% routine written by Rich Pawlowicz (rich@ocgy.ubc.ca) 6/Nov/00. 
%
% lon & lat must be given as sorted vectors and must specify a regular 
% grid. It is assumed that lon/lat specify the center of grid cells.
% UPDATE,
% Regular grid constraint removed,
%
% Author: Kay Steinkamp (kay.steinkamp@niwa.co.nz)
% Date: Nov 2013
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% add supplemental Matlab paths
addpath '~/Programming/Matlab/m_map'

% ensure lon/lat are given in vector (not meshgrid/ndgrid) format
if ~isvector(lon) || ~isvector(lat)
    error('Lon/Lat must be given in vector form (do not use meshgrid or ndgrid)')
else
    nlon = length(lon);
    nlat = length(lat);
end

% ensure lon/lat are sorted
if ~isequal(lon,sort(lon)) || ~isequal(lat,sort(lat))
    error('Lon/Lat must be sorted')
else
    dlat = diff(lat);
end

% get coordinates of edges rather than centers
% UPDATE: need latitudes of edges as well as length of both latitudinal
%         and longitudinal edges, however don't need longitudes of edges.
if iscolumn(lat), latE = nan(nlat,1); else latE = nan(1,nlat); end
if iscolumn(lon), dlonE = nan(nlon,1); else dlonE = nan(1,nlon); end

latE(1) = lat(1) - dlat(1)/2;
latE(2:nlat) = lat(2:nlat) - dlat(1:nlat-1)/2;
latE(nlat+1) = lat(nlat) + dlat(nlat-1)/2;

dlatE = diff(latE);

dlonE(1) = lon(2) - lon(1);
dlonE(2:nlon-1) = 0.5*(lon(3:nlon) - lon(1:nlon-2));
dlonE(nlon) = lon(nlon) - lon(nlon-1);

% convert to radians
latE = latE*(pi/180);
dlatE = dlatE*(pi/180);
dlonE = dlonE*(pi/180);


% calculate area of grid cells
% ----------------------------------------------------------------------
% Based on Haversine formula to compute distances between two pints on
% earth surface given in lon/lat coordinates:
% a = (sin(dlat/2)).^2 + cos(lat1) .* cos(lat2) .* (sin(dlon/2)).^2;
% angles = 2 * earthR * atan2( sqrt(a), sqrt(1-a) );
% ----------------------------------------------------------------------
earthR = 6378.137;

% Edges in latitudinal direction can be calculated out of loop 
% (they do not depend on longitude)
a = (sin(dlatE/2)).^2;
dy = 2 * earthR * atan2( sqrt(a), sqrt(1-a) );

b = (sin(dlonE/2)).^2;
for i = 1:nlat
    a = cos(latE(i)) .* cos(latE(i+1)) .* b;
    dx = 2 * earthR * atan2( sqrt(a), sqrt(1-a) ); 
    acell(:,i) = dy(i) * dx;
end

% convert from km^2 to m^2
acell = acell * 1e6; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%