function [f1,f2,C] = diagdist(tipo,data,n)
%[f1,f2,C] = diagdist(tip,data,n)
%Calcula la distribucion de frecuencias absolutas (f1) y acumulada (f2) de
%los datos en (data) por (n) clases (C). Las distribucion de frecuencia puede 
%ser normalizada (tip=1) o no (tip=0). 

ini = min(data); fin = max(data); 
R = fin - ini; A = R/n; IC = ini:A:fin; %intervalos de clase

%frecuencia absoluta
for ii = 1:length(IC)-1;
    index = find(data >= IC(ii) & data < IC(ii)+A);
    f1(ii) = length(data(index)); 
end

 C = ones(n,1).*nan; %aqui se hace el valor promedio de cada intervalo
for jj =  1:length(IC)-1;
    C(jj) = mean(IC(jj:jj+1));
end
C = C'; %para que sea un vector renglon

%frecuencia acumulada
for ii = 1:length(f1);
    f2(ii) = sum(f1(1:ii));
end

if tipo == 1; %normalizados
    f1 = f1./length(data);
    f2 = f2./max(f2);
else %sin normalizar
end
end