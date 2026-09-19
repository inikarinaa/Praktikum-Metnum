% =====================================================
% Memahami cara kerja meshgrid()
% =====================================================

clc; clear; close all;

x = [2, 4, 6];
y = [20, 30];

[X, Y] = meshgrid(x, y);

disp('Matriks X:'); disp(X)
disp('Matriks Y:'); disp(Y)

% Visualisasikan semua titik grid sebagai scatter plot
figure;
plot(X, Y, 'o', 'MarkerFaceColor', 'b');
xlabel('Sumbu X'); ylabel('Sumbu Y');
title('Visualisasi titik-titik dari [X,Y] = meshgrid(x,y)');
grid on
