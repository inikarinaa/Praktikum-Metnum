% Perbandingan Metode: Eksak, Euler, Heun, Runge-Kutta Orde-4
% Soal : dy/dx = (4x^3 - 2x + 1) / (2 + y),  y(0) = 1
% Cari : y(2) dengan N = 15 langkah

clc; clear; close all;
1; % penanda file script

% f(x,y) = dy/dx
function hasil = f(x, y)
  hasil = (4*x^3 - 2*x + 1) / (2 + y);
end

% Solusi eksak
function hasil = solusi_eksak(x)
  hasil = -2 + sqrt(2*x^4 - 2*x^2 + 2*x + 9);
end

% Metode Euler: mengembalikan semua titik x dan y
function [x, y] = metode_euler(x0, y0, xt, N)
  h = (xt - x0) / N;
  x = zeros(1, N+1);  y = zeros(1, N+1);
  x(1) = x0;  y(1) = y0;
  for i = 1:N
    y(i+1) = y(i) + h * f(x(i), y(i));
    x(i+1) = x(i) + h;
  end
end

% Metode Heun (RK-2)
function [x, y] = metode_heun(x0, y0, xt, N)
  h = (xt - x0) / N;
  x = zeros(1, N+1);  y = zeros(1, N+1);
  x(1) = x0;  y(1) = y0;
  for i = 1:N
    k1 = f(x(i), y(i));
    k2 = f(x(i) + h, y(i) + k1*h);
    y(i+1) = y(i) + (h/2) * (k1 + k2);
    x(i+1) = x(i) + h;
  end
end

% Metode Runge-Kutta Orde-4
function [x, y] = metode_rk4(x0, y0, xt, N)
  h = (xt - x0) / N;
  x = zeros(1, N+1);  y = zeros(1, N+1);
  x(1) = x0;  y(1) = y0;
  for i = 1:N
    k1 = f(x(i), y(i));
    k2 = f(x(i) + h/2, y(i) + k1*h/2);
    k3 = f(x(i) + h/2, y(i) + k2*h/2);
    k4 = f(x(i) + h,   y(i) + k3*h);
    y(i+1) = y(i) + (h/6) * (k1 + 2*k2 + 2*k3 + k4);
    x(i+1) = x(i) + h;
  end
end

% Data soal
x_awal   = 0;
y_awal   = 1;
x_target = 2;
N        = 15;

% Jalankan ketiga metode
[x_e, y_e] = metode_euler(x_awal, y_awal, x_target, N);
[x_h, y_h] = metode_heun (x_awal, y_awal, x_target, N);
[x_r, y_r] = metode_rk4  (x_awal, y_awal, x_target, N);

% Ambil nilai akhir y(2) (elemen terakhir)
y_eksak = solusi_eksak(x_target);
y_euler = y_e(end);
y_heun  = y_h(end);
y_rk4   = y_r(end);

% Hitung galat
galat_abs_euler = abs(y_eksak - y_euler);
galat_abs_heun  = abs(y_eksak - y_heun);
galat_abs_rk4   = abs(y_eksak - y_rk4);

galat_rel_euler = galat_abs_euler / abs(y_eksak) * 100;
galat_rel_heun  = galat_abs_heun  / abs(y_eksak) * 100;
galat_rel_rk4   = galat_abs_rk4   / abs(y_eksak) * 100;

% Tabel perbandingan hasil akhir y(2)
printf("      Perbandingan Hasil y(2), N = %d\n\n", N);
printf("%-12s %-12s %-16s %-16s\n", "Metode", "y(2)", "Galat Absolut", "Galat Relatif (%)");
printf("---------------------------------------------------------------\n");
printf("%-12s %-12.6f %-16s %-16s\n", "Eksak",  y_eksak, "-", "-");
printf("%-12s %-12.6f %-16.8f %-16.6f\n", "Euler",  y_euler, galat_abs_euler, galat_rel_euler);
printf("%-12s %-12.6f %-16.8f %-16.6f\n", "Heun",   y_heun,  galat_abs_heun,  galat_rel_heun);
printf("%-12s %-12.6f %-16.8f %-16.6f\n", "RK-4",   y_rk4,   galat_abs_rk4,   galat_rel_rk4);

% Tabel perbandingan di setiap titik xi
printf("\n      Perbandingan di Setiap Titik\n\n");
printf("%-4s %-9s %-11s %-11s %-11s %-11s\n", "i", "xi", "Eksak", "Euler", "Heun", "RK-4");
printf("----------------------------------------------------------------\n");
for i = 1:N+1
  printf("%-4d %-9.4f %-11.6f %-11.6f %-11.6f %-11.6f\n", ...
         i-1, x_e(i), solusi_eksak(x_e(i)), y_e(i), y_h(i), y_r(i));
end

% Grafik perbandingan
xx = linspace(x_awal, x_target, 200); % titik halus untuk kurva eksak
yy = zeros(size(xx));
for i = 1:length(xx)
  yy(i) = solusi_eksak(xx(i));
end

figure;
plot(xx,  yy,  'k-',  'LineWidth', 2); hold on;
plot(x_e, y_e, 'r--o');
plot(x_h, y_h, 'b--s');
plot(x_r, y_r, 'g--^');
grid on;
xlabel('x');
ylabel('y');
title('Perbandingan Solusi Eksak, Euler, Heun, dan RK-4');
legend('Eksak', 'Euler', 'Heun (RK-2)', 'RK-4', 'Location', 'northwest');
hold off;

% Kesimpulan otomatis
printf("\nKesimpulan: galat terkecil = RK-4, lalu Heun, lalu Euler.\n");
