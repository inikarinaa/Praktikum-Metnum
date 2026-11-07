% Metode Runge-Kutta Orde-4
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

% Iterasi RK4
% k1 = f(xi, yi)
% k2 = f(xi + h/2, yi + k1*h/2)
% k3 = f(xi + h/2, yi + k2*h/2)
% k4 = f(xi + h,   yi + k3*h)
% y(i+1) = yi + (h/6)*(k1 + 2*k2 + 2*k3 + k4)
x = x_awal;
y = y_awal;

printf("      Tabel Iterasi Metode Runge-Kutta Orde-4\n\n");
printf("%-4s %-9s %-10s %-9s %-9s %-9s %-9s %-10s\n", ...
       "i", "xi", "yi", "k1", "k2", "k3", "k4", "yi+1");
printf("--------------------------------------------------------------------------\n");

for i = 0:N-1
  k1     = f(x, y);
  k2     = f(x + h/2, y + k1*h/2);
  k3     = f(x + h/2, y + k2*h/2);
  k4     = f(x + h,   y + k3*h);
  y_next = y + (h/6) * (k1 + 2*k2 + 2*k3 + k4);
  printf("%-4d %-9.4f %-10.4f %-9.4f %-9.4f %-9.4f %-9.4f %-10.4f\n", ...
         i, x, y, k1, k2, k3, k4, y_next);
  x = x + h;
  y = y_next;
end

y_rk4 = y; % hasil akhir = pendekatan y(2)

% Perbandingan dengan solusi eksak
y_eksak       = solusi_eksak(x_target);
galat_absolut = abs(y_eksak - y_rk4);
galat_relatif = galat_absolut / abs(y_eksak) * 100;

printf("\n       Perbandingan Solusi Eksak\n");
printf("Solusi eksak y(2) = sqrt(37) - 2 = %.6f\n", y_eksak);
printf("Metode RK4 y(2)                  = %.6f\n", y_rk4);
printf("Galat absolut                    = %.8f\n", galat_absolut);
printf("Galat relatif                    = %.8f %%\n", galat_relatif);
