listDevices = seriallist;
port = listDevices(end);
conn = serial(port, 'BaudRate', 115200, 'Terminator', 'LF');
conn.InputBufferSize = 128;
fopen(conn);

% Constant. Max number of samples will be plotted on the screen.
maxSampleSize = 3000;

% Constant. Number of new samples 
% that are added each time the plot is refreshed.
numNewSamplesEachPlot = 200;

% Number of samples read from serial during last plot refresh.
lastPlottedSampleSize = 0;

% These arrays are preallocated for performance improvement.
time = zeros(1, maxSampleSize);
pitch = zeros(1, maxSampleSize);
pwm = zeros(1, maxSampleSize);
angVel = zeros(1, maxSampleSize);
angVelSetpoint = zeros(1, maxSampleSize);

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
        
        if key == 'Pitch'
            pitch = ...
                addToArray(pitch, sampleWindowSize, maxSampleSize, value);
        elseif key == 'PWM'
            pwm = ...
                addToArray(pwm, sampleWindowSize, maxSampleSize, value);
        elseif key == 'AngVel'
            angVel = ...
                addToArray(angVel, sampleWindowSize, maxSampleSize, value);
        elseif key == 'AngVelS'
            angVelSetpoint = ...
                addToArray(angVelSetpoint, sampleWindowSize, maxSampleSize, value);
        end
        [key, value] = getSerialData(conn);
    end
    
    sampleWindowSize = min(sampleWindowSize + 1, maxSampleSize);
    
    if numSamplesRecieved - lastPlottedSampleSize >= numNewSamplesEachPlot
        lastPlottedSampleSize = numSamplesRecieved;
        plotData(time, pitch, pwm, angVel, angVelSetpoint, sampleWindowSize);
        drawnow
    end
end