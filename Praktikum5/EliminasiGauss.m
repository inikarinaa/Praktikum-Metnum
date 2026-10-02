function x = EliminasiGauss(A, b)
% ELIMINASI GAUSS = Forward Elimination + Back Substitution
%   Pakai: klik Run (soal bawaan), atau  x = EliminasiGauss(A, b)
% Jika dijalankan langsung (tanpa input), pakai soal Praktikum 5:
%   2x1 +  x2 -  x3 = 3
%   4x1 + 3x2 +  x3 = 9
%  -2x1 +  x2 + 2x3 = 4
if nargin < 2
    A = [ 2  1 -1;
          4  3  1;
         -2  1  2];
    b = [3; 9; 4];
end
tic;
b  = b(:);
A0 = A;  b0 = b; % simpan untuk pengecekan
n  = size(A, 1);

fprintf('========== ELIMINASI GAUSS ==========\n');
fprintf('Matriks augmented [A | b] awal:\n');
disp([A b]);

% 1. FORWARD ELIMINATION
fprintf('\n--- 1. FORWARD ELIMINATION ---\n');
for i = 1 : n-1
    if abs(A(i,i)) < 1e-12
        error('Pivot nol pada baris %d', i);
    end
    fprintf('\nLangkah %d : pivot = A(%d,%d) = %g\n', i, i, i, A(i,i));
    for h = i+1 : n
        m = A(h,i) / A(i,i);                  % pengali
        A(h,:) = A(h,:) - m * A(i,:);
        b(h)   = b(h)   - m * b(i);
        fprintf('   m%d%d = %g  ->  R%d = R%d - (%g) * R%d\n', h, i, m, h, h, m, i);
    end
    disp([A b]);
end
fprintf('\nHasil forward elimination (segitiga atas):\n');
disp([A b]);

% 2. BACK SUBSTITUTION
fprintf('\n--- 2. BACK SUBSTITUTION ---\n');
x = zeros(n, 1);
x(n) = b(n) / A(n,n);
fprintf('   x%d = %g / %g = %g\n', n, b(n), A(n,n), x(n));
for i = n-1 : -1 : 1
    jumlah = A(i, i+1:n) * x(i+1:n);
    x(i) = (b(i) - jumlah) / A(i,i);
    fprintf('   x%d = (%g - (%g)) / %g = %g\n', i, b(i), jumlah, A(i,i), x(i));
end

% 3. HASIL
fprintf('\n--- 3. HASIL AKHIR ---\n');
for i = 1 : n
    fprintf('   x%d = %g   (pecahan: %s)\n', i, x(i), strtrim(rats(x(i))));
end
fprintf('Residu ||Ax - b|| = %g\n', norm(A0*x - b0));
toc
fprintf('\n');
