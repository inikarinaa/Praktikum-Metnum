clc; clear; close all;

%% 1. DATA MASUKAN (sesuai soal)
lambda = 12; % panjang gelombang
v      = 36; % kecepatan
x      = 10; % nilai x pada e^x
h0     = 5; % amplitudo awal
N      = [23 24 25]; % batas iterasi (indeks suku terakhir)
toleransi = 1; % batas toleransi galat relatif (%)

t = 0:0.01:5; % rentang waktu 0 <= t <= 5, langkah 0,01
z = t*v/lambda; % argumen cosinus: z = t*v/lambda

fprintf('=== KASUS 1: GALAT PEMOTONGAN GELOMBANG AIR LAUT ===\n');
fprintf('lambda = %d, v = %d, x = %d, h0 = %d\n', lambda, v, x, h0);
fprintf('Rentang t : 0 s.d. 5 (langkah 0,01) -> %d titik\n', length(t));
fprintf('Argumen cos z = t*v/lambda = %d*t, jadi z berkisar 0 s.d. %d\n\n', v/lambda, 5*v/lambda);

%% 2. HASIL EKSAK
h_eksak = h0 * (cos(z) + exp(x));
fprintf('e^x eksak (x = %d) = %.10f\n\n', x, exp(x));

%% 3. HASIL PENDEKATAN UNTUK SETIAP n
h_pendekatan = zeros(length(N), length(t)); % baris = n, kolom = t
ex_pendekatan = zeros(1, length(N));
rerata_mutlak = zeros(1, length(N));
rerata_relatif = zeros(1, length(N));
maks_relatif = zeros(1, length(N));
min_mutlak = zeros(1, length(N));
maks_mutlak = zeros(1, length(N));

for j = 1:length(N)
    n = N(j);

    % --- 3a. Pendekatan e^x = sum_{k=0}^{n} x^k / k!
    ex = 0;
    suku = 1; % suku ke-0 = x^0/0! = 1
    for k = 0:n
        if k > 0
            suku = suku * x / k; % suku_k = suku_(k-1) * x / k
        end
        ex = ex + suku;
    end
    ex_pendekatan(j) = ex;

    % --- 3b. Pendekatan cos(z) = sum_{k=0}^{n} (-1)^k z^(2k) / (2k)!
    cs = zeros(size(z));
    sukuC = ones(size(z)); % suku ke-0 = 1
    for k = 0:n
        if k > 0
            sukuC = sukuC .* (-z.^2) / ((2*k-1)*(2*k));
        end
        cs = cs + sukuC;
    end

    % --- 3c. Gabungkan menjadi h pendekatan
    h_pendekatan(j,:) = h0 * (cs + ex);

    % --- 3d. Galat
    galat_mutlak = abs(h_eksak - h_pendekatan(j,:));
    galat_relatif = galat_mutlak ./ abs(h_eksak) * 100; % dalam persen
    rerata_mutlak(j)  = mean(galat_mutlak);
    rerata_relatif(j) = mean(galat_relatif);
    maks_relatif(j)   = max(galat_relatif);
    min_mutlak(j)     = min(galat_mutlak);
    maks_mutlak(j)    = max(galat_mutlak);

    fprintf('--- n = %d ---\n', n);
    fprintf('e^x pendekatan          = %.10f\n', ex);
    fprintf('Galat mutlak e^x        = %.10f\n', abs(exp(x) - ex));
    fprintf('Galat mutlak h minimum  = %.10f\n', min_mutlak(j));
    fprintf('Galat mutlak h maksimum = %.10f\n', maks_mutlak(j));
    fprintf('Rerata galat mutlak h   = %.10f\n', rerata_mutlak(j));
    fprintf('Rerata galat relatif h  = %.10f %%\n', rerata_relatif(j));
    fprintf('Galat relatif maksimum  = %.10f %%\n\n', maks_relatif(j));
end

%% 4. CUPLIKAN NILAI h PADA BEBERAPA t
fprintf('--- Cuplikan nilai h(t) ---\n');
fprintf('%-6s %-18s %-18s %-18s %-18s\n', 't', 'f_eksak', 'f_n=23', 'f_n=24', 'f_n=25');
for tt = 0:1:5
    i = round(tt/0.01) + 1;
    fprintf('%-6.1f %-18.6f %-18.6f %-18.6f %-18.6f\n', tt, h_eksak(i), ...
        h_pendekatan(1,i), h_pendekatan(2,i), h_pendekatan(3,i));
end

%% 5. PERBANDINGAN DENGAN TOLERANSI
fprintf('\n--- Perbandingan dengan toleransi %.0f %% ---\n', toleransi);
fprintf('%-6s %-24s %-24s %-10s\n', 'n', 'Rerata galat mutlak', 'Rerata galat relatif (%)', 'Keputusan');
for j = 1:length(N)
    if rerata_relatif(j) <= toleransi
        keputusan = 'LAYAK';
    else
        keputusan = 'TIDAK LAYAK';
    end
    fprintf('%-6d %-24.8f %-24.10f %-10s\n', N(j), rerata_mutlak(j), rerata_relatif(j), keputusan);
end

%% 6. GRAFIK 1: KEEMPAT FUNGSI DALAM SATU PLOT
figure(1);
plot(t, h_eksak, 'k-', 'LineWidth', 2.5); hold on;
plot(t, h_pendekatan(1,:), 'r--', 'LineWidth', 1.5);
plot(t, h_pendekatan(2,:), 'b-.', 'LineWidth', 1.5);
plot(t, h_pendekatan(3,:), 'g:',  'LineWidth', 2);
hold off; grid on;
xlabel('t'); ylabel('h(t)');
title('Perbandingan h(t) Eksak dan Pendekatan Deret (n = 23, 24, 25)');
legend('f_{eksak}', 'f_{n=23}', 'f_{n=24}', 'f_{n=25}', 'Location', 'best');
saveas(gcf, 'kasus1_grafik_h.png');

%% 7. GRAFIK 2: GALAT MUTLAK TERHADAP t
figure(2);
semilogy(t, abs(h_eksak - h_pendekatan(1,:)), 'r-',  'LineWidth', 1.5); hold on;
semilogy(t, abs(h_eksak - h_pendekatan(2,:)), 'b--', 'LineWidth', 1.5);
semilogy(t, abs(h_eksak - h_pendekatan(3,:)), 'g-.', 'LineWidth', 1.5);
hold off; grid on;
xlabel('t'); ylabel('Galat mutlak |h_{eksak} - h_n|');
title('Galat Mutlak Setiap Pendekatan terhadap t');
legend('n = 23', 'n = 24', 'n = 25', 'Location', 'best');
saveas(gcf, 'kasus1_grafik_galat.png');
