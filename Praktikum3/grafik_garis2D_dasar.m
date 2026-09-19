%% Grafik Garis 2D Dasar

x = 1:20:100;
y = x.^3 - 3*x.^2 + 10*x;
x, y
plot(x, y)
print('grafik_2d_dasar.png', '-dpng', '-r120')
