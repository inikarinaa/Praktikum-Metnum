% METODE GRAFIK TUNGGAL (Soal 2)
clc; clear; close all;

%Plot Kurva
x = linspace(-2,2);
f = @(x) exp(x) - x.^2;
y = f(x);
plot(x,y)

%Menggambar sumbu x dan y
line([-2.5,2.5],[0,0]) % Sumbu X
line([0,0],[-4,6]) % Sumbu Y

%Annotation
text(0.3,-2.5,'y = e^x - x^2')
text(-0.95,0.7,'Akar \approx -0.70')

title('Grafik Tunggal Soal 2')
xlabel('x'); ylabel('f(x)');
grid on

% Simpan gambar
print('-dpng','grafik_tunggal_soal2.png');

