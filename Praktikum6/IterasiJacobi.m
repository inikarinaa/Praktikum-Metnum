function [x, iter, konv] = IterasiJacobi(A, b, tol, max_iter, verbose)
% ITERASI JACOBI : x_baru dihitung dari seluruh x_lama
% [x,iter,konv] = IterasiJacobi(A,b,tol,max_iter)
% Default: tol = 0.001, max_iter = 20, tebakan awal x0(i) = b(i)/A(i,i)
% verbose = false -> tanpa cetak (dipakai main_SPL untuk ukur waktu)
% Dijalankan langsung (tanpa input), menggunakan soal Praktikum:
%    5p -  q -  r           = -1
%   -p + 5q -  r -  s       =  2
%   -p -  q + 4r -  s - t   =  6
%         r + 4s - 2t       =  2
%        q -  r +  s + 4t   = -1
if nargin < 2
    A = [ 5 -1 -1  0  0;
         -1  5 -1 -1  0;
         -1 -1  4 -1 -1;
          0  0  1  4 -2;
          0  1 -1  1  4];
    b = [-1; 2; 6; 2; -1];
end
if nargin < 3
    tol = 0.001;
end
if nargin < 4
    max_iter = 20;
end
if nargin < 5
    verbose = true;
end
b = b(:);
n = size(A, 1);

if verbose
    fprintf('========== ITERASI JACOBI ==========\n');
    fprintf('Toleransi = %g, maks iterasi = %d\n', tol, max_iter);
    fprintf('Cek diagonal dominan:\n');
    for i = 1 : n
        sisa = sum(abs(A(i,:))) - abs(A(i,i));
        if abs(A(i,i)) > sisa
            ket = 'dominan';
        elseif abs(A(i,i)) == sisa
            ket = 'dominan lemah (sama)';
        else
            ket = 'TIDAK dominan';
        end
        fprintf('   Baris %d: |%g| vs %g -> %s\n', i, A(i,i), sisa, ket);
    end
end

C = -A;
d = zeros(n, 1);
for i = 1 : n
    C(i,i) = 0;
    C(i,:) = C(i,:) / A(i,i);
    d(i)   = b(i) / A(i,i);
end

xlama = d;                     % tebakan awal
if verbose
    fprintf('\n iter ');
    for j = 1 : n
        fprintf('       x%d    ', j);
    end
    fprintf('   maks|selisih|\n');
    fprintf('   0  ');
    fprintf('%11.6f ', xlama);
    fprintf('\n');
end
x = xlama;  iter = max_iter;  konv = false;
for k = 1 : max_iter
    xbaru = C * xlama + d;
    sel = max(abs(xbaru - xlama));
    if verbose
        fprintf('%4d  ', k);
        fprintf('%11.6f ', xbaru);
        fprintf('   %g\n', sel);
    end
    if all(abs(xbaru - xlama) <= tol)
        x = xbaru;  iter = k;  konv = true;
        break;
    end
    xlama = xbaru;
end
if ~konv
    x = xlama;
end

if verbose
    if konv
        fprintf('\nJacobi method konverge pada iterasi ke-%d\n', iter);
    else
        fprintf('\nJacobi method not konverge (maks %d iterasi)\n', max_iter);
    end
    fprintf('\n--- HASIL AKHIR ---\n');
    for i = 1 : n
        fprintf('   x%d = %g\n', i, x(i));
    end
    fprintf('Residu ||Ax - b|| = %g\n', norm(A*x - b));
    tic; IterasiJacobi(A, b, tol, max_iter, false); t = toc;
    fprintf('Running time algoritma (tanpa cetak) = %g detik\n\n', t);
end
end
