function f=fun3(x,y)

% banana
f1 = (1-x).^2+100*(y-x.^2).^2;
%Himmelblau
f2 = (x.^2+y-11).^2+(x+y.^2-7).^2;
%Ellips
f3 = (3*x+7*y-12).^2;
f4 = (x-2).^2+5*(y-1).^2;


f=f4;


