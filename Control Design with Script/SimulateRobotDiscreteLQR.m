clear all, close all, clc

InitializeParameters();

[Ac, Bc] = StateSpaceMatrices();
Cc = [1, 0, 1, 0];

% Sample time.
Ts = 1/100;

% Continuous state-space system.
sys_c = ss(Ac, Bc, Cc, 0);

% Discrete state-space system.
sys_d = c2d(sys_c, Ts, 'zoh');

% Discrete state-space matrices.
A = sys_d.a;
B = sys_d.b;
C = sys_d.c;
D = sys_d.d;

Q = [1, 0, 0, 0;
     0, 1, 0, 0;
     0, 0, 1, 0;
     0, 0, 0, 1];
R = 0.01;

[K, S, e] = dlqr(A, B, Q, R);

% Target state vector;
target = [0; 0; pi; 0];
initialStates = [0; 0; pi+0.5; 0];

% Small hack. We have the ode solver to solve at time step of Ts,
% which corresponds to the interval at which discrete 
% control input -K*(y-target) is applied to the system.
tspan = 0:Ts:10;
[t, y] = ode45(@(t, y) RobotODE(y, -K*(y-target)), tspan, initialStates);

for i = 1:length(t)
   drawRobot(y(i,:), m, M, L);
end