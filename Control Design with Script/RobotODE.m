function dydt = RobotODE(y, F)
%     y represents a vector of four states of the system.
%     F is the external force applied to the system.
    global m M L g b I

    x_dot = y(2);
    theta = y(3);
    theta_dot = y(4);
    Cos = cos(theta);
    Sin = sin(theta);
    
    D = m^2*L^2*(Cos^2-1) - (M+m)*I - M*m*L^2;
    
    dydt = zeros(4, 1);
    
    dydt(1) = x_dot;
    dydt(3) = theta_dot;
    dydt(4) = 1/D*(m*g*L*(M+m)*Sin - m*L*Cos*b*x_dot ...
        + m^2*L^2*theta_dot^2*Sin*Cos + m*L*Cos*F);
    dydt(2) = -(I+m*L^2)/(m*L*Cos)*dydt(4) - g*Sin/Cos;
end

