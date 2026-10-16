% METODE GRAFIK GANDA (Soal 2)
clc; clear; close all;

%Plot Kurva
x = linspace(-2,2);
f1 = @(x) exp(x);
f2 = @(x) x.^2;
y1 = f1(x);
y2 = f2(x);
plot(x,y1,x,y2)

%Menggambar sumbu x dan y
line([-2.5,2.5],[0,0]) % Sumbu X
line([0,0],[-1,8]) % Sumbu Y

%Annotation
text(1.0,6,'y_1 = e^x')
text(-1.9,3.5,'y_2 = x^2')
text(-0.95,1.3,'Akar \approx -0.70')

title('Grafik Ganda Soal 2')
xlabel('x'); ylabel('y');
legend('y_1','y_2','Location','north');
grid on

% Simpan gambar
print('-dpng','grafik_ganda_soal2.png');

