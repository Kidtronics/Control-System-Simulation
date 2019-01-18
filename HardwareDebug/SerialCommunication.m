port = '/dev/cu.usbmodem14201';
conn = serial(port, 'BaudRate', 115200, 'Terminator', 'LF');
conn.InputBufferSize = 128;
fopen(conn);

maxSampleSize = 3000;

% These arrays are preallocated for performance improvement.
time = zeros(1, maxSampleSize);
pitch = zeros(1, maxSampleSize);
pwm = zeros(1, maxSampleSize);

% This is the size of time, pitch and pwm array.
sampleWindowSize = 0;

[key, value] = getSerialData(conn);

for i = 1:10000
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
        end
        [key, value] = getSerialData(conn);
    end
    sampleWindowSize = sampleWindowSize + 1;
    
    plotData(time, pitch, pwm, sampleWindowSize);
    drawnow
end