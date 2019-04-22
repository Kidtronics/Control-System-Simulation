clear all, close all, clc

InitializeParameters();

[A, B] = StateSpaceMatrices();

Q = [1, 0, 0, 0;
     0, 1, 0, 0;
     0, 0, 1, 0;
     0, 0, 0, 1];
R = 0.01;

[K, S, e] = lqr(A, B, Q, R);

% Target state vector;
target = [0; 0; pi; 0];
initialStates = [0; 0; pi+0.5; 0];

tspan = 0:0.01:10;
[t, y] = ode45(@(t, y) RobotODE(y, -K*(y-target)), tspan, initialStates);

for i = 1:length(t)
   drawRobot(y(i,:), m, M, L);
end