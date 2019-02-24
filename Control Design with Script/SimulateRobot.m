clear all, close all, clc

InitializeParameters();

tspan = 0:0.1:10;
initialStates = [0; 0.1; pi; 0];
[t, y] = ode45(@(t, y) RobotODE(y, 0), tspan, initialStates);

for i = 1:length(t)
   drawRobot(y(i,:), m, M, L);
end