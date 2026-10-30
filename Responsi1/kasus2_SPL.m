clc; clear; close all;

%% 1. DATA SOAL (angka dan satuan sesuai tabel)
nama   = {'Adel', 'Briza', 'Caca', 'Dinda'};
bahan  = {'Beras', 'Telur', 'Tepung', 'Ayam'};
jumlah = [ 2.5   1500   5     500;
           40    0.75   1000  2;
           2000  15     50    6000;
           1     4250   20    9 ];
satuan = { 'kg' 'g'  'kg'  'g';
           'hg' 'kg' 'g'   'kg';
           'g'  'hg' 'dag' 'g';
           'kg' 'g'  'hg'  'hg' };
total  = [161000; 149000; 251500; 173000]; % total belanja (Rp)

fprintf('=== KASUS 2: HARGA BAHAN MAKANAN PER KILOGRAM ===\n\n');

%% 2. KONVERSI SEMUA SATUAN KE KILOGRAM
%  1 kg = 10 hg = 100 dag = 1000 g
A = zeros(4,4);
for i = 1:4
    for j = 1:4
        switch satuan{i,j}
            case 'kg',  faktor = 1;
            case 'hg',  faktor = 0.1;
            case 'dag', faktor = 0.01;
            case 'g',   faktor = 0.001;
        end
        A(i,j) = jumlah(i,j) * faktor;
    end
end
b = total;

fprintf('--- Konversi satuan ke kg ---\n');
fprintf('%-6s %-7s %9s %-4s   %-9s\n', 'Nama', 'Bahan', 'Jumlah', 'Sat.', 'Dalam kg');
for i = 1:4
    for j = 1:4
        fprintf('%-6s %-7s %9g %-4s = %-9g\n', nama{i}, bahan{j}, jumlah(i,j), satuan{i,j}, A(i,j));
    end
end

%% 3. BENTUK SPL DAN MATRIKS
fprintf('\n--- Bentuk SPL (x1=beras, x2=telur, x3=tepung, x4=ayam) ---\n');
for i = 1:4
    fprintf('%-6s: %5.2f x1 + %5.2f x2 + %5.2f x3 + %5.2f x4 = %d\n', ...
        nama{i}, A(i,1), A(i,2), A(i,3), A(i,4), b(i));
end
fprintf('\nMatriks koefisien A:\n'); disp(A);
fprintf('Vektor konstanta b:\n');   disp(b);

%% 4. ANALISIS: APAKAH METODE TIDAK LANGSUNG (ITERATIF) BISA DIPAKAI?
%  Syarat cukup konvergen: matriks dominan secara diagonal (strictly
%  diagonally dominant): |a_ii| > sum_{j != i} |a_ij| untuk semua i.
fprintf('\n--- Uji dominasi diagonal matriks A ---\n');
dominan_asli = true;
for i = 1:4
    diag_i = abs(A(i,i));
    lain_i = sum(abs(A(i,:))) - diag_i;
    if diag_i > lain_i, ket = 'terpenuhi'; else, ket = 'TIDAK terpenuhi'; dominan_asli = false; end
    fprintf('Baris %d: |a%d%d| = %5.2f  vs  jumlah lainnya = %5.2f  -> %s\n', i, i, i, diag_i, lain_i, ket);
end

% Syarat perlu dan cukup: jari-jari spektral matriks iterasi Gauss-Seidel
% T = -(D+L)^(-1) U harus kurang dari 1.
D = diag(diag(A));  L = tril(A,-1);  U = triu(A,1);
rho_asli = max(abs(eig(-(D+L) \ U)));
fprintf('Jari-jari spektral Gauss-Seidel urutan asli = %.4f (konvergen jika < 1)\n', rho_asli);

if dominan_asli || rho_asli < 1
    fprintf('KESIMPULAN: metode iteratif Gauss-Seidel dapat dipakai.\n');
else
    fprintf('KESIMPULAN: metode iteratif TIDAK dapat dipakai, gunakan metode langsung (Gauss-Jordan).\n');
end

%% 5. BUKTI: GAUSS-SEIDEL PADA SPL INI MENYEBAR (DIVERGEN)
xa = zeros(4,1);
fprintf('\n--- Gauss-Seidel pada SPL ini (10 iterasi pertama) ---\n');
for k = 1:10
    for i = 1:4
        jl = A(i,:) * xa - A(i,i) * xa(i);
        xa(i) = (b(i) - jl) / A(i,i);
    end
    fprintf('iter %2d: x = [%14.2f %14.2f %14.2f %14.2f]\n', k, xa(1), xa(2), xa(3), xa(4));
end

%% 6. METODE GAUSS-JORDAN (METODE LANGSUNG)
%  Matriks augmented [A | b] direduksi menjadi [I | x].
aug = [A b];
fprintf('\n--- Gauss-Jordan: matriks augmented awal [A | b] ---\n');
fprintf('%12.4f %12.4f %12.4f %12.4f | %12.2f\n', aug');

for k = 1:4
    % pivoting parsial: pilih baris dengan |unsur| terbesar pada kolom k
    [~, p] = max(abs(aug(k:4, k)));
    p = p + k - 1;
    if abs(aug(p,k)) < 1e-12
        error('Matriks singular, tidak ada solusi tunggal');
    end
    if p ~= k
        aug([k p], :) = aug([p k], :);
        fprintf('\nLangkah %d: tukar baris %d dengan baris %d\n', k, k, p);
    else
        fprintf('\nLangkah %d: tanpa pertukaran baris\n', k);
    end

    % normalisasi: ubah unsur pivot menjadi 1
    aug(k,:) = aug(k,:) / aug(k,k);

    % eliminasi: nolkan kolom k pada SEMUA baris lain
    for i = 1:4
        if i ~= k
            aug(i,:) = aug(i,:) - aug(i,k) * aug(k,:);
        end
    end
    fprintf('Hasil setelah langkah %d:\n', k);
    fprintf('%12.4f %12.4f %12.4f %12.4f | %12.2f\n', aug');
end
xg = aug(:, 5);

%% 7. HASIL AKHIR DAN VERIFIKASI
fprintf('\n=== HASIL AKHIR HARGA PER KILOGRAM ===\n');
for j = 1:4
    fprintf('%-8s = Rp %12.2f /kg\n', bahan{j}, xg(j));
end

% Verifikasi 1: substitusi balik ke SPL (selisih total belanja)
fprintf('\n--- Verifikasi: substitusi ke SPL ---\n');
hitung_total = A * xg;
for i = 1:4
    fprintf('%-6s: total hitung = %12.4f | total soal = %9d | selisih = %.6f\n', ...
        nama{i}, hitung_total(i), total(i), abs(hitung_total(i)-total(i)));
end

% Verifikasi 2: pembanding operator pembagian kiri bawaan (A\b)
x_bawaan = A \ b;
fprintf('\n--- Pembanding fungsi bawaan (A\\b) ---\n');
for j = 1:4
    fprintf('%-8s: Gauss-Jordan = %12.6f | bawaan = %12.6f | galat mutlak = %.2e\n', ...
        bahan{j}, xg(j), x_bawaan(j), abs(xg(j)-x_bawaan(j)));
end
