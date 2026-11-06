% Soal    : f(x) = cos(x) - x = 0, toleransi < 0.0001
% Metode  : Fixed-Point Iteration dan Newton-Raphson
1;  % penanda berkas skrip (agar fungsi boleh didefinisikan di bawah)

% FIXED-POINT ITERATION
function [akar, tabel] = fixed_point(g, dg, x0, tol, maksiter)
  % Syarat konvergen: |g'(x0)| < 1
  if abs(dg(x0)) >= 1
    error("Syarat |g'(x0)| < 1 tidak terpenuhi. Iterasi dihentikan.");
  endif
  tabel = [];
  x = x0;
  for i = 1:maksiter
    xb = g(x); % x_(i+1) = g(x_i)
    galat = abs(xb - x);
    tabel = [tabel; i, x, xb, galat];
    x = xb;
    if galat < tol
      break;
    endif
  endfor
  akar = x;
endfunction

% NEWTON-RAPHSON
function [akar, tabel] = newton_raphson(f, df, x0, tol, maksiter)
  % Syarat: f'(x0) tidak boleh nol
  if df(x0) == 0
    error("Syarat f'(x0) != 0 tidak terpenuhi. Iterasi dihentikan.");
  endif
  tabel = [];
  x = x0;
  for i = 1:maksiter
    if df(x) == 0
      error("Turunan bernilai nol pada iterasi ke-%d.", i);
    endif
    xb = x - f(x) / df(x);     % x_(i+1) = x_i - f(x_i)/f'(x_i)
    galat = abs(xb - x);
    tabel = [tabel; i, x, f(x), df(x), xb, galat];
    x = xb;
    if galat < tol
      break;
    endif
  endfor
  akar = x;
endfunction

% PROGRAM UTAMA
clc; clear;

f   = @(x) cos(x) - x; % f(x)
df  = @(x) -sin(x) - 1; % f'(x)
g   = @(x) cos(x); % g(x) untuk Fixed-Point
dg  = @(x) -sin(x); % g'(x)
tol = 0.0001;
maksiter = 100;

x0 = 0.5; % tebakan awal (0 < x0 < 1.4)

% FIXED-POINT
printf("\n=== FIXED-POINT ITERATION (x0 = %.1f) ===\n", x0);
printf("|g'(x0)| = %.6f (< 1, syarat konvergen terpenuhi)\n", abs(dg(x0)));
[akar_fp, T1] = fixed_point(g, dg, x0, tol, maksiter);
printf("%3s %10s %18s %12s\n", "i", "x_i", "x_(i+1)=cos(x_i)", "Galat");
for r = 1:rows(T1)
  printf("%3d %10.6f %18.6f %12.6f\n", T1(r,1), T1(r,2), T1(r,3), T1(r,4));
endfor
printf("Akar = %.6f (%d iterasi)\n", akar_fp, rows(T1));

% NEWTON-RAPHSON
printf("\n=== NEWTON-RAPHSON (x0 = %.1f) ===\n", x0);
printf("f'(x0) = %.6f (tidak nol, syarat terpenuhi)\n", df(x0));
[akar_nr, T2] = newton_raphson(f, df, x0, tol, maksiter);
printf("%3s %10s %12s %12s %12s %12s\n", "i", "x_i", "f(x_i)", "f'(x_i)", "x_(i+1)", "Galat");
for r = 1:rows(T2)
  printf("%3d %10.6f %12.6f %12.6f %12.6f %12.6f\n", T2(r,1), T2(r,2), T2(r,3), T2(r,4), T2(r,5), T2(r,6));
endfor
printf("Akar = %.6f (%d iterasi)\n", akar_nr, rows(T2));

% PERBANDINGAN
printf("\n=== PERBANDINGAN ===\n");
printf("%-16s %10s %12s %14s\n", "Metode", "Iterasi", "Akar", "|f(akar)|");
printf("%-16s %10d %12.6f %14.2e\n", "Fixed-Point",    rows(T1), akar_fp, abs(f(akar_fp)));
printf("%-16s %10d %12.6f %14.2e\n", "Newton-Raphson", rows(T2), akar_nr, abs(f(akar_nr)));
