% METODE GRAFIK GANDA (Soal 3)
clc; clear; close all;

%Plot Kurva
x = linspace(-1.5,3);
f1 = @(x) log(x+2);
f2 = @(x) -2*x + 3;
y1 = f1(x);
y2 = f2(x);
plot(x,y1,x,y2)

%Menggambar sumbu x dan y
line([-2,3.5],[0,0]) % Sumbu X
line([0,0],[-4,8]) % Sumbu Y

%Annotation
text(1.7,1.6,'y_1 = log(x+2)')
text(-1.4,5.5,'y_2 = -2x+3')
text(1.0,0.4,'Akar \approx 0.96')

title('Grafik Ganda Soal 3')
xlabel('x'); ylabel('y');
legend('y_1','y_2','Location','northeast');
grid on

% Simpan gambar
print('-dpng','grafik_ganda_soal3.png');

