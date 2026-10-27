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

%% 4. ANALISIS KELAYAKAN METODE ITERATIF
%  Syarat cukup konvergen: matriks dominan secara diagonal (strictly
%  diagonally dominant): |a_ii| > sum_{j != i} |a_ij| untuk semua i.
fprintf('\n--- Uji dominasi diagonal, URUTAN PERSAMAAN ASLI ---\n');
dominan_asli = true;
for i = 1:4
    diag_i = abs(A(i,i));
    lain_i = sum(abs(A(i,:))) - diag_i;
    if diag_i > lain_i, ket = 'terpenuhi'; else, ket = 'TIDAK terpenuhi'; dominan_asli = false; end
    fprintf('Baris %d: |a%d%d| = %5.2f  vs  jumlah lainnya = %5.2f  -> %s\n', i, i, i, diag_i, lain_i, ket);
end

% Jari-jari spektral matriks iterasi Gauss-Seidel: T = -(D+L)^(-1) U
D = diag(diag(A));  L = tril(A,-1);  U = triu(A,1);
T_asli = -(D+L) \ U;
rho_asli = max(abs(eig(T_asli)));
fprintf('Jari-jari spektral Gauss-Seidel urutan asli = %.4f (konvergen jika < 1)\n', rho_asli);

%% 5. PENATAAN ULANG PERSAMAAN (pertukaran baris/pivoting)
%  Menukar urutan persamaan tidak mengubah solusi SPL.
%  Aturan: baris yang unsur terbesarnya ada di kolom k dijadikan baris ke-k.
[~, kolom_maks] = max(abs(A), [], 2);
urutan = zeros(1,4);
urutan(kolom_maks) = 1:4;
fprintf('\nKolom unsur terbesar tiap baris : %s\n', mat2str(kolom_maks'));
fprintf('Urutan baris baru (baris asli)  : %s\n', mat2str(urutan));

Ab = A(urutan,:);   bb = b(urutan);
nama_baru = nama(urutan);
fprintf('\n--- SPL setelah persamaan ditata ulang ---\n');
for i = 1:4
    fprintf('%-6s: %5.2f x1 + %5.2f x2 + %5.2f x3 + %5.2f x4 = %d\n', ...
        nama_baru{i}, Ab(i,1), Ab(i,2), Ab(i,3), Ab(i,4), bb(i));
end

fprintf('\n--- Uji dominasi diagonal, SETELAH penataan ulang ---\n');
dominan_baru = true;
for i = 1:4
    diag_i = abs(Ab(i,i));
    lain_i = sum(abs(Ab(i,:))) - diag_i;
    if diag_i > lain_i, ket = 'terpenuhi'; else, ket = 'TIDAK terpenuhi'; dominan_baru = false; end
    fprintf('Baris %d: |a%d%d| = %5.2f  vs  jumlah lainnya = %5.2f  -> %s\n', i, i, i, diag_i, lain_i, ket);
end
D = diag(diag(Ab));  L = tril(Ab,-1);  U = triu(Ab,1);
rho_baru = max(abs(eig(-(D+L) \ U)));
fprintf('Jari-jari spektral Gauss-Seidel setelah ditata ulang = %.4f\n', rho_baru);

if dominan_baru
    fprintf('KESIMPULAN: SPL dapat diselesaikan dengan metode iteratif Gauss-Seidel.\n');
end

%% 6. METODE GAUSS-SEIDEL
%  x_i^(k+1) = ( b_i - sum_{j<i} a_ij x_j^(k+1) - sum_{j>i} a_ij x_j^(k) ) / a_ii
tol     = 1e-6; % toleransi galat (selisih maksimum dua iterasi berurutan)
maks_it = 1000; % batas jumlah iterasi
xs = zeros(4,1); % tebakan awal [0 0 0 0]

fprintf('\n--- Iterasi Gauss-Seidel (tebakan awal = 0, toleransi = %g) ---\n', tol);
fprintf('%-5s %-14s %-14s %-14s %-14s %-12s\n', 'iter', 'x1 (beras)', 'x2 (telur)', 'x3 (tepung)', 'x4 (ayam)', 'galat maks');
fprintf('%-5d %-14.4f %-14.4f %-14.4f %-14.4f %-12s\n', 0, xs(1), xs(2), xs(3), xs(4), '-');

iterasi = 0;
for k = 1:maks_it
    x_lama = xs;
    for i = 1:4
        jumlah_lain = 0;
        for j = 1:4
            if j ~= i
                jumlah_lain = jumlah_lain + Ab(i,j) * xs(j); % xs(j) sudah terbarui untuk j<i
            end
        end
        xs(i) = (bb(i) - jumlah_lain) / Ab(i,i);
    end
    galat = max(abs(xs - x_lama));
    iterasi = k;
    fprintf('%-5d %-14.4f %-14.4f %-14.4f %-14.4f %-12.6f\n', k, xs(1), xs(2), xs(3), xs(4), galat);
    if galat < tol
        break;
    end
end

fprintf('\nBerhenti pada iterasi ke-%d\n', iterasi);

%% 7. HASIL AKHIR DAN VERIFIKASI
fprintf('\n=== HASIL AKHIR HARGA PER KILOGRAM ===\n');
for j = 1:4
    fprintf('%-8s = Rp %12.2f /kg\n', bahan{j}, xs(j));
end

% Verifikasi 1: substitusi balik ke SPL asli (selisih total belanja)
fprintf('\n--- Verifikasi: substitusi ke SPL asli ---\n');
hitung_total = A * xs;
for i = 1:4
    fprintf('%-6s: total hitung = %12.4f | total soal = %9d | selisih = %.6f\n', ...
        nama{i}, hitung_total(i), total(i), abs(hitung_total(i)-total(i)));
end

% Verifikasi 2: pembanding metode langsung (operator \)
x_langsung = A \ b;
fprintf('\n--- Pembanding metode langsung (A\\b) ---\n');
for j = 1:4
    fprintf('%-8s: Gauss-Seidel = %12.6f | langsung = %12.6f | galat mutlak = %.2e\n', ...
        bahan{j}, xs(j), x_langsung(j), abs(xs(j)-x_langsung(j)));
end

%% 8. (OPSIONAL) BUKTI URUTAN ASLI TIDAK DIJAMIN KONVERGEN
xa = zeros(4,1);
fprintf('\n--- Gauss-Seidel pada urutan persamaan ASLI (10 iterasi pertama) ---\n');
for k = 1:10
    for i = 1:4
        jl = A(i,:) * xa - A(i,i) * xa(i);
        xa(i) = (b(i) - jl) / A(i,i);
    end
    fprintf('iter %2d: x = [%14.2f %14.2f %14.2f %14.2f]\n', k, xa(1), xa(2), xa(3), xa(4));
end
