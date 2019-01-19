function plotData(time, pitch, pwm, angVel, angVelSetpoint, sampleWindowSize)
    datacursormode on
    
    if length(time) == length(pitch)
        subplot(4, 1, 1);
        plot(time(1:sampleWindowSize), pitch(1:sampleWindowSize));
        title('Pitch vs Time')
        xlabel('Time (sec)');
        ylabel('Pitch (deg)')
    end
    
    if length(time) == length(pwm)
        subplot(4, 1, 2);
        plot(time(1:sampleWindowSize), pwm(1:sampleWindowSize));
        title('PWM vs Time');
        xlabel('Time (sec)');
        ylabel('PWM (1/1023)')
    end
    
    if length(time) == length(angVel)
        subplot(4, 1, 3);
        plot(time(1:sampleWindowSize), angVel(1:sampleWindowSize));
        title('Angular Velocity vs Time');
        xlabel('Time (sec)');
        ylabel('Angular Velocity (deg/s)');
    end
    
    if length(time) == length(angVelSetpoint)
        subplot(4, 1, 4);
        plot(time(1:sampleWindowSize), angVelSetpoint(1:sampleWindowSize));
        title('Angular Velocity Setpoint vs Time');
        xlabel('Time (sec)');
        ylabel('Angular Velocity Setpoint (deg/s)');
    end
end

