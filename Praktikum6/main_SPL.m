% PROGRAM PERBANDINGAN 5 METODE (Soal 1, 2, 3)
%    5p -  q -  r           = -1
%   -p + 5q -  r -  s       =  2
%   -p -  q + 4r -  s - t   =  6
%         r + 4s - 2t       =  2
%        q -  r +  s + 4t   = -1
% File ini hanya untuk membandingkan hasil. Langkah rinci tiap metode ada di
% EliminasiGauss.m, EliminasiGaussJordan.m, DekomposisiLU.m,
% IterasiJacobi.m, IterasiGaussSeidel.m (masing-masing bisa di-Run sendiri).
clc; clear;

A = [ 5 -1 -1  0  0;
     -1  5 -1 -1  0;
     -1 -1  4 -1 -1;
      0  0  1  4 -2;
      0  1 -1  1  4];
b = [-1; 2; 6; 2; -1];
tol = 0.001;
max_iter = 20;
nama = {'p','q','r','s','t'};

% verbose = false supaya langkah rinci tidak tercetak di sini
x1 = EliminasiGauss(A, b, false);
x2 = EliminasiGaussJordan(A, b, false);
x3 = DekomposisiLU(A, b, false);
[x4, it4, k4] = IterasiJacobi(A, b, tol, max_iter, false);
[x5, it5, k5] = IterasiGaussSeidel(A, b, tol, max_iter, false);

% SOAL 1: himpunan penyelesaian
fprintf('========== SOAL 1: SOLUSI ==========\n');
fprintf('Var     Gauss   Gauss-Jordan        LU      Jacobi  Gauss-Seidel\n');
for i = 1 : length(b)
    fprintf('%-4s %10.6f %10.6f %12.6f %10.6f %10.6f\n', nama{i}, x1(i), x2(i), x3(i), x4(i), x5(i));
end
if k4
    fprintf('\nJacobi konverge pada iterasi ke-%d\n', it4);
else
    fprintf('\nJacobi not konverge (maks %d iterasi)\n', max_iter);
end
if k5
    fprintf('Gauss-Seidel konverge pada iterasi ke-%d\n', it5);
else
    fprintf('Gauss-Seidel not konverge (maks %d iterasi)\n', max_iter);
end
fprintf('\nResidu ||Ax - b||:\n');
fprintf('   Gauss        = %g\n', norm(A*x1 - b));
fprintf('   Gauss-Jordan = %g\n', norm(A*x2 - b));
fprintf('   LU           = %g\n', norm(A*x3 - b));
fprintf('   Jacobi       = %g\n', norm(A*x4 - b));
fprintf('   Gauss-Seidel = %g\n', norm(A*x5 - b));
if max(abs(x1 - x2)) < 1e-10 && max(abs(x1 - x3)) < 1e-10
    fprintf('KESIMPULAN: Gauss, Gauss-Jordan, dan LU menghasilkan solusi yang sama.\n');
else
    fprintf('PERHATIAN: hasil metode langsung berbeda, periksa kembali.\n');
end

% SOAL 2: galat = abs(nilai eksak - nilai hampiran)
xe = x1; % nilai eksak dari metode analitik (Gauss)
g4 = abs(xe - x4);
g5 = abs(xe - x5);
fprintf('\n========== SOAL 2: GALAT (eksak = hasil Gauss) ==========\n');
fprintf('Var   Galat Jacobi   Galat Gauss-Seidel\n');
for i = 1 : length(b)
    fprintf('%-4s %13.6e %17.6e\n', nama{i}, g4(i), g5(i));
end
fprintf('Maks %13.6e %17.6e\n', max(g4), max(g5));

% SOAL 3: running time (hanya algoritma, tanpa cetak)
N = 1000;
tic; EliminasiGauss(A, b, false);                         t1 = toc;
tic; EliminasiGaussJordan(A, b, false);                   t2 = toc;
tic; DekomposisiLU(A, b, false);                          t3 = toc;
tic; IterasiJacobi(A, b, tol, max_iter, false);           t4 = toc;
tic; IterasiGaussSeidel(A, b, tol, max_iter, false);      t5 = toc;
tic; for r = 1:N, EliminasiGauss(A, b, false); end;                    r1 = toc/N;
tic; for r = 1:N, EliminasiGaussJordan(A, b, false); end;              r2 = toc/N;
tic; for r = 1:N, DekomposisiLU(A, b, false); end;                     r3 = toc/N;
tic; for r = 1:N, IterasiJacobi(A, b, tol, max_iter, false); end;      r4 = toc/N;
tic; for r = 1:N, IterasiGaussSeidel(A, b, tol, max_iter, false); end; r5 = toc/N;

fprintf('\n========== SOAL 3: RUNNING TIME ==========\n');
fprintf('%-16s %-10s %-8s %-16s %-22s\n', 'Metode', 'Jenis', 'Iterasi', '1x jalan (detik)', 'Rata-rata 1000x (detik)');
fprintf('%-16s %-10s %-8s %-16.6f %-22.9f\n', 'Gauss',          'Langsung', '-', t1, r1);
fprintf('%-16s %-10s %-8s %-16.6f %-22.9f\n', 'Gauss-Jordan',   'Langsung', '-', t2, r2);
fprintf('%-16s %-10s %-8s %-16.6f %-22.9f\n', 'Dekomposisi LU', 'Langsung', '-', t3, r3);
fprintf('%-16s %-10s %-8d %-16.6f %-22.9f\n', 'Jacobi',         'Iteratif', it4, t4, r4);
fprintf('%-16s %-10s %-8d %-16.6f %-22.9f\n', 'Gauss-Seidel',   'Iteratif', it5, t5, r5);
