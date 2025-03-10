close all; clear; clc
%any linear combination of sine waves of same frequency but with different 
%phase shifts (ie. a cos and a sin) it is sine wave with the same frequency but with some phase shift.

%sinusoidal signals in quadrature
w = 2*pi/pi; t = 0:0.01:010; wt =w.*t;
a = 1; p1 = a.*cos(wt);
b = 1; p2 = b.*sin(wt);

%linear combination or harmonic addition of two periodic signals is equivalent to a single wave with phase shift and scaled amplitude

c = sqrt(a^2 + b^2); phi = atan2(b,a); p3 = c.*sin(wt + phi);

%original  amplitudes (a,b) sum in quadrature to yield the combined amplitude c
%the initial value of of phase is obtained

figure; 
plot(t,p1,'r','linewidth',2); hold on; plot(t,p2,'b','linewidth',2)
hold on; plot(t,p1+p2,'k','linewidth',2)
hold on; plot(t,p3,'--y','linewidth',2)
grid
