function x = EliminasiGaussJordan(A, b)
% ELIMINASI GAUSS-JORDAN = Forward + Backward Elimination -> matriks identitas
%   Pakai: klik Run (soal bawaan), atau  x = EliminasiGaussJordan(A, b)
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
A0 = A;  b0 = b;
n  = size(A, 1);

fprintf('========== ELIMINASI GAUSS-JORDAN ==========\n');
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
        m = A(h,i) / A(i,i);
        A(h,:) = A(h,:) - m * A(i,:);
        b(h)   = b(h)   - m * b(i);
        fprintf('   m%d%d = %g  ->  R%d = R%d - (%g) * R%d\n', h, i, m, h, h, m, i);
    end
    disp([A b]);
end
fprintf('\nHasil forward elimination:\n');
disp([A b]);

% 2. BACKWARD ELIMINATION
fprintf('\n--- 2. BACKWARD ELIMINATION ---\n');
for i = n : -1 : 2
    fprintf('\nLangkah %d : pivot = A(%d,%d) = %g\n', n-i+1, i, i, A(i,i));
    for h = i-1 : -1 : 1
        m = A(h,i) / A(i,i);
        A(h,:) = A(h,:) - m * A(i,:);
        b(h)   = b(h)   - m * b(i);
        fprintf('   m%d%d = %g  ->  R%d = R%d - (%g) * R%d\n', h, i, m, h, h, m, i);
    end
    disp([A b]);
end
fprintf('\nHasil backward elimination (matriks diagonal):\n');
disp([A b]);

% 3. NORMALISASI -> MATRIKS IDENTITAS
fprintf('\n--- 3. NORMALISASI (baris dibagi elemen diagonal) ---\n');
for i = 1 : n
    d = A(i,i);
    A(i,:) = A(i,:) / d;
    b(i)   = b(i) / d;
    fprintf('   R%d = R%d / (%g)\n', i, i, d);
end
fprintf('\nMatriks identitas [I | x]:\n');
disp([A b]);

% 4. HASIL
x = b;            % solusi langsung terbaca, tanpa substitusi mundur
fprintf('\n--- 4. HASIL AKHIR ---\n');
for i = 1 : n
    fprintf('   x%d = %g   (pecahan: %s)\n', i, x(i), strtrim(rats(x(i))));
end
fprintf('Residu ||Ax - b|| = %g\n', norm(A0*x - b0));
toc
fprintf('\n');
