% Penyelesaian Eksak (Analitik)
% Soal : dy/dx = (4x^3 - 2x + 1) / (2 + y),  y(0) = 1
% Cari : y(2)

clc; clear;
1; % penanda file script

% LANGKAH PENYELESAIAN (pemisahan variabel)
% 1) Pisahkan variabel:
%      (2 + y) dy = (4x^3 - 2x + 1) dx
% 2) Integralkan kedua ruas:
%      2y + y^2/2 = x^4 - x^2 + x + C
% 3) Masukkan nilai awal y(0) = 1:
%      2(1) + 1^2/2 = 0 - 0 + 0 + C   ->   C = 5/2
% 4) Kalikan 2 lalu tambah 4 agar membentuk kuadrat sempurna:
%      y^2 + 4y + 4 = 2x^4 - 2x^2 + 2x + 5 + 4
%      (y + 2)^2    = 2x^4 - 2x^2 + 2x + 9
% 5) Ambil akar positif (karena y(0)=1 -> y+2 = 3 > 0):
%      y(x) = -2 + sqrt(2x^4 - 2x^2 + 2x + 9)
%
% 6) Untuk x = 2:
%      y(2) = -2 + sqrt(2(16) - 2(4) + 2(2) + 9)
%           = -2 + sqrt(37)

% Fungsi solusi eksak
function hasil = solusi_eksak(x)
  hasil = -2 + sqrt(2*x^4 - 2*x^2 + 2*x + 9);
end

% Data soal
x_awal   = 0;
x_target = 2;

% Cek nilai awal (harus 1)
printf("Cek nilai awal : y(0) = %.4f (harus 1)\n\n", solusi_eksak(x_awal));

% Hasil utama
y_eksak = solusi_eksak(x_target);
printf("Solusi eksak y(2) = sqrt(37) - 2 = %.6f\n\n", y_eksak);

% Tabel nilai eksak di tiap titik (h sama dengan metode numerik, N = 15)
N = 15;
h = (x_target - x_awal) / N;

printf("      Tabel Nilai Eksak\n\n");
printf("%-4s %-10s %-12s\n", "i", "xi", "y eksak");
printf("-------------------------------\n");
for i = 0:N
  xi = x_awal + i*h;
  printf("%-4d %-10.4f %-12.6f\n", i, xi, solusi_eksak(xi));
end
