% =====================================================
% Anonymous Function
% =====================================================

clc; clear;

% Anonymous function dengan 1 variabel
squared = @(x) x.^2
squared(5)
squared(1:5)

% Anonymous function dengan 2 variabel
addition = @(x, y) x + y
addition(2, 7)
