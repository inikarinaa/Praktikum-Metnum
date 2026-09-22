clc; clear;

%% Input dan nilai eksak
x      = 0.3;
n_list = [0 1 2 3 4];
eksak  = exp(x);           % nilai eksak sebagai pembanding

fprintf('=====================================================\n');
fprintf(' GALAT PERHITUNGAN e^%.1f DENGAN DERET TAYLOR\n', x);
fprintf('=====================================================\n');
fprintf('Nilai eksak (exp(%.1f)) = %.10f\n\n', x, eksak);
fprintf('%-4s %-15s %-15s %-15s\n', 'n', 'Pendekatan', 'Galat', 'Galat Relatif');
fprintf('-----------------------------------------------------\n');

hasil = zeros(length(n_list), 4);   % [n, pendekatan, galat, galat_relatif]

for k = 1:length(n_list)
    n = n_list(k);
    p = 0;
    for i = 0:n
        p = p + (x^i) / factorial(i);
    end

    galat          = abs(eksak - p);      % galat abstrak
    galat_relatif  = galat / eksak;       % galat relatif (thd nilai eksak)

    hasil(k,:) = [n, p, galat, galat_relatif];

    fprintf('%-4d %-15.10f %-15.10f %-15.10f\n', n, p, galat, galat_relatif);
end

fprintf('======================================================\n');
