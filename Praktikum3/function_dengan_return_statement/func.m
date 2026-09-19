% =====================================================
% Function dengan perintah "return" di dalamnya
% =====================================================

function func(param)
    fprintf('Nama saya %s!\n', param)
    return
    callname(param)   % baris ini TIDAK PERNAH dijalankan
end
