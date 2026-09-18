%% Grafik Garis 2D dengan Linspace + Label
x = linspace(0, 15, 100);
y = exp(-x/6) .* cos(x);
plot(x, y);
xlabel('Sumbu X');
ylabel('Sumbu Y');
title('Grafik persamaan f(x) = exp(-x/6).*cos(x)');
print('grafik_2d_linspace.png', '-dpng', '-r120')
