n = 0:0.05:300;
T = 0.00055*(n.^2);
plot(n,T) 
grid on
title('График зависимости T(n)')
xlabel('n, об/мин')
ylabel('T, кН')
