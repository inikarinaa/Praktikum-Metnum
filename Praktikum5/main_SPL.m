% PROGRAM PERBANDINGAN HASIL 3 METODE (Praktikum 5)
%   2x1 +  x2 -  x3 = 3
%   4x1 + 3x2 +  x3 = 9
%  -2x1 +  x2 + 2x3 = 4
% File ini HANYA untuk membandingkan hasil. Langkah rinci tiap metode
% ada di EliminasiGauss.m, EliminasiGaussJordan.m, DekomposisiLU.m
% (ketiganya bisa di-Run sendiri-sendiri).
clc; clear;

A = [ 2  1 -1;
      4  3  1;
     -2  1  2];
b = [3; 9; 4];

% evalc dipakai supaya langkah rinci tiap metode tidak ikut tercetak di sini
evalc('x1 = EliminasiGauss(A, b);');
evalc('x2 = EliminasiGaussJordan(A, b);');
evalc('x3 = DekomposisiLU(A, b);');
xe = [-2/5; 18/5; -1/5];          % solusi eksak hitungan tangan

fprintf('========== PERBANDINGAN HASIL ==========\n');
fprintf('Var     Gauss     Gauss-Jordan     LU        Eksak\n');
for i = 1 : length(b)
    fprintf('x%d   %9.6f   %9.6f   %9.6f   %9.6f\n', i, x1(i), x2(i), x3(i), xe(i));
end

fprintf('\nResidu ||Ax - b||:\n');
fprintf('   Gauss        = %g\n', norm(A*x1 - b));
fprintf('   Gauss-Jordan = %g\n', norm(A*x2 - b));
fprintf('   LU           = %g\n', norm(A*x3 - b));

fprintf('\nSelisih maks Gauss vs Gauss-Jordan = %g\n', max(abs(x1 - x2)));
fprintf('Selisih maks Gauss vs LU           = %g\n', max(abs(x1 - x3)));
if max(abs(x1 - x2)) < 1e-10 && max(abs(x1 - x3)) < 1e-10
    fprintf('KESIMPULAN: ketiga metode menghasilkan solusi yang sama.\n');
else
    fprintf('PERHATIAN: hasil ketiga metode berbeda, periksa kembali.\n');
end
