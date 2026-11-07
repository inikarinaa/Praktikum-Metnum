% Metode Heun(Runge-Kutta Orde-2)
% Soal : dy/dx = (4x^3 - 2x + 1) / (2 + y),  y(0) = 1
% Cari : y(2) dengan N = 15 langkah

clc; clear;
1; % penanda file script

% f(x,y) = dy/dx
function hasil = f(x, y)
  hasil = (4*x^3 - 2*x + 1) / (2 + y);
end

% Solusi eksak
function hasil = solusi_eksak(x)
  hasil = -2 + sqrt(2*x^4 - 2*x^2 + 2*x + 9);
end

% Data soal
x_awal   = 0;
y_awal   = 1;
x_target = 2;
N        = 15;
h        = (x_target - x_awal) / N;

% Iterasi Heun
% k1 = f(xi, yi)
% k2 = f(xi + h, yi + k1*h)
% y(i+1) = yi + (h/2)*(k1 + k2)
x = x_awal;
y = y_awal;

printf("      Tabel Iterasi Metode Heun (RK-2)\n\n");
printf("%-4s %-10s %-12s %-12s %-12s %-12s\n", "i", "xi", "yi", "k1", "k2", "yi+1");
printf("---------------------------------------------------------------\n");

for i = 0:N-1
  k1     = f(x, y);
  k2     = f(x + h, y + k1*h);
  y_next = y + (h/2) * (k1 + k2);
  printf("%-4d %-10.4f %-12.4f %-12.4f %-12.4f %-12.4f\n", i, x, y, k1, k2, y_next);
  x = x + h;
  y = y_next;
end

y_heun = y; % hasil akhir = pendekatan y(2)

% Perbandingan dengan solusi eksak
y_eksak       = solusi_eksak(x_target);
galat_absolut = abs(y_eksak - y_heun);
galat_relatif = galat_absolut / abs(y_eksak) * 100;

printf("\n       Perbandingan Solusi Eksak\n");
printf("Solusi eksak y(2) = sqrt(37) - 2 = %.6f\n", y_eksak);
printf("Metode Heun y(2)                 = %.6f\n", y_heun);
printf("Galat absolut                    = %.6f\n", galat_absolut);
printf("Galat relatif                    = %.6f %%\n", galat_relatif);
