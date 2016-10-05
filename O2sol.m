function [sol,dO2dT]=O2sol(rho_sea,rho_O2,sss,sst)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This script calculates the O2 solubility in seawater (after Weiss 
% et al., 1970), depending on SSS and SST.
% 
% As results both the O2 solubility (in ml/L/K) and the related change
% in oxygen saturation w.r.t. temperature (in umol/kg/K) are provided.
%
% NOTE: Give rho_sea in (kg L-1), rho_O2 in (kg l-1), sss in (g/kg), 
%       and sst in (degC)
% 
% Author: Kay
% Date: May 2008
%
% Version        Remarks
% 1.0            rho_sea and rho_O2 are considered as constants.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% molar mass of (diatomic) oxygen (O2) in (kg/mol)
m_O2 = 2*16e-3;	

% Parameters for solubility parametrization after Weiss, 1970
A1 = -173.4292;
A2 = 249.6339;
A3 = 143.3483;
A4 = -21.8492;
B1 = -0.033096;
B2 = 0.014259;
B3 = -0.001700;

% Calculate temperature and salinity dependent O2 solubility
% T = temperature in kelvins/100kelvins
% S = salinity in g/kg, i.e. per mille.
% O2_sat = dissolved oxygen in ml O2 per L seawater.
T=(sst+273.15)./100.; % Change units from degC to K/100K
S=sss;
exponent=A1+ A2./T + A3.*log(T) + A4.*T + S.*(B1 + B2.*T + B3.*T.*T);
O2_sat=exp(exponent);
deriv_factor=-A2./(T.*T) + A3./T + A4 + S.*(B2 + 2*B3.*T);
% O2 solubility in ml/L/K
sol=O2_sat.*deriv_factor./100; 
% NOTE: Factor 100 due to variable transformation from T back to sst
% O2 solubility in umol/kg/K
dO2dT=rho_O2/(rho_sea*m_O2)*1000.*sol;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%