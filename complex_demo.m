function [A_cw,A_ccw,Pha_cw,Pha_ccw] = complex_demo(u,v,t,f);
%no esta completo el programa

n = length(t); %Data length
h = length(f); %Number of Harmonics
m = h*4; %Number of parameters to calculate

t = t(:); U = [u v]; U = U(:);

w = 2*pi.*f; % Angular frequencys    

x = [];
for jj = 1:h
    wt = w(jj).*t;
    x = [x cos(wt) -sin(wt) cos(wt) sin(wt)];
end

X = [x' flip(x,2)']';

M = inv(X'*X); B = M*X'*U; % Normal equations
Y = X*B; % Fit
Err = U - Y; % Fit error or residual

ac = B(1:2:end); as = B(2:2:end);

A = sqrt(ac.^2 + as.^2);
epsilon = atan2(as,ac)';

wt = w.*t;

cw_r = A(1)*cos(wt + epsilon(1));      
cw_i = 1i*A(1)*sin(wt + epsilon(1));

A_cw = real(sqrt(cw_r.^2 + cw_i.^2));
Pha_cw = atan(imag(cw_i)./cw_r);

ccw_r = A(2)*cos(wt + epsilon(2)); 
ccw_i = -1i*A(2)*sin(wt + epsilon(2));

A_ccw = real(sqrt(ccw_r.^2 + ccw_i.^2));
Pha_ccw = atan(imag(ccw_i)./ccw_r);
end