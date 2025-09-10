figure(1) 
X = -5:5; 
Y = -5:5; 
[x,y] = meshgrid(X,Y); 
z = (x.^2+y-11).^2 + (x+y.^2-7).^2;
mesh(x,y,z); 
xlabel('x');
ylabel('y'); 
zlabel('z'); 

figure(2) 
contour(x,y,z,'showtext', 'on'); 
grid on 