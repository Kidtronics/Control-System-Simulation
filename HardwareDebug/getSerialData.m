function [key,value] = getSerialData(connection)

    data = fgetl(connection);
    data = data(1:end-1);
    if contains(data, ':')
        splitData = strsplit(data, ':');
        key = string(splitData(1));
        value = str2double(string(splitData(2)));
    else
        key = ' ';
        value = 0;
    end
end

