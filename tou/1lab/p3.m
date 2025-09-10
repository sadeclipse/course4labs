%не был выдан файл, но я поверю, что оно работает, честно
f = load('load.txt');
plot(f(:,1), f(:,2));
grid on; xlabel('x'); ylabel('f');title('f(x)');
