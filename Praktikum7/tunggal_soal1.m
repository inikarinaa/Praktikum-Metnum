% METODE GRAFIK TUNGGAL (Soal 1)
clc; clear; close all;

%Plot Kurva
x = linspace(0,3); % rentang x untuk digambar
f = @(x) 3*x.^3 - 5*x.^2 + 4*x - 8; % f(x) = 0 (sudah dikurangi y = 1)
y = f(x);
plot(x,y)

%Menggambar sumbu x dan y
line([-0.5,3],[0,0]) % Sumbu X
line([0,0],[-10,20]) % Sumbu Y

%Annotation
text(0.2,-6,'y = 3x^3-5x^2+4x-8')
text(1.80,1.5,'Akar \approx 1.77')

title('Grafik Tunggal Soal 1')
xlabel('x'); ylabel('f(x)');
grid on

% Simpan gambar
print('-dpng','grafik_tunggal_soal1.png');

