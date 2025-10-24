figure(1)
X = 0:0.5:3; 
Y = 0:0.5:2; 
[x,y] = meshgrid(X,Y); 
z = (1-x).^2 + 100*(y-x.^2).^2; 
figure(1) 
mesh(x,y,z); 
xlabel('x'); 
ylabel('y'); 
zlabel('z'); 
title('Our mesh')


figure(2)
contour(x,y,z,'showtext', 'on');
title('level lines')
colormap("winter")