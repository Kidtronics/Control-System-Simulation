listDevices = seriallist;
port = listDevices(end);
conn = serial(port, 'BaudRate', 115200, 'Terminator', 'LF');
conn.InputBufferSize = 128;
fopen(conn);

% Constant. Max number of samples will be plotted on the screen.
maxSampleSize = 2000;

% Constant. Number of new samples 
% that are added each time the plot is refreshed.
numNewSamplesEachPlot = 100;

% Number of samples read from serial during last plot refresh.
lastPlottedSampleSize = 0;

% Preallocate to optimize efficiency.
time = zeros(1, maxSampleSize);

Keys = {'Pitch', 'PitchS', 'PWM', 'AngVel', 'AngVelS', 'MSpeed', 'MSpeedS'};
keyMap = containers.Map(Keys, Keys);

% Map that map names to values.
dataMap = containers.Map;

% This is the current size of time, pitch and pwm array.
sampleWindowSize = 0;

[key, value] = getSerialData(conn);

for numSamplesRecieved = 1:10000
    % Wait until a timestamp comes in,
    % then start reading data.
    while key ~= 'Time'
        [key, value] = getSerialData(conn);
    end
    
    time = addToArray(time, sampleWindowSize, maxSampleSize, value/1000);
    
    [key, value] = getSerialData(conn);
    while key ~= 'Time'
        keyChar = char(key);
        % If key exists in the plot key map, then store
        % this value into dataMap.
        if keyChar == keyMap(keyChar)
            if ~isKey(dataMap, keyChar)
                dataMap(keyChar) = zeros(1, maxSampleSize);
            end
            dataMap(keyChar) = ...
                addToArray(dataMap(keyChar), sampleWindowSize, maxSampleSize, value);
        end
        
        [key, value] = getSerialData(conn);
    end
    
    sampleWindowSize = min(sampleWindowSize + 1, maxSampleSize);
    
    if numSamplesRecieved - lastPlottedSampleSize >= numNewSamplesEachPlot
        lastPlottedSampleSize = numSamplesRecieved;
        plotData(time, dataMap, sampleWindowSize);
        drawnow
    end
end

fclose(conn);
