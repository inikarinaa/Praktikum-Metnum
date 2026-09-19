% =====================================================
% Grafik Garis 3D - CONTOUR PLOT
% =====================================================

clc; clear; close all;

x = -6.0:0.1:6.0;
y = -6.0:0.1:6.0;
[X, Y] = meshgrid(x, y);
Z = 1.8.^(-1.5*sqrt(X.^2 + Y.^2)) .* cos(0.5*Y) .* sin(X);

contour3(X, Y, Z, 15)
xlabel('x');
ylabel('y');
zlabel('z');
title('Contour plot 3D')
grid on
