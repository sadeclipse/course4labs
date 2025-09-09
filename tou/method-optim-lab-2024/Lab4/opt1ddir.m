function [xopt,funopt]=opt1ddir(func,x0,h,nmax)

eps = 0.01;
dx = h;


flagexit=0;
x = x0;
n = 1;

while flagexit ==0,
 f0=feval(func,x);
 x1 = x+dx;
 f1=feval(func,x1);
 if f1>f0, 
  dx = -dx;
  x1 = x+dx;
  f1=feval(func,x1);
  if f1>f0, 
    x1=x;
    flagexit = 1;
  end
 end
 x = x1;
 n=n+1;
 if n>nmax
  flagexit = 1;
 end
end

xopt = x;
funopt = feval(func,xopt);


