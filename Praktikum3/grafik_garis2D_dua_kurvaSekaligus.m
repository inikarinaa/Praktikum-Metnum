%% Grafik Garis 2D Dua Kurva Sekaligus

x = 0:0.01:2*pi;
y = 12*sin(3*x) + 5*cos(2*x);
z = -6*sin(8*x) .* 4 .* cos(5*x);
plot(x, y, x, z);
print('grafik_2d_duakurva.png', '-dpng', '-r120')
