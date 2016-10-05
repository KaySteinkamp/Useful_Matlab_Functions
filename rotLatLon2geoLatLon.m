function [x_p,y_p] = rotLatLon2geoLatLon(polelon,polelat,x,y)

% Calculates real lat/lon (x_p, y_p); given rotated lat/lon (x,y)
% lat = y_p(i,j); lon = x_p(i,j)
% inputs: rotated pole lat and lon, vector of rotated lats and lons
%
% Kay Steinkamp, 2012

if polelat >= 0
    sin_theta_pole = sin(pi/180*polelat);
    cos_theta_pole = cos(pi/180*polelat);
else
    sin_theta_pole = -sin(pi/180*polelat);
    cos_theta_pole = -cos(pi/180*polelat);
end

sin_phi_pole = sin(pi/180*polelon);
cos_phi_pole = cos(pi/180*polelon);

Nx = length(x);
Ny = length(y);
Exi = x(:);
Eyj = y(:);

for i = 1:Nx
    for j = 1:Ny
        
        %convert to radians
        E_x = pi/180*Exi(i);
        E_y = pi/180*Eyj(j);
        
        %scale eq long to range from -180 to 180
        if E_x > pi
            E_x = E_x - 2*pi; 
        elseif E_x < -pi
            E_x = E_x + 2*pi;
        end
        
        % Compute latitude using equation (4.7)       
        arg = cos_theta_pole*cos(E_x)*cos(E_y) + sin_theta_pole*sin(E_y);
%         arg = sin_theta_pole*cos(E_x)*cos(E_y) + cos_theta_pole*sin(E_y);
        arg = min(arg, 1.0);
        arg = max(arg,-1.0);
        a_theta = asin(arg);
        y_p(i,j) = 180/pi*a_theta;
        
        % Compute longitude using equation (4.8)       
        term1 = (cos(E_x)*cos(E_y)*sin_theta_pole - sin(E_y)*cos_theta_pole);
        term2 = cos(a_theta);
        if abs(term2) < 1e-5
           a_lambda = 0.0;
        else
           arg = term1/term2;
           arg = min(arg, 1.0);
           arg = max(arg,-1.0);
           a_lambda = acos(arg);
%            a_lambda = a_lambda*sign(Exi(i)*pi/180-2*pi);
           a_lambda = a_lambda*sign(E_x);
        end
        x_p(i,j) = 180/pi*a_lambda + polelon - 180;
        
        % Give longitude in 0..360 rather than -180..180
        if x_p(i,j) < 0
            x_p(i,j) = x_p(i,j) + 360;
        end
        
%         term1 = sin_phi_pole*cos_theta_pole*cos(E_x)*cos(E_y) ...
%                + cos_phi_pole*sin(E_x)*cos(E_y) ...
%                - sin_phi_pole*sin_theta_pole*sin(E_y);
%         term2 = cos_phi_pole*cos_theta_pole*cos(E_x)*cos(E_y) ...
%                - sin_phi_pole*sin(E_x)*cos(E_y) ...
%                - cos_phi_pole*sin_theta_pole*sin(E_y);
%         if abs(term2) < 1e-5
%             a_lambda = 0.0;
%         else
%             a_lambda = atan2(term1,term2);
%         end
%         x_p(i,j) = 180/pi*a_lambda;
        
    end
end