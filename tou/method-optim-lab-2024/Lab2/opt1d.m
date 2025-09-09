function [xopt,funopt]=opt1d(func,a,b,nmax,eps,method)


n=1;
Phi = (1+sqrt(5))/2;

while n<=nmax,
 if method==1,
  x0=(a+b)/2;
  x1=x0-eps;
  x2=x0+eps;      
 else
  x1 = b-(b-a)/Phi; 
  x2 = a+(b-a)/Phi;
 end

 f1=feval(func,x1);
 f2=feval(func,x2);

 if f1<f2,
  b=x2;  % right bound 
 elseif f1>f2,
  a=x1;

 else
  a=x1;
  b=x2;
 end
 if abs(b-a)<2*eps,
  break
 end
 n=n+1;
end

xopt = (a+b)/2
funopt = feval(func,xopt)
n

