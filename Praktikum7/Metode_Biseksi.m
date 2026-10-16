clc; clear; close all;

n   = 20; % maksimal iterasi
tol = 10^-4; % batas toleransi error = 0.0001

% SOAL 1
disp('==================================================');
disp('SOAL 1 : y = 3x^3 - 5x^2 + 4x - 7 , dengan y = 1');
disp('         f(x) = 3x^3 - 5x^2 + 4x - 8 = 0');
disp('         Interval awal [a,b] = [1, 2]');
disp('==================================================');
f = @(x) 3*x.^3 - 5*x.^2 + 4*x - 8;
a = 1;
b = 2;

disp('--- Metode Biseksi ---');
c1_bis = Biseksi(f,a,b,n,tol);
printf('Akar (Biseksi)       = %.6f , f(akar) = %.6f\n\n', c1_bis, f(c1_bis));

% SOAL 2
disp('==================================================');
disp('SOAL 2 : y = e^x - x^2 , dengan y = 0');
disp('         f(x) = e^x - x^2 = 0');
disp('         Interval awal [a,b] = [-1, 0]');
disp('==================================================');
f = @(x) exp(x) - x.^2;
a = -1;
b = 0;

disp('--- Metode Biseksi ---');
c2_bis = Biseksi(f,a,b,n,tol);
printf('Akar (Biseksi)       = %.6f , f(akar) = %.6f\n\n', c2_bis, f(c2_bis));

% SOAL 3
disp('==================================================');
disp('SOAL 3 : y = log(x+2) + 2x - 3 , dengan y = 0');
disp('         f(x) = log(x+2) + 2x - 3 = 0   (log = ln)');
disp('         Interval awal [a,b] = [0.5, 1.5]');
disp('==================================================');
f = @(x) log(x+2) + 2*x - 3;
a = 0.5;
b = 1.5;

disp('--- Metode Biseksi ---');
c3_bis = Biseksi(f,a,b,n,tol);
printf('Akar (Biseksi)       = %.6f , f(akar) = %.6f\n\n', c3_bis, f(c3_bis));

% RINGKASAN
disp('==================================================');
disp('RINGKASAN HASIL AKAR (METODE BISEKSI)');
disp('==================================================');
printf('%-8s %-16s\n','Soal','Biseksi');
printf('%-8d %-16.6f\n',1,c1_bis);
printf('%-8d %-16.6f\n',2,c2_bis);
printf('%-8d %-16.6f\n',3,c3_bis);

