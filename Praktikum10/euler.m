% Metode Euler
% Soal : dy/dx = (4x^3 - 2x + 1) / (2 + y),  y(0) = 1
% Cari : y(2) dengan N = 15 langkah

clc; clear;
1; % penanda bahwa file ini script (bukan function), supaya boleh ada function di dalamnya

% f(x,y) = dy/dx
function hasil = f(x, y)
  hasil = (4*x^3 - 2*x + 1) / (2 + y);
end

% Solusi eksak (hasil integrasi, lihat catatan di bawah)
function hasil = solusi_eksak(x)
  hasil = -2 + sqrt(2*x^4 - 2*x^2 + 2*x + 9);
end

% Data soal
x_awal   = 0; % a
y_awal   = 1; % y(a)
x_target = 2; % b
N        = 15; % jumlah langkah
h        = (x_target - x_awal) / N; % ukuran langkah

% Iterasi Euler: y(i+1) = y(i) + h * f(xi, yi)
x = x_awal;
y = y_awal;

printf("      Tabel Iterasi Metode Euler\n\n");
printf("%-4s %-10s %-12s %-12s %-12s\n", "i", "xi", "yi", "f(xi,yi)", "yi+1");
printf("-------------------------------------------------------\n");

for i = 0:N-1
  fi     = f(x, y); % kemiringan di titik (xi, yi)
  y_next = y + h * fi; % rumus Euler
  printf("%-4d %-10.4f %-12.4f %-12.4f %-12.4f\n", i, x, y, fi, y_next);
  x = x + h; % maju satu langkah
  y = y_next;
end

y_euler = y; % hasil akhir = pendekatan y(2)

% Perbandingan dengan solusi eksak
y_eksak       = solusi_eksak(x_target);
galat_absolut = abs(y_eksak - y_euler);
galat_relatif = galat_absolut / abs(y_eksak) * 100;

printf("\n       Perbandingan Solusi Eksak\n");
printf("Solusi eksak y(2) = sqrt(37) - 2 = %.6f\n", y_eksak);
printf("Metode Euler y(2)                = %.6f\n", y_euler);
printf("Galat absolut                    = %.6f\n", galat_absolut);
printf("Galat relatif                    = %.4f %%\n", galat_relatif);
