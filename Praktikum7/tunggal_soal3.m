% METODE GRAFIK TUNGGAL (Soal 3)
clc; clear; close all;

%Plot Kurva
x = linspace(-1.5,3);
f = @(x) log(x+2) + 2*x - 3;
y = f(x);
plot(x,y)

%Menggambar sumbu x dan y
line([-2,3.5],[0,0]) % Sumbu X
line([0,0],[-8,8]) % Sumbu Y

%Annotation
text(-1.4,-4,'y = log(x+2)+2x-3')
text(1.0,1.2,'Akar \approx 0.96')

title('Grafik Tunggal Soal 3')
xlabel('x'); ylabel('f(x)');
grid on

% Simpan gambar
print('-dpng','grafik_tunggal_soal3.png');

