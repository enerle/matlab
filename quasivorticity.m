clear

T=24*60*60;
r=6371*1000;
lat=(45*pi)/180;
v=20;

omega=(2*pi)/T;
beta=(2*omega*cos(lat))/r;
fo=2*omega*sin(lat);

vg=v/sqrt(2);
t=3*3600;
dvort_dt=((3e-6)/t);

L=100*1000;
dvort_dL=-(4e-6)/L;
dvort_dL=dvort_dL/1000;

div_va=(dvort_dt + vg*dvort_dL + beta*vg)/fo


