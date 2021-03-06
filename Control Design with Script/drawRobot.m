function drawRobot(y,m,M,L)
x = y(1);
th = y(3);

% dimensions
% L = 2;  % pendulum length
WD = 0.5; % Robot Wheel diameter.
wr = .2; % wheel radius
mr = .3*sqrt(m); % mass radius

% positions
y = WD/2; % cart vertical position

px = x + L*sin(th);
py = y - L*cos(th);

plot([-10 10],[0 0],'k','LineWidth',2)
hold on
rectangle('Position', [x-WD/2,y-WD/2,WD,WD], 'Curvature', 1, 'FaceColor',[1 0.1 0.1]);

plot([x px],[y py],'k','LineWidth',25)

% set(gca,'YTick',[])
% set(gca,'XTick',[])
xlim([-5 5]);
ylim([-2 2.5]);
set(gcf,'Position',[100 550 1000 400])
% box off
drawnow
hold off