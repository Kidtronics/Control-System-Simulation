function y = cutoff(u)
cutoff_angle = 0.5*pi;
if u(1) > -cutoff_angle && u(1) < cutoff_angle
    y = u(2);
else
    y = 0;
end

