function f=fun4p(x)
global global_p global_edir

xx = global_p + global_edir*x;

f = fun4(xx(1),xx(2));
