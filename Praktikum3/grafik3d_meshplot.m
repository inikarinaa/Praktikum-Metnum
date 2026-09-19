% =====================================================
% Grafik Garis 3D - MESH PLOT
% =====================================================

clc; clear; close all;

x = -8.5:0.1:8.5;
y = x;
[X, Y] = meshgrid(x, y);
R = sqrt(X.^2 + Y.^2);
Z = sin(R) ./ R;

mesh(X, Y, Z);
xlabel('x'); ylabel('y'); zlabel('z');
title('Mesh plot f(x,y) = sin(R)/R')
