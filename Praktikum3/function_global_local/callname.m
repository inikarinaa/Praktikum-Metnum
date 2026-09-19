% =====================================================
% Function - beberapa fungsi dalam satu file (global vs lokal)
% =====================================================

function callname(param)
    param1 = param(1);
    fprintf('Kata "%s" diawali dengan huruf %c.\n', param, param(1))
end
