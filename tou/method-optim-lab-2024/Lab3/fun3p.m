function f=fun3p(x)
global global_p global_edir

xx = global_p + global_edir*x;

f = fun3(xx(1),xx(2));
