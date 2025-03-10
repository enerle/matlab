function B = smooth_data(A)
%B = smooth_data(A)
%Smoothing of data by a spatial-Moving average for a 2D or 3D array.
%
%In this version, A(x,y,z) is the 2 or 3 dimensional input matrix with (x,y)
%as the zonal and meridional components and (t) the time. 
%
%The resulting matrix (B) has the same (x,y,t) dimensions. Note that the
%smooth it is improved toward (x,y) for every single time. Every point 
%at B are calculated by an average between the (i,j) point at its 8 surronding 
%points. For example B(i,j,:) = mean(A(i-1:i+1,j-1:j+1,:))

%Note 1: Any NaN point in B is the same in A. 
%Note 2: With 3D arrays, any NaN point at the first time A(:,:,1) it is 
%            considered NaN for the entire time frame
%Note 3: Any mean value at the entire fill, for each point of the domain
%            (for example A(1,1,1)) it is calculated with the value at this
%            point and values at the 8 surronding points.
%Note 4: in the case of boundary points (space matrix boundarys) the
%            average is calculated with less than 9 points. For example in
%            the case of the corners the average is calculate with 4 points
%            and any other point in the boundary, with 6 points.
%Rene N, 2018

%Smoothing of the entire fill
[x,y,z] = size(A);
B = ones(x,y,z).*nan;

for ii = 2:(x-1) %horizontal
    for jj = 2:(y-1) %vertical
        if isnan(A(ii,jj,1))
            B(ii,jj,:) = NaN; %land
        else
            wd =  A(ii-1:ii+1,jj-1:jj+1,:); %(3,3,time)
            B(ii,jj,:) = nanmean(nanmean(wd,1),2); %(1,1,time)
        end
    end
end

%smoothing of the upper and lower borders
for ii = [1 x]
    for jj = 2:(y-1)
        if isnan(A(ii,jj,1))
%             B(ii,jj,:) = NaN;
        else
            if ii == 1
                wd =  A(ii:ii+1,jj-1:jj+1,:);
            elseif ii == x
                wd =  A(ii-1:ii,jj-1:jj+1,:);
            end
            B(ii,jj,:) = nanmean(nanmean(wd,1),2);
        end
        clear wd
    end
end

%smoothing of the left and right borders
for ii = 2:(x-1)
    for jj = [1 y]
        if isnan(A(ii,jj,1))
        else
            if jj == 1
                wd =  A(ii-1:ii+1,jj:jj+1,:);
            elseif jj == y
                wd =  A(ii-1:ii+1,jj-1:jj,:);
            end
            B(ii,jj,:) = nanmean(nanmean(wd,1),2);
        end
    end
end

%smoothing of the corners
for ii = [1 x]
    for jj = [1 y]
        if isnan(A(ii,jj,1))
        else
            if ii == 1 && jj == 1 %up&left
                wd =  A(ii:ii+1,jj:jj+1,:);
            elseif ii == x && jj == 1 %up&right
                wd =  A(ii-1:ii,jj:jj+1,:);
            elseif ii == 1 && jj == y %down&left
                wd =  A(ii:ii+1,jj-1:jj,:);
            elseif ii == x && jj == y %down&right
                wd =  A(ii-1:ii,jj-1:jj,:);
            end
            B(ii,jj,:) = nanmean(nanmean(wd,1),2);
        end
    end
end
