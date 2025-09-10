x = 0:0.1:100;
y = 3 * sin(3.*x);
plot(interp1(x,y,1:100),'r');
hold on;
plot(x,y, 'g');
grid on;
title('sin x');
legend('interpolation', 'true sine wave')
 
% для лучшей видимости можно разкомментить строчку снизу (по варианту задана сетка 1:100):
% xlim([0, 20])