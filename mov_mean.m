function xx = mov_mean(x,w)
%xx = mov_mean(x,v)
%Filtering tool for a data set (x) by moving average method.
%
%The moving average is performed using a window width of (w)
%which is moving one step per each time. If the window width is 
%not an even number, the programe will use w=w+1
%
%For better results is highly recomended to use: w<<length(x).
%
%Despite (xx) serie has the same length of (x), the tails of the filtered serie,
%the first w/2 elements and the last w/2 elements, will be equal to NAN.

if mod(w,2) == 1; w = w+1; end
    
if w<2 && w>=length(x)
    xx = ones(length(x),1).*nan;
    for jj =  1:length(x)-w;
        xx((w/2)+jj) = nanmean(x(jj:jj+w-1));
    end
else
disp('You need to use a window bigger than 1 and less than the total length of the serie')
end