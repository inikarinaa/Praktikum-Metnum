% =====================================================
% multi.m
% Materi   : Function dengan beberapa nilai return
% Referensi: Modul Pengenalan MATLAB/Octave 2, slide "Function" (3)
% Cara run : - cd ke folder "09_function_multi_return"
%            - Ketik: [x, y] = multi(3, 4)
%              Hasil yang diharapkan: x = 6, y = 12
% =====================================================

function [mult2, mult3] = multi(param1, param2)
    mult2 = param1*2;
    mult3 = param2*3;
end
