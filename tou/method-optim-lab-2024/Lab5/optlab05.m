%
clear
clc
close all


disp('')
disp('Многомерная оптимизация (метод Нелдера-Мида)')
disp('')
disp('Предварительно должна быть задана функция  в файле fun5.m')
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





disp('Задайте количество шагов и начальный размер многогранника в файле. ')
nmax = 50;
dd = 1;
dmin = 0.01;
disp(['Размер многогранника: ', num2str(dd)])


n=2;
r = 1/sqrt(2*n*(n+1))
R = sqrt(n/(2*(n+1)))
tri = dd*[-r, -r; r, -r; 0, R];

figure(3)
plot([tri(:,1);tri(1,1)],[tri(:,2);tri(1,2)],'k-o')
hold on
plot(0,0,'r*')
hold off


eps = dd/2;
dtext = 0.2;

[X,Y] = meshgrid(ax:hx:bx,ay:hy:by);
Z = fun5(X,Y);
figure(1)
contour(X,Y,Z,30)
[U,V] = gradient(Z,0.2,0.2);
hold on
quiver(X,Y,U,V)


disp('Задайте начальную точку графически ')
disp('Далее наблюдайте за процессом поиска на двумерном графике линий уровня функции ')
disp('и на трехмерном графике функции ')
disp('Фоновое изображение (линии уровня, градиент, трехмерная картина) дано для понимания происходящего ')
%p0 = ginput(1);
[xp,yp] = ginput(1);
p0=[xp,yp];






disp(['Начальная точка: ', num2str(p0)])

opt = optimset ("fminsearch")
opt.Display = "iter"
x0=p0
[x fval] = fminsearch ( 'fun5_', x0, opt)

pause


% Начальный симплекс
simpl = tri+[p0;p0;p0];
simpl

figure(1);
plot(p0(1),p0(2),'r*')
hold on
text(p0(1)+dtext ,p0(2)+dtext,'START')


figure(2)
mesh(X,Y,Z)
hold on
plot3(p0(1),p0(2),fun5_(p0),'r*')
contour(X,Y,Z,30)




flag = 0;
for n=1:nmax

  plotsimplex(3,simpl,'k-o',1,0);
  plotsimplex(1,simpl,'k-',0,0);
  plotsimplex_f(2,simpl,'k-',0,1)

  [ms, ns] = size(simpl);

  % Calc, Sort
  for i=1:ms,  % num of verts
    pt = simpl(i,:);
    fpt(i) = fun5_(pt);
  end

  
  [fptsort, idx] = sort(fpt);
  % B, G, W
  pt_W = simpl(idx(ms),:);
  pt_G = simpl(idx(ms-1),:);
  pt_B = simpl(idx(1),:);

  funW = fpt(idx(ms));
  funG = fpt(idx(ms-1));
  funB = fpt(idx(1));

  ni = length(idx);
  simpl_sort = simpl(idx(ni:-1:1),:);



  % centroid
  pt_0 = -pt_W;
  for i=1:ms,  
    pt_0 = pt_0 + simpl(i,:);
  end
  pt_0 = pt_0/(ms-1);


  % reflect
  alpha = 1;
  pt_R = pt_0 + alpha*(pt_0-pt_W);
  simpl1 = simpl_sort;
  simpl1(1,:) = pt_R;
  funR = fun5_(pt_R);

  plotsimplex(3,simpl1,'m-o',1,0);
  plotsimplex(1,simpl1,'m-',0,0);
  plotsimplex_f(2,simpl1,'m-',0,1)

  if funR < funB,  % best
    % expansion
    kgamma = 2;
    pt_E = pt_0 + kgamma*(pt_R-pt_0);
    funE = fun5_(pt_E);
    if funE < funR,
     simpl1(1,:) = pt_E;
     plotsimplex(3,simpl1,'g-o',1,0);
     plotsimplex(1,simpl1,'g-',0,0);
     plotsimplex_f(2,simpl1,'g-',0,1)
    end
  end

  if funR >=funG,
    rho = 0.5;
    if funR > funW,
      pt_C = pt_0 +rho*(pt_W-pt_0);
    else
      pt_C = pt_0 +rho*(pt_R-pt_0);
    end
    funC = fun5_(pt_C);
    simpl2 = simpl1; 
    simpl2(1,:) = pt_C;
    plotsimplex(3,simpl2,'b-o',1,0);
    plotsimplex(1,simpl2,'b-',0,0);
    plotsimplex_f(2,simpl2,'b-',0,1)

    if funC > funW, 
     rho = 0.5;
     for i = 1:ms,
       simpl2(i,:) = pt_B + (simpl(i,:)-pt_B)*rho;
     end
     plotsimplex(3,simpl2,'r-o',1,0);
     plotsimplex(1,simpl2,'r-',0,0);
     plotsimplex_f(2,simpl2,'r-',0,1)
    end
    simpl1 = simpl2;


  end


  simpl = simpl1;

  % Размер симплекса, оптимальная точка, функция в ней
  d = norm(simpl-calccenter(simpl));
  for i=1:ms,  % num of verts
    pt = simpl(i,:);
    fpt(i) = fun5_(pt);
  end
  [fptsort, idx] = min(fpt);
  pt_B = simpl(idx,:);
  funB = fpt(idx);


  disp(['Шаг ',num2str(n)])
  disp('Размер, точка')
  disp([d, pt_B])
  disp('Функция')
  disp(funB)
  
  if d<dmin, 
    break
  end

end 
hold off


disp('Оптимизация окончена')
disp('Симплекс')
simpl

disp('Решение')
pt_B

disp('Функция')
disp(funB)





figure(3);
plot(pt_B(1),pt_B(2),'r*')
figure(1);
plot(pt_B(1),pt_B(2),'r*')


%figure(2);
%plot3(pt_0(1),pt_0(2),0,'r*')
%hold on
%plot3(pt_0(1),pt_0(2),fun5_(pt_0),'r*')






%  plot(pt_W(:,1),pt_W(:,2),'r*')
%  hold off


