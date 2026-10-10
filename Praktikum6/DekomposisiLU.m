function x = DekomposisiLU(A, b, verbose)
% DEKOMPOSISI LU : A = LU, lalu Ly = b dan Ux = y
% x = DekomposisiLU(A, b)
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
    fprintf('========== DEKOMPOSISI LU ==========\n');
    fprintf('Matriks A:\n');
    disp(A);
    fprintf('Vektor b:\n');
    disp(b);
    fprintf('\n--- 1. FORWARD ELIMINATION (pengali disimpan ke L) ---\n');
end
L = eye(n);
for i = 1 : n-1
    if abs(A(i,i)) < 1e-12
        error('Pivot nol pada baris %d', i);
    end
    if verbose
        fprintf('\nLangkah %d : pivot = A(%d,%d) = %g\n', i, i, i, A(i,i));
    end
    for h = i+1 : n
        m = A(h,i) / A(i,i);
        L(h,i) = m;
        A(h,:) = A(h,:) - m * A(i,:);
        if verbose
            fprintf('   L(%d,%d) = m = %g  ->  R%d = R%d - (%g) * R%d\n', h, i, m, h, h, m, i);
        end
    end
    if verbose
        disp(A);
    end
end
U = A;

if verbose
    fprintf('\nMatriks L (segitiga bawah, diagonal = 1):\n');
    disp(L);
    fprintf('Matriks U (segitiga atas):\n');
    disp(U);
    selisih = max(max(abs(A0 - L*U)));
    fprintf('--- 2. PEMBUKTIAN A = LU ---\n');
    fprintf('Selisih maksimum |A - LU| = %g\n', selisih);
    if selisih < 1e-10
        fprintf('Terbukti A = LU\n');
    end
    fprintf('\n--- 3. FORWARD SUBSTITUTION : Ly = b ---\n');
end
y = zeros(n, 1);
for i = 1 : n
    y(i) = (b(i) - L(i,1:i-1) * y(1:i-1)) / L(i,i);
    if verbose
        fprintf('   y%d = %g\n', i, y(i));
    end
end

if verbose
    fprintf('\n--- 4. BACKWARD SUBSTITUTION : Ux = y ---\n');
end
x = zeros(n, 1);
for i = n : -1 : 1
    x(i) = (y(i) - U(i,i+1:n) * x(i+1:n)) / U(i,i);
    if verbose
        fprintf('   x%d = %g\n', i, x(i));
    end
end

if verbose
    fprintf('\n--- 5. HASIL AKHIR ---\n');
    for i = 1 : n
        fprintf('   x%d = %g   (pecahan: %s)\n', i, x(i), strtrim(rats(x(i))));
    end
    fprintf('Residu ||Ax - b|| = %g\n', norm(A0*x - b0));
    tic; DekomposisiLU(A0, b0, false); t = toc;
    fprintf('Running time algoritma (tanpa cetak) = %g detik\n\n', t);
end
end
