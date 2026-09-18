% =====================================================
% doubleit.m
% Materi   : Function dengan perintah "return" di dalamnya
% Referensi: Modul Pengenalan MATLAB/Octave 2, slide "Function" (4)
%
% Karena "return" dipanggil SEBELUM "result = 2*param;", maka baris
% terakhir tidak pernah dijalankan, dan result akan selalu bernilai 0.
%
% Cara run : - cd ke folder "10_function_dengan_return_statement"
%            - Ketik: b = doubleit(4)
%              Hasil yang diharapkan: b = 0
% =====================================================

function result = doubleit(param)
    result = 0;
    return
    result = 2*param;   % baris ini TIDAK PERNAH dijalankan
end
