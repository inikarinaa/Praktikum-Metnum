% =====================================================
% func.m
% Materi   : Function - fungsi berada di file terpisah
% Referensi: Modul Pengenalan MATLAB/Octave 2, slide "Function" (1)
% PENTING  : Di MATLAB/Octave, nama file HARUS SAMA dengan nama function
%            di dalamnya, dan berada di direktori/workspace yang sama.
% Cara run : - Buka Octave, cd ke folder "07_function_global_local"
%            - Di Command Window ketik: func('Yujin')
% =====================================================

function func(param)
    fprintf('Nama saya %s!\n', param)
    callname(param)   % memanggil function lain (lihat file callname.m)
end
