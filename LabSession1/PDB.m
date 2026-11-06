% Soal    : dy/dx = x*sqrt(y), y(0) = 1 (asumsi), h = 0.1, cari y(1.2)
% Metode  : Euler, Heun (Runge-Kutta orde-2), Runge-Kutta orde-4
% Eksak   : y(x) = (x^2/4 + 1)^2
1;  % penanda berkas skrip (agar fungsi boleh didefinisikan di bawah)

% METODE EULER
function [x, y] = euler(f, x0, y0, h, n)
  x = zeros(1, n+1);
  y = zeros(1, n+1);
  x(1) = x0;
  y(1) = y0;
  for i = 1:n
    y(i+1) = y(i) + h * f(x(i), y(i));
    x(i+1) = x0 + i * h;
  endfor
endfunction

%  METODE HEUN (RK ORDE-2)
function [x, y, K1, K2] = heun(f, x0, y0, h, n)
  x = zeros(1, n+1);
  y = zeros(1, n+1);
  K1 = zeros(1, n);
  K2 = zeros(1, n);
  x(1) = x0;
  y(1) = y0;
  for i = 1:n
    k1 = f(x(i), y(i));
    k2 = f(x(i) + h, y(i) + h * k1);
    K1(i) = k1;
    K2(i) = k2;
    y(i+1) = y(i) + (h / 2) * (k1 + k2);
    x(i+1) = x0 + i * h;
  endfor
endfunction

% METODE RK4
function [x, y, K] = rk4(f, x0, y0, h, n)
  x = zeros(1, n+1);
  y = zeros(1, n+1);
  K = zeros(n, 4); % kolom 1..4 berisi k1..k4 tiap langkah
  x(1) = x0;
  y(1) = y0;
  for i = 1:n
    k1 = f(x(i), y(i));
    k2 = f(x(i) + 0.5*h, y(i) + 0.5*h * k1);
    k3 = f(x(i) + 0.5*h, y(i) + 0.5*h * k2);
    k4 = f(x(i) + h,     y(i) + h * k3);
    K(i, :) = [k1 k2 k3 k4];
    y(i+1) = y(i) + (h / 6) * (k1 + 2*k2 + 2*k3 + k4);
    x(i+1) = x0 + i * h;
  endfor
endfunction

% PROGRAM UTAMA
clc; clear;

f     = @(x, y) x .* sqrt(y); % f(x, y) = dy/dx
eksak = @(x) (x.^2 / 4 + 1).^2; % solusi eksak
x0 = 0;  y0 = 1; % nilai awal (asumsi)
h  = 0.1; % ukuran langkah (step size)
xt = 1.2; % titik yang dicari
tol = 0.0001; % toleransi galat
n  = round((xt - x0) / h); % jumlah langkah = 12

[xe, ye]          = euler(f, x0, y0, h, n);
[xh, yh, H1, H2]  = heun(f, x0, y0, h, n);
[xr, yr, K]       = rk4(f, x0, y0, h, n);

% TABEL EULER
printf("\n=== METODE EULER ===\n");
printf("%3s %6s %10s %12s %12s\n", "i", "x_i", "y_i", "f(x_i,y_i)", "y_(i+1)");
for i = 1:n
  printf("%3d %6.1f %10.6f %12.6f %12.6f\n", i-1, xe(i), ye(i), f(xe(i), ye(i)), ye(i+1));
endfor

% TABEL HEUN
printf("\n=== METODE HEUN (RK ORDE-2) ===\n");
printf("%3s %6s %10s %10s %10s %12s\n", "i", "x_i", "y_i", "k1", "k2", "y_(i+1)");
for i = 1:n
  printf("%3d %6.1f %10.6f %10.6f %10.6f %12.6f\n", i-1, xh(i), yh(i), H1(i), H2(i), yh(i+1));
endfor

% TABEL RK4
printf("\n=== METODE RUNGE-KUTTA ORDE-4 ===\n");
printf("%3s %6s %10s %10s %10s %10s %10s %12s\n", "i", "x_i", "y_i", "k1", "k2", "k3", "k4", "y_(i+1)");
for i = 1:n
  printf("%3d %6.1f %10.6f %10.6f %10.6f %10.6f %10.6f %12.6f\n", ...
         i-1, xr(i), yr(i), K(i,1), K(i,2), K(i,3), K(i,4), yr(i+1));
endfor

% PERBANDINGAN
ye_ak = eksak(xt); % nilai eksak y(1.2)
hasil = [ye(end), yh(end), yr(end)];
nama  = {"Euler", "Heun (RK2)", "RK4"};

printf("\n=== PERBANDINGAN DI x = %.1f ===\n", xt);
printf("Nilai eksak y(%.1f) = %.6f\n\n", xt, ye_ak);
printf("%-12s %10s %14s %14s %12s\n", "Metode", "y(1.2)", "Galat absolut", "Galat relatif", "Galat<eps?");
for j = 1:3
  gal_abs = abs(ye_ak - hasil(j));
  gal_rel = gal_abs / abs(ye_ak) * 100;
  if gal_abs < tol
    status = "Ya";
  else
    status = "Tidak";
  endif
  printf("%-12s %10.6f %14.6f %13.4f%% %12s\n", nama{j}, hasil(j), gal_abs, gal_rel, status);
endfor
