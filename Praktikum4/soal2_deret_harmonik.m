clc; clear;

n       = 20;      % batas atas penjumlahan (1/1 s.d. 1/20)
desimal = 4;        % jumlah angka desimal pembulatan (asumsi)

%% (a) Perhitungan secara EKSAK (dengan looping, presisi penuh)
s_eksak = 0;
for k = 1:n
    s_eksak = s_eksak + 1/k;
end

%% (b) Masing-masing pembagian DIBULATKAN (dengan looping)
% Catatan: round(X,n) tidak didukung di semua versi Octave,
% sehingga pembulatan n desimal dilakukan secara manual:
% round(x * 10^n) / 10^n
faktor  = 10^desimal;
s_bulat = 0;
for k = 1:n
    suku    = round((1/k) * faktor) / faktor;   % setiap suku 1/k dibulatkan dahulu
    s_bulat = s_bulat + suku;
end

%% (c) TANPA looping (menggunakan fungsi sum)
s_nolooping = sum(1 ./ (1:n));

%% Perhitungan galat (dengan acuan nilai eksak poin a)
galat_bulat     = abs(s_eksak - s_bulat);
galat_relatif_b = galat_bulat / s_eksak;

galat_nolooping     = abs(s_eksak - s_nolooping);
galat_relatif_c      = galat_nolooping / s_eksak;

%% Tampilkan hasil
fprintf('=================================================\n');
fprintf(' GALAT PERHITUNGAN 1/1 + 1/2 + ... + 1/%d\n', n);
fprintf('=================================================\n');
fprintf('(a) Eksak (looping)             = %.10f\n', s_eksak);
fprintf('(b) Dibulatkan %d desimal (loop) = %.10f\n', desimal, s_bulat);
fprintf('    Galat         = %.10f\n', galat_bulat);
fprintf('    Galat Relatif = %.10f\n\n', galat_relatif_b);
fprintf('(c) Tanpa looping (fungsi sum)   = %.10f\n', s_nolooping);
fprintf('    Galat         = %.10e\n', galat_nolooping);
fprintf('    Galat Relatif = %.10e\n', galat_relatif_c);
fprintf('==================================================\n');
