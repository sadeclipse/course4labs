
function f=fun2(x)
n1 = 1;
n2 = 2;
n3 = 1;
n = mod((n1 + n2 + n3), 8) + 1;
a2 = -0.3 + 0.06*n;
k = 0.5 + 0.15*n;
f = 1*(a2*x- abs(cos((pi*x)/9+1)).^k);
end



