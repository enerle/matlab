function [tt,DD]=quitanan(t,D)
%[tt,DD]=quitanan(t,D)
%Funcion para quitar NaNs al final de la serie de tiempo
%Entrada: 
%         t: tiempo de la serie (sin NaNs)
%         D: serie con NaNs
%Salida: 
%         tt y DD son las series originales sin NaNs al final

C=isnan(D); cota=find(C==0); tt=t(1:cota(end)); DD=D(1:cota(end)); 
end

