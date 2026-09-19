% =====================================================
% Function dengan perintah "return" di dalamnya
% =====================================================

function result = doubleit(param)
    result = 0;
    return
    result = 2*param;   % baris ini TIDAK PERNAH dijalankan
end
