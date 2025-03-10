function [A,Pha,Y,E,R2] = harmonics(t,y,f)
%[A,Pha,Y,E,R2] = harmonics(t,y,f)
%Harmonic analysis of a time series y(t) for any number of frequencies (f) (v.gr cycles per hour)
%in the form y = A*cos(wt - Pha) + E
%The harmonic constituents (Amp, Pha) are obtained by the least mean squares
%method by Y = XB + E with error or residual E = y - Y
%It is included the explained variance parameter (R2) as a measure of
%goodness of the fit

%Contact: Rene Navarro (rininav@gmail.com)

n = length(t); %Data length
h = length(f); %Number of Harmonics
m = h*2 + 1; %Number of parameters to calculate

t = t(:); y = y(:);  f = f(:);

X = ones(n,1);
w = 2*pi.*f; % Angular frequencys

for ii = 1:h
    wt = w(ii).*t;
    X = [X cos(wt) sin(wt)]; % Covariance matrix
end

M = inv(X'*X); B = M*X'*y; % Normal equations
Y = X*B; % Fit
E = y - Y; % Fit error or residual

a = B(2:2:m); b = B(3:2:m);
A = [B(1) sqrt(a.^2 + b.^2)'];
Pha = [0 atan2(b,a)'];

z = y - mean(y); % Note: Data rewritten as anomaly serie
% sz = sqrt(z'*z/n); % Standard deviation of y
% mse = E'*E/n; % Mean square error
% r2 = 1 - mse/sz^2; % Explained varience
R2 = 1 - E'*E/(z'*z);




