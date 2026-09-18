%% Grafik 3D Contour Plot
x = -4:0.2:4;
y = -4:0.2:4;
[X, Y] = meshgrid(x, y);
Z = 1.5.^(-1.2*sqrt(X.^2+Y.^2)) .* sin(0.6*X) .* cos(0.6*Y);
contour3(X, Y, Z, 15);
xlabel('x'); ylabel('y'); zlabel('z');
print('grafik_3d_contour.png', '-dpng', '-r120')
