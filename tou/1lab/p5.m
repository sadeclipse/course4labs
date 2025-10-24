[x,y] = meshgrid(-5:0.5:5);
z = 2.*x.^3 + 2.*y.^2;
mesh(x,y,z);
title('our meshgrid')
colormap("winter")