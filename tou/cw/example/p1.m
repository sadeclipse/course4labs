v = 0:0.01:10;
R = 2.5885*v.*abs(v);
plot(v,R)
grid on
title('График зависимости R(V)')
xlabel('v, м/с')
ylabel('R, кН')
