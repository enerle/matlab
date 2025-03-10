function [B,Y,errB,E,ve] = lms_fit(x,y,ord,tip,w)
%[B,Y,errB,E,ve] = lms_fit(x,y,ord,tip,w)
%Least-Mean Square Fit 
%
%(x,y) = Varibles a ajustar.
%ord = Orden del ajuste.
%tip = Tipo de ajuste. Sin restricciones (tip=0) y con restricciones (tip=1).
%w = Matriz de pesos. Solo se define para el caso con restricciones y debe
%       ser un vector con el error estandar de cada promedio. El vector 
%       debe de medir del mismo que las variables a ajustar.
%B = Parametros del ajuste.
%Y = Valores del ajuste.
%errB = Error de asociado a los ajustes.
%E = Error del ajuste respecto a los datos.
%Y = Valores del ajuste.
%ve = Varianza de la regresion (varianza explicada).

n = length(y); %numero de datos
m = ord + 1; %numero de parametros a determinar

x=x(:); y=y(:);
X=ones(n,1);

for j=1:ord
	X(:,j+1)=x.^j;
end

if tip == 0 %Sin pesos
    W = diag(ones(1,n)); %Matriz identidad
    
else %Con pesos
    W = diag(w.^-2);    
end
M = inv(X'*W*X); B = M*X'*W*y;

Y = X*B;
E = y - Y; %Errores asociados a la estimacion del ajuste

s2 = sum(E'*E)/(n - m); %Sigma cuadrada (distribucion Xi^2)
Cd = s2 * M; %Matriz de covarianza de los parametros
errB = sqrt(diag(Cd)); %Error de los parametros

nw = sum(diag(W)); ym = sum(y'*W)/nw; %Promedio pesado.
yd = sqrt(sum((y - ym).^2' * W)/nw); %Desviacion estandar pesada.
dta = E./yd;  %Desvio estandar del error.                       
ve = 1 - sum(dta.^2'*W)/nw; %varianza explicada por el ajuste (Emery & Thompson, )

end
