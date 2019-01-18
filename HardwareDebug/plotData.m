function plotData(time, pitch, pwm, sampleWindowSize)
    subplot(2, 1, 1);
    plot(time(1:sampleWindowSize), pitch(1:sampleWindowSize));
    title('Pitch vs Time')
    xlabel('Time (sec)');
    ylabel('Pitch (deg)')
    
    subplot(2, 1, 2);
    plot(time(1:sampleWindowSize), pwm(1:sampleWindowSize));
    title('PWM vs Time');
    xlabel('Time (sec)');
    ylabel('PWM (1/1023)')
end

