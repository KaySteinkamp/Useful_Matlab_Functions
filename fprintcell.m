function fprintcell(fid, cellarray)
[rows, cols] = size(cellarray);
for i_row = 1:rows
    file_line = '';
    for i_col = 1:cols
        contents = cellarray{i_row, i_col};
        if isnumeric(contents)
            contents = num2str(contents);
        elseif isempty(contents)
            contents = '';
        end
        if i_col < cols
            file_line = [file_line, contents, ','];
        else
            file_line = [file_line, contents];
        end
    end
    fprintf(fid, '%s\n', file_line);
end