function c = RegulaFalsi(f,a,b,n,tol)
  %menghitung nilai dari fungsi f pada titik a dan b
  fa = f(a);
  fb = f(b);

  %mengecek apakah fa dan fb memiliki tanda yang sama
  if fa*fb > 0
    error('Warning: sama tanda.')
  endif

  fprintf('\nIter\ta\t\tb\t\tfa\t\tfb\t\tc\t\tfc\n');

  %iterasi pencarian akar menggunakan metode regulasi falsi
  for i=1:n
    c = (a*fb-b*fa)/(fb-fa); %rumus metode regula falsi
    fc = f(c);
    %mencetak nilai
    fprintf('%d\t%f\t%f\t%f\t%f\t%f\t%f\n', ...
            i,a,b,fa,fb,c,fc);

    %menghentikan iterasi saat error mencapai batas toleransi
    if abs(c-a) <= tol || abs(c-b) <= tol
      break;
    endif

    %jika fa atau fc bernilai 0 maka akar ditemukan
    if fa*fc == 0
      break;
    %kondisi dimana akar berada diantara a dan c
    %sehingga nilai c menggantikan nilai b
    elseif fa*fc < 0
      b = c;
      fb = f(b);
    %kondisi dimana akar berada diantara b dan c
    %sehingga nilai c menggantikan nilai a
    else
      a = c;
      fa = f(a);
    endif
  endfor
end
