function f=fun6(x,y)

% banana
f1 = (1-x).^2+100*(y-x.^2).^2;

%Himmelblau
f2 = (x.^2+y-11).^2+(x+y.^2-7).^2;
%Ellips
f3 = (3*x+7*y-12).^2;

f4 = (x-2).^2+5*(y-1).^2;


f5 = 3*(sin(x)).^2+(y-1).^2;


alphax = 100;
ax = 0.5;
bx = 2;

PhiX = zeros(size(x));
i1 = find(x>bx);
PhiX(i1) = alphax*(x(i1)-bx).^2;
i2 = find(x<ax);
PhiX(i2) = alphax*(x(i2)-ax).^2;

PhiY =0;



f=f5;


f = f+PhiX+PhiY;

