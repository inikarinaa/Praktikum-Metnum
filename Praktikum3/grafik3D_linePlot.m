%% Grafik 3D Line Plot
t = 0:0.1:5*pi;
x = sqrt(t) .* cos(3*t);
y = sqrt(t) .* sin(3*t);
z = 0.7*t;
plot3(x, y, z, 'b', 'linewidth', 1.2);
grid on
xlabel('x'); ylabel('y'); zlabel('z');
print('grafik_3d_lineplot.png', '-dpng', '-r120')
