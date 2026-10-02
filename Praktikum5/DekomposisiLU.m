function x = DekomposisiLU(A, b)
% DEKOMPOSISI LU : A = LU, lalu Ly = b dan Ux = y
%   Pakai: klik Run (soal bawaan), atau  x = DekomposisiLU(A, b)
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

fprintf('========== DEKOMPOSISI LU ==========\n');
fprintf('Matriks A:\n');
disp(A);
fprintf('Vektor b:\n');
disp(b);

% 1. FORWARD ELIMINATION (pengali disimpan ke L)
fprintf('\n--- 1. FORWARD ELIMINATION ---\n');
L = eye(n);
for i = 1 : n-1
    if abs(A(i,i)) < 1e-12
        error('Pivot nol pada baris %d', i);
    end
    fprintf('\nLangkah %d : pivot = A(%d,%d) = %g\n', i, i, i, A(i,i));
    for h = i+1 : n
        m = A(h,i) / A(i,i);
        L(h,i) = m;                          % simpan pengali ke L
        A(h,:) = A(h,:) - m * A(i,:);
        fprintf('   L(%d,%d) = m = %g  ->  R%d = R%d - (%g) * R%d\n', h, i, m, h, h, m, i);
    end
    disp(A);
end
U = A;

fprintf('\nMatriks L (segitiga bawah, diagonal = 1):\n');
disp(L);
fprintf('Matriks U (segitiga atas):\n');
disp(U);

% 2. PEMBUKTIAN A = LU
fprintf('\n--- 2. PEMBUKTIAN A = LU ---\n');
fprintf('L * U =\n');
disp(L*U);
fprintf('A (asli) =\n');
disp(A0);
selisih = max(max(abs(A0 - L*U)));
fprintf('Selisih maksimum |A - LU| = %g\n', selisih);
if selisih < 1e-10
    fprintf('Terbukti A = LU\n');
end

% 3. FORWARD SUBSTITUTION : Ly = b
fprintf('\n--- 3. FORWARD SUBSTITUTION : Ly = b ---\n');
y = zeros(n, 1);
y(1) = b(1) / L(1,1);
fprintf('   y1 = %g\n', y(1));
for i = 2 : n
    y(i) = (b(i) - L(i,1:i-1) * y(1:i-1)) / L(i,i);
    fprintf('   y%d = %g\n', i, y(i));
end

% 4. BACKWARD SUBSTITUTION : Ux = y
fprintf('\n--- 4. BACKWARD SUBSTITUTION : Ux = y ---\n');
x = zeros(n, 1);
x(n) = y(n) / U(n,n);
fprintf('   x%d = %g\n', n, x(n));
for i = n-1 : -1 : 1
    x(i) = (y(i) - U(i,i+1:n) * x(i+1:n)) / U(i,i);
    fprintf('   x%d = %g\n', i, x(i));
end

% 5. HASIL
fprintf('\n--- 5. HASIL AKHIR ---\n');
for i = 1 : n
    fprintf('   x%d = %g   (pecahan: %s)\n', i, x(i), strtrim(rats(x(i))));
end
fprintf('Residu ||Ax - b|| = %g\n', norm(A0*x - b0));
toc
fprintf('\n');
