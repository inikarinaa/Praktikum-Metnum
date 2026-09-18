% =====================================================
% callname.m
% Materi   : Function - beberapa fungsi dalam satu file (global vs lokal)
% Referensi: Modul Pengenalan MATLAB/Octave 2, slide "Function" (2)
%
% CATATAN PENTING SOAL OCTAVE vs MODUL:
% Pada modul (MATLAB), "func" dan "callname" didefinisikan dalam SATU
% file yang sama (func.m). Di MATLAB itu diperbolehkan: hanya function
% PALING ATAS (func) yang bersifat GLOBAL (bisa dipanggil dari Command
% Window), sedangkan function di bawahnya (callname) bersifat LOKAL
% (hanya bisa dipanggil oleh function lain di file yang sama).
%
% Karena itu di sini "callname" saya taruh di file terpisah (callname.m)
% supaya bisa dijalankan di Octave dengan aman. Jika kamu ingin PERSIS
% seperti modul (satu file berisi dua function), gabungkan isi func.m
% dan callname.m ini ke dalam SATU file bernama func.m, dengan urutan:
% function func dulu di paling atas, baru function callname di bawahnya.
%
% Cara run : - cd ke folder "07_function_global_local"
%            - Ketik: func('Yujin')   (callname akan otomatis terpanggil)
% =====================================================

function callname(param)
    param1 = param(1);
    fprintf('Kata "%s" diawali dengan huruf %c.\n', param, param(1))
end
