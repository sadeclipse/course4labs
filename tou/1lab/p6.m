figure(1)
[x,y] = meshgrid(-5:0.5:5);
z = 2.*x.^3 + 2.*y.^2;
mesh(x,y,z);
contour(x, y, z, 5)
title('level lines 1st method')
colormap("winter")


% второй метод 
figure(2)
X = -2:0.2:2;
Y = -2:0.2:2;
[x,y] = meshgrid(X,Y);
z = 2.*x.^3 + 2.*y.^2;
contour(x,y,z,'showtext', 'on');
title('level lines 2nd method')
colormap("winter")
