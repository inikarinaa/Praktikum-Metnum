% =====================================================
% func.m
% Materi   : Function dengan perintah "return" di dalamnya
% Referensi: Modul Pengenalan MATLAB/Octave 2, slide "Function" (4)
%
% Perintah "return" menghentikan eksekusi function saat itu juga dan
% langsung kembali ke pemanggil. Baris/perintah setelah "return" TIDAK
% akan pernah dijalankan.
% Pada contoh ini, "callname(param)" tidak pernah dijalankan karena
% "return" sudah dipanggil sebelumnya.
%
% Cara run : - cd ke folder "10_function_dengan_return_statement"
%            - Ketik: func('Jungwon')
%              Hasil: hanya "Nama saya Jungwon!" yang tercetak.
% =====================================================

function func(param)
    fprintf('Nama saya %s!\n', param)
    return
    callname(param)   % baris ini TIDAK PERNAH dijalankan
end
