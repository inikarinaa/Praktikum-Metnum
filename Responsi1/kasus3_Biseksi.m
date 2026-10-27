clc; clear; close all;

%% 1. DATA DAN PEMODELAN
V_bola = 300 % volume bola (cm^3)
% Bola menyinggung tabung: jari-jari sama (r), tinggi tabung t = 2r
% V_bola   = (4/3)*pi*r^3
% V_tabung = pi*r^2*t = 2*pi*r^3  -> V_bola : V_tabung = 2 : 3
V_tabung = (3/2) * V_bola % = 450 cm^3
V_luar   = V_tabung - V_bola % = 150 cm^3 = (2/3)*pi*r^3

fprintf('=== KASUS 3: VOLUME TABUNG DI LUAR BOLA ===\n');
fprintf('V bola              = %.2f cm^3\n', V_bola);
fprintf('V tabung (3/2 bola) = %.2f cm^3\n', V_tabung);
fprintf('V tabung di luar bola = %.2f cm^3\n\n', V_luar);

% Persamaan nonlinear: f(r) = (2/3)*pi*r^3 - V_luar = 0
f = @(r) (2/3)*pi*r.^3 - V_luar;
fprintf('Persamaan nonlinear: f(r) = (2/3)*pi*r^3 - %.0f = 0\n\n', V_luar);

%% 2. METODE GRAFIK UNTUK MENENTUKAN SELANG AWAL
r = 0:0.01:8;
figure(1);
plot(r, f(r), 'b-', 'LineWidth', 2); hold on;
plot([0 8], [0 0], 'k-'); % sumbu r (f = 0)
plot([4 5], [f(4) f(5)], 'ro', 'MarkerFaceColor', 'r');
hold off; grid on;
xlabel('r (cm)'); ylabel('f(r)');
title('Grafik f(r) = (2/3)\pi r^3 - 150');
legend('f(r)', 'f(r) = 0', 'Titik awal a = 4 dan b = 5', 'Location', 'northwest');
saveas(gcf, 'kasus3_grafik_f.png');

a = 4;  b = 5;
fprintf('--- Metode grafik: grafik memotong sumbu r di antara 4 dan 5 ---\n');
fprintf('f(a) = f(%g) = %.6f\n', a, f(a));
fprintf('f(b) = f(%g) = %.6f\n', b, f(b));
if f(a)*f(b) < 0
    fprintf('f(a)*f(b) < 0, maka terdapat akar pada selang [%g, %g]\n\n', a, b);
else
    error('Selang awal tidak mengapit akar');
end

%% 3. METODE BISEKSI
tol = 1e-6; % toleransi lebar selang
maks_it = 100; % batas iterasi
fprintf('--- Iterasi Biseksi (toleransi = %g) ---\n', tol);
fprintf('%-4s %-11s %-11s %-12s %-12s %-12s %-12s %-12s\n', ...
    'iter', 'a', 'b', 'c=(a+b)/2', 'f(a)', 'f(b)', 'f(c)', 'galat |b-a|');

c_lama = a;
tabel_c = zeros(maks_it,1);
for k = 1:maks_it
    c  = (a + b) / 2;
    fa = f(a);  fb = f(b);  fc = f(c);
    lebar = abs(b - a);
    fprintf('%-4d %-11.6f %-11.6f %-12.8f %-12.6f %-12.6f %-12.6f %-12.2e\n', ...
        k, a, b, c, fa, fb, fc, lebar);
    tabel_c(k) = c;
    if abs(fc) < 1e-12 || lebar/2 < tol
        break;
    end
    if fa * fc < 0
        b = c; % akar di [a, c]
    else
        a = c; % akar di [c, b]
    end
end
r_akar = c;
iterasi = k;

%% 4. HASIL DAN VERIFIKASI
r_analitik = (3*V_luar/(2*pi))^(1/3); % pembanding: solusi analitik
t_tabung   = 2 * r_akar;
V_bola_cek   = (4/3)*pi*r_akar^3;
V_tabung_cek = pi*r_akar^2*t_tabung;
V_luar_cek   = V_tabung_cek - V_bola_cek;

fprintf('\n=== HASIL AKHIR ===\n');
fprintf('Iterasi             : %d\n', iterasi);
fprintf('Jari-jari r (biseksi): %.8f cm\n', r_akar);
fprintf('Jari-jari r (analitik): %.8f cm\n', r_analitik);
fprintf('Galat mutlak          : %.2e cm\n', abs(r_akar - r_analitik));
fprintf('f(r)                  : %.2e\n', f(r_akar));
fprintf('Tinggi tabung t = 2r  : %.8f cm\n', t_tabung);
fprintf('V bola (cek)          : %.6f cm^3\n', V_bola_cek);
fprintf('V tabung (cek)        : %.6f cm^3\n', V_tabung_cek);
fprintf('V tabung di luar bola : %.6f cm^3\n', V_luar_cek);

%% 5. GRAFIK KONVERGENSI
figure(2);
semilogy(1:iterasi, abs(tabel_c(1:iterasi) - r_analitik), 'b-o', 'LineWidth', 1.5);
grid on; xlabel('Iterasi'); ylabel('|c - r_{analitik}|');
title('Konvergensi Metode Biseksi');
saveas(gcf, 'kasus3_grafik_konvergensi.png');
