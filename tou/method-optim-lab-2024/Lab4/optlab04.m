%
clear
clc
close all


disp('')
disp('Многомерная оптимизация градиентным методом')
disp('')
disp('Предварительно должна быть задана функция и ее градиент в файле fun4.m')
disp('Задайте пределы для построения графиков в файле. ')




% Пределы для построения графиков
N = 30;
ax = -10;
bx = 10;
hx = (bx-ax)/N;
ay = -10;
by = 10;
hy = (by-ay)/N;
disp(['Пределы по оси X: ', num2str([ax,bx])])
disp(['Пределы по оси Y: ', num2str([ay,by])])


 global global_p global_edir
isConstStep = 0;
method = menu('Задайте метод оптимизации','С постоянным шагом','скорейший спуск');
if method ==1,
 isConstStep = 1;
end





disp('Задайте количество шагов и величину постоянного шага в файле. ')
nmax = 10;
dd = 1;
disp(['Величина шага: ', num2str(dd)])


eps = dd/2;
dtext = 0.2;

[X,Y] = meshgrid(ax:hx:bx,ay:hy:by);
Z = fun4(X,Y);
figure(1)
contour(X,Y,Z,30)
[U,V] = gradient(Z,0.2,0.2);
hold on


disp('Задайте начальную точку графически ')
disp('Далее наблюдайте за процессом поиска на двумерном графике линий уровня функции ')
disp('и на трехмерном графике функции ')
disp('Фоновое изображение (линии уровня, градиент, трехмерная картина) дано для понимания происходящего ')
p0 = ginput(1);
p = p0;
[fp,gp] = fun4(p(1),p(2));
fp0=fp;


plot(p0(1),p0(2),'ks')
text(p0(1)+dtext ,p0(2)+dtext,'START')
quiver(X,Y,U,V)


disp(['Начальная точка: ', num2str(p0)])
%p0 = [ax+(bx-ax)*rand(1); ay+(by-ay)*rand(1)];
disp('    n     x     y     f(x,y)')
disp([0, p0, fp0])   



figure(2)
mesh(X,Y,Z)
hold on
plot3(p0(1),p0(2),fun4(p0(1),p0(2)),'ko')
contour(X,Y,Z,30)


flag = 0;
for n=1:nmax
  pold = p;   

  if isConstStep==1,
   max1dsteps = 1;
   h1d = dd;
  else
   max1dsteps = 1000;
   h1d = dd/10;
  end
  global_p = p;
  global_edir = -gp/norm(gp);
 
  [xopt,fp1]=opt1ddir('fun4p',0,h1d,max1dsteps);
  p1 = p+global_edir*xopt;
  [fp1,gp1] = fun4(p1(1),p1(2));

  figure(1)
  plot(p1(1),p1(2),'bo')
  plot([p(1),p1(1)],[p(2),p1(2)],'b')

  figure(2)

  plot3(p1(1),p1(2),fp1,'k*')
  plot3(p1(1),p1(2),0,'b*')
  plot3([p(1),p1(1)],[p(2),p1(2)],[0,0],'b')
%  plot3([p(1),p1(1)],[p(2),p1(2)],[fun4(p(1),p(1)),fun4(p1(1),p1(1))],'k-')



  p = p1;
  fp=fp1;
  gp=gp1;


 disp([n, p, fp])   
 figure(1)
 plot(p(1),p(2),'ks')
 text(p(1)+dtext ,p(2)+dtext ,num2str(n))
 if norm(p-pold)<eps,
    break
 end   
end 
hold off



disp('Постройте график значения целевой функции от номера шага. ')






