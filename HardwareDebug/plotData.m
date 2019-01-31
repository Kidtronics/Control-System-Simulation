function plotData(time, dataMap, sampleWindowSize)
    datacursormode on
    
    mapSize = size(dataMap, 1);
    index = 1;
    timeSlice = time(1:sampleWindowSize);
    
    if isKey(dataMap, 'Pitch')
        subplot(mapSize, 1, index);
        index = index + 1;
        pitch = dataMap('Pitch');
        plot(timeSlice, pitch(1:sampleWindowSize));
        title('Pitch vs Time')
        xlabel('Time (sec)');
        ylabel('Pitch (deg)')
    end
    
    if isKey(dataMap, 'PitchS')
        subplot(mapSize, 1, index);
        index = index + 1;
        pitchS = dataMap('PitchS');
        plot(timeSlice, pitchS(1:sampleWindowSize));
        title('Pitch Setpoint vs Time')
        xlabel('Time (sec)');
        ylabel('Pitch Setpoint (deg)')
    end
    
    if isKey(dataMap, 'PWM')
        subplot(mapSize, 1, index);
        index = index + 1;
        pwm = dataMap('PWM');
        plot(timeSlice, pwm(1:sampleWindowSize));
        title('PWM vs Time');
        xlabel('Time (sec)');
        ylabel('PWM (1/1023)')
    end
    
    if isKey(dataMap, 'AngVel')
        subplot(mapSize, 1, index);
        index = index + 1;
        angVel = dataMap('AngVel');
        plot(timeSlice, angVel(1:sampleWindowSize));
        title('Angular Velocity vs Time');
        xlabel('Time (sec)');
        ylabel('Angular Velocity (deg/s)');
    end
    
    if isKey(dataMap, 'AngVelS')
        subplot(mapSize, 1, index);
        index = index + 1;
        angVelSetpoint = dataMap('AngVelS');
        plot(timeSlice, angVelSetpoint(1:sampleWindowSize));
        title('Angular Velocity Setpoint vs Time');
        xlabel('Time (sec)');
        ylabel('Angular Velocity Setpoint (deg/s)');
    end
    
    if isKey(dataMap, 'MSpeedS')
        subplot(mapSize, 1, index);
        index = index + 1;
        motorSpeedSetpoint = dataMap('MSpeedS');
        plot(timeSlice, motorSpeedSetpoint(1:sampleWindowSize));
        title('Motor Speed Setpoint vs Time');
        xlabel('Time (sec)');
        ylabel('Motor Speed Setpoint (deg/s)');
    end
    
    if isKey(dataMap, 'MSpeed')
        subplot(mapSize, 1, index);
        index = index + 1;
        motorSpeed = dataMap('MSpeed');
        plot(timeSlice, motorSpeed(1:sampleWindowSize));
        title('Motor Speed vs Time');
        xlabel('Time (sec)');
        ylabel('Motor Speed (deg/s)');
    end
end

