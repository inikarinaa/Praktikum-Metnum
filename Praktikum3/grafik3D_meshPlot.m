%% Grafik 3D Mesh Plot
x = -5:0.25:5;
y = x;
[X, Y] = meshgrid(x, y);
R = sqrt(X.^2 + Y.^2);
Z = sin(R) ./ (R + eps);
mesh(X, Y, Z);
xlabel('x'); ylabel('y'); zlabel('z');
print('grafik_3d_mesh.png', '-dpng', '-r120')
