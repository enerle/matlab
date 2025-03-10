function MyNewColorMap = jet_gray(n)
%As jet_white, it creates a colormap that follows the "jet" colormap, but sets zero
%values to gray and linearly blends the white to the blue. This
%is equivalent to opening the colormapeditor, double-clicking the
%minimum color (darkest blue) and setting it to white in the popup
%palette.
%
%Since the "jet" colormap matrix can vary in size depending on the
%plot that it will be applied to, this function should be executed
%after any plot commands.
% modify by Rene N. from Jim Kossin (NOAA's Center for Weather and Climate)
    
    MyNewColorMap = jet(n);
    iblue = find(ismember(MyNewColorMap, [0 0 1], 'rows'));
    yy = [.9 0]; xx = [.9 iblue];
    blend = interp1(xx, yy, .9:iblue);
    for i = 1:iblue
	MyNewColorMap(i,:) = [blend(i) blend(i) 1.0000];
    end