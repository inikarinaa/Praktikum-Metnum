function x = EliminasiGauss(A, b, verbose)
% ELIMINASI GAUSS = Forward Elimination + Back Substitution
% x = EliminasiGauss(A, b)
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
    verbose = true;
end
b  = b(:);
A0 = A;  b0 = b;
n  = size(A, 1);

if verbose
    fprintf('========== ELIMINASI GAUSS ==========\n');
    fprintf('Matriks augmented [A | b] awal:\n');
    disp([A b]);
    fprintf('\n--- 1. FORWARD ELIMINATION ---\n');
end
for i = 1 : n-1
    if abs(A(i,i)) < 1e-12
        error('Pivot nol pada baris %d', i);
    end
    if verbose
        fprintf('\nLangkah %d : pivot = A(%d,%d) = %g\n', i, i, i, A(i,i));
    end
    for h = i+1 : n
        m = A(h,i) / A(i,i);
        A(h,:) = A(h,:) - m * A(i,:);
        b(h)   = b(h)   - m * b(i);
        if verbose
            fprintf('   m%d%d = %g  ->  R%d = R%d - (%g) * R%d\n', h, i, m, h, h, m, i);
        end
    end
    if verbose
        disp([A b]);
    end
end

if verbose
    fprintf('\n--- 2. BACK SUBSTITUTION ---\n');
end
x = zeros(n, 1);
x(n) = b(n) / A(n,n);
if verbose
    fprintf('   x%d = %g / %g = %g\n', n, b(n), A(n,n), x(n));
end
for i = n-1 : -1 : 1
    jumlah = A(i, i+1:n) * x(i+1:n);
    x(i) = (b(i) - jumlah) / A(i,i);
    if verbose
        fprintf('   x%d = (%g - (%g)) / %g = %g\n', i, b(i), jumlah, A(i,i), x(i));
    end
end

if verbose
    fprintf('\n--- 3. HASIL AKHIR ---\n');
    for i = 1 : n
        fprintf('   x%d = %g   (pecahan: %s)\n', i, x(i), strtrim(rats(x(i))));
    end
    fprintf('Residu ||Ax - b|| = %g\n', norm(A0*x - b0));
    tic; EliminasiGauss(A0, b0, false); t = toc;
    fprintf('Running time algoritma (tanpa cetak) = %g detik\n\n', t);
end
end
