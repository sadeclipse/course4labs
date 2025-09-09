%
clear
clc
close all


a0=0;
b0=10;
eps=0.1;
nmax = 5;

disp('')
disp('Одномерная оптимизация')
disp('')
disp('Предварительно должна быть задана функция в файле fun1.m')
disp(['Поиск минимума ведется на интервале [',num2str(a0),',',num2str(b0),']'])
disp('')
disp('Далее будет построен интервал неопределенности.')
disp(['Будет выполнено ',num2str(nmax),' шагов алгоритма.'])
disp('Черными треугольниками будут отмечены измерения на данном шаге')
disp('Отметьте курсором точку в области, которая будет отброшена')
disp('')
disp('По окончании работы алгоритма будут выведены границы [a,b] на каждом шаге')
disp('По этим значениям постройте график изменения интервала неопределенности')
disp('')
disp('Выберите метод оптимизации.')



a=a0;
b=b0;
fa = fun1(a);
fb = fun1(b);
fmax = max([fa,fb]);


kpause = 2;


n=1;


alphafill = 0.1;


marks = [];
method = menu('Задайте метод оптимизации','Деление пополам','Золотое сечение');


plot(a,fa,'r<',b,fb,'b>'), title('f(x)')
pause(kpause)
hold on


ab = [];


Phi = (1+sqrt(5))/2;



while n<=nmax,
 disp(['Шаг ',num2str(n),' алгоритма'])

 ab = [ab; [a,b]];

 %  Plot only
 fa = fun1(a);
 fb = fun1(b);
 plot([a a],[fa,fmax],'r-')
 plot([b b],[fb,fmax],'b-')


 if method==1,
  x0=(a+b)/2;
  x1=x0-eps;
  x2=x0+eps;      
 else
  x1 = b-(b-a)/Phi; 
  x2 = a+(b-a)/Phi;
 end


 f1=fun1(x1);
 f2=fun1(x2);




 c1 = [0.3,0.3,0.3];
 c2 = [0.7,0.7,0.7];
 plot(x1,f1,'<','MarkerEdge',c1,'MarkerFace',c1) %,x2,f2,c2)
 plot(x2,f2,'>','MarkerEdge',c1,'MarkerFace',c1) %,x2,f2,c2)
 disp('Выберите интервал, который будет отброшен')


% plot(x1,f1,'<','Color',[0,0,0,0.1])
% plot(x2,f2,'>','Color',[0,0,0,0.1])

 [xx,yy]=ginput(1);

 pause(kpause)

 plot(x1,f1,'<','MarkerEdge',c2,'MarkerFace',c2) %,x2,f2,c2)
 plot(x2,f2,'>','MarkerEdge',c2,'MarkerFace',c2) %,x2,f2,c2)


 flagOk = 0;

  plot([b b],[fb,fmax],'k-')
  plot([a a],[fa,fmax],'k-')

 if f1<f2,
  patch([x2 b b x2], [f2 f2 fmax fmax], 'k','facealpha',alphafill)
  b=x2;  % right bound 
  if xx > x2,
    flagOk = 1;
  end


 elseif f1>f2,
  patch([x1 a a x1], [f1 f1 fmax fmax], 'k','facealpha',alphafill)
  a=x1;
  if xx < x1,
    flagOk = 1;
  end


 else
  patch([x2 b b x2], [f2 f2 fmax fmax], 'k','facealpha',alphafill)
  patch([x1 a a x1], [f1 f1 fmax fmax], 'k','facealpha',alphafill)
  a=x1;
  b=x2;

  if xx < x1 || xx > x2,
    flagOk = 1;
  end
 end
 plot([b b],[fb,fmax],'b-')
 plot([a a],[fa,fmax],'r-')


 if flagOk==1,
   disp('Верно')
 else
   disp('Неверно')
 end

 marks = [marks, flagOk];
 if abs(b-a)<2*eps,
  disp('exit')
  break
 end


 pause(kpause)
 n=n+1;
end

xopt = (a+b)/2;
funopt = fun1(xopt);

%[xopt1,funopt1]=opt1d('fun1',a,b,nmax,eps,method)
%[xopt,xopt1]
%[funopt,funopt1]


grid

pause(kpause)

N = 20;
h=(b0-a0)/N;
x=a0:h:b0;
f=fun1(x);

%plot(x,f,'b-o')
plot(xopt,funopt,'r*')
plot(x,f,'k-')
hold off


disp('Оценки:')
marks

disp('Границы [a,b] на каждом шаге:')
ab
disp('По этим значениям постройте график изменения интервала неопределенности')


disp('Найденный оптимум:')
xopt
funopt



