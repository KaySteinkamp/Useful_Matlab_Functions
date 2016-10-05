function [data_out, varargout] = getnc_var(file_name, var_name)

ncid = netcdf.open(file_name,'NC_NOWRITE');
varID = netcdf.inqVarID(ncid,var_name);
data_out = squeeze(netcdf.getVar(ncid,varID));
if nargout > 1
    try
        varargout{1} = netcdf.getAtt(ncid,varID,'_FillValue');
    catch
        varargout{1} = netcdf.getAtt(ncid,varID,'missing_value');
    end
end
netcdf.close(ncid)

return;

