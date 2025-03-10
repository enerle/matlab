clear
%ejemplo para etender las funciones empiricas ortogonales

load /Users/CIGOM/Documents/MATLAB/GolMEX/Energia/Coastal/Data/hs/box_1_hour.mat

for ii = 1:8
    [pro,~,~,~] = pro_men3(time,box(:,ii),1979);
    S(:,ii) = pro;
    clear pro
end

S = detrend(S,'constant');

N = length(S);

C = cov(S);
sigma2 = diag(C); %varianza de cada serie o variable;
%los elementos fuera de la diagonal son simetricos y son proporcionales a la covarianza
   
[F,lambda] = eig(C); %se resuelve el problema de eingenvalores
%eigenvectores (funciones) y eingenvalores

lambda = flipud(diag(lambda));
F = fliplr(F);

a = S*F; %componentes principales

ve = lambda/sum(sigma2);

ve2 = meshgrid(lambda).* (F.^2)./meshgrid(sigma2)';

%Normalizacion de las componentes principales (FEOs con unidades)
F = F.*meshgrid(sqrt(lambda));
a = a./(ones(N,1)*sqrt(lambda)');