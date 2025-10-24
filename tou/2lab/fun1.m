
function f=fun1(x)
n1 = 1;
n2 = 2;
n3 = 1;
n = mod((n1 + n2 + n3), 8) + 1;
a0 = 10 - n;
a1 = 3 + n;
b1 = 2 + 1.1*n;
c1 = 0.2 + n/20;

f = a0 + a1*abs(x-b1).^(c1);
end



