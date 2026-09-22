clc; clear;

x      = 1;
N_list = [1 2 3 4 5];
eksak  = sin(x);           % nilai eksak sebagai pembanding

fprintf('========================================================\n');
fprintf(' GALAT PERHITUNGAN sin(%.0f) DENGAN DERET TAYLOR\n', x);
fprintf('========================================================\n');
fprintf('Nilai eksak (sin(%.0f)) = %.10f\n\n', x, eksak);
fprintf('%-4s %-15s %-15s %-15s\n', 'N', 'Pendekatan', 'Galat', 'Galat Relatif');
fprintf('--------------------------------------------------------\n');

hasil = zeros(length(N_list), 4);   % [N, pendekatan, galat, galat_relatif]

for k = 1:length(N_list)
    N = N_list(k);
    p = 0;
    for n = 0:N
        p = p + ((-1)^n) * (x^(2*n+1)) / factorial(2*n+1);
    end

    galat          = abs(eksak - p);
    galat_relatif  = galat / eksak;

    hasil(k,:) = [N, p, galat, galat_relatif];

    fprintf('%-4d %-15.10f %-15.10f %-15.10f\n', N, p, galat, galat_relatif);
end

fprintf('========================================================\n');

% Catatan: variabel 'hasil' (matriks [N, Pendekatan, Galat, Galat_Relatif])
% dapat langsung dipakai untuk menyusun tabel pada laporan.
