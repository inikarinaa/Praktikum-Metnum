% METODE GRAFIK GANDA (Soal 1)
clc; clear; close all;

%Plot Kurva
x = linspace(0,3);
f1 = @(x) 3*x.^3 - 5*x.^2 + 4*x - 7;
f2 = @(x) 1*ones(size(x)); % konstanta y = 1 (dibuat sepanjang x)
y1 = f1(x);
y2 = f2(x);
plot(x,y1,x,y2)

%Menggambar sumbu x dan y
line([-0.5,3],[0,0]) % Sumbu X
line([0,0],[-10,20]) % Sumbu Y

%Annotation
text(0.2,-6,'y_1 = 3x^3-5x^2+4x-7')
text(0.3,2.5,'y_2 = 1')
text(1.80,-2.5,'Akar \approx 1.77')

title('Grafik Ganda Soal 1')
xlabel('x'); ylabel('y');
legend('y_1','y_2','Location','northwest');
grid on

% Simpan gambar
print('-dpng','grafik_ganda_soal1.png');

