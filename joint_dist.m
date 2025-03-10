function [X,Y,F,P] = joint_dist(u,v,nbin);
%[X,Y,F,P] = joint_dist(u,v,nbin);
%creates a joint distribution of u and v
%
%input: 
%      nbin: number of intervals 
%      u,v:  series for the joint distribution (both must have the same length)
%output: 
%      P,F: the probability and frequency matrix from u,v
%      X,Y: grid withn the location of each prob/freq bin

%for a joint distribution diagram
% x = linspace(min(u),max(u),nbin);
% y = linspace(min(v),max(v),nbin);

%for energy assessments only
x = linspace(0,20,nbin); 
y = linspace(0,20,nbin);

[X,Y]=meshgrid(x,y);

F = zeros(nbin,nbin).*nan;
    
    for j = 1:nbin
        ind = find(u>=x(j) & u<x(j)+mean(diff(x)));        
        vint = v(ind);
        for k = 1:nbin
            ind2 = find(vint>=y(k) & vint<y(k)+mean(diff(y))); 
            F(k,j) = length(vint(ind2));
        end
    end

P = (F./length(u)).*100;
P(P==0) = NaN; F(F==0) = NaN;
