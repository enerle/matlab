close all; clc; clear

%Fig. 11.2. (Gill, 1982)

r=6371*1000;
betha=2*(2*pi/86400)*cos(0)*r^-1;
c=30; g=9.81; % h=(c^2)/g;

a=sqrt(c/(2*betha)); %Equatorial Rossby radii
lambda=2*a; k=(2*pi)/lambda; %k=pi/a

x=linspace(-lambda/2,lambda/2,25); %just for a entire cycle
yk=sqrt((2*c)/betha); %e-folding
y=linspace(-4*a,4*a,25);

[X,Y]=meshgrid(x/a,y/a); %normalized by the Rossby radii

%% Equatorial Kelvin wave

omega=k*c; %from dispersion relation
T=1/omega; t=0*T;

fx=sin(k.*x+omega*t);
fy=exp(-(betha.*y.^2)./(2*c));

[E,G]=meshgrid(fx,fy);

u=(g/c).*E.*G;
v=u.*0;

etha=(u.*c)./g; gp = etha.*g; 

figure; pcolor(X,Y,gp); shading interp
colormap(redblue(10))

hold on; quiver(X,Y,u,v,1,'k-','MaxHeadSize',2)
title('Kelvin wave'); xlabel('x/a'); ylabel('y/a')
axis square
print -djpeg99 kelvin.jpg

%% Equatorial mixed planetary gravity wave

omega=(1/2)*(c*k)*(1+sqrt(1-(4*betha)/(c*k^2)));

T=1/omega; t=0;

fx=cos(k.*x+omega*t);
fy=exp(-(betha.*y.^2)./(2*c));

[E,G]=meshgrid(fy,fx);

v=E.*G;

fx=sin(k.*x+omega*t);
fy=exp(-(betha.*y.^2)./(2*c));

[E,G]=meshgrid(fy,fx);
u=((omega.*y)./c).*E.*G;
gp=c.*u;

figure; pcolor(X,Y,gp'); shading interp
colormap(redblue(10));

hold on; quiver(X,Y,u',v',1,'k-','MaxHeadSize',2);
title('Mixed-Rossby gravity wave'); xlabel('x/a'); ylabel('y/a')
axis square

print -djpeg99 rossby-gravity.jpg
