%
clear
clc
close all


disp('')
disp('Многомерная оптимизация (метод Нелдера-Мида)')
disp('')
disp('Предварительно должна быть задана функция  в файле fun5_2.m')








disp('Задайте количество шагов и начальный размер многогранника в файле. ')
nmax = 50;
dd = 1;
dmin = 0.01;
disp(['Размер многогранника: ', num2str(dd)])


n=3;
r = 1/sqrt(2*n*(n+1))
R = sqrt(n/(2*(n+1)))
tetra = dd*[-r, -r, -r; r, -r, -r; 0, R, -r; 0, 0, r];

figure(2)
plot3(0,0,0,'r*')
hold on

plotsimplex(2, tetra, 'b',0, 1)






%p0 = ginput(1);
p0 = [5, 2.5, -3];
disp(['Начальная точка: ', num2str(p0)])

opt = optimset ("fminsearch")
opt.Display = "iter"
x0=p0
%[x fval] = fminsearch ( 'fun5_2', x0, opt)




% Начальный симплекс
simpl = tetra+[p0;p0;p0;p0];
simpl



flag = 0;
for n=1:nmax

  plotsimplex(1,simpl,'k',1,1);

  [ms, ns] = size(simpl);

  % Calc, Sort
  for i=1:ms,  % num of verts
    pt = simpl(i,:);
    fpt(i) = fun5_2(pt);
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
  funR = fun5_2(pt_R);

  plotsimplex(1,simpl1,'m',1,1);

  if funR < funB,  % best
    % expansion
    kgamma = 2;
    pt_E = pt_0 + kgamma*(pt_R-pt_0);
    funE = fun5_2(pt_E);
    if funE < funR,
     simpl1(1,:) = pt_E;
     plotsimplex(1,simpl1,'g',1,1);
    end
  end

  if funR >=funG,
    rho = 0.5;
    if funR > funW,
      pt_C = pt_0 +rho*(pt_W-pt_0);
    else
      pt_C = pt_0 +rho*(pt_R-pt_0);
    end
    funC = fun5_2(pt_C);
    simpl2 = simpl1; 
    simpl2(1,:) = pt_C;
    plotsimplex(1,simpl2,'b',1,1);

    if funC > funW, 
     rho = 0.5;
     for i = 1:ms,
       simpl2(i,:) = pt_B + (simpl(i,:)-pt_B)*rho;
     end
     plotsimplex(1,simpl2,'r',1,1);
    end
    simpl1 = simpl2;

  end


  simpl = simpl1;

  % Размер симплекса, оптимальная точка, функция в ней
  d = norm(simpl-calccenter(simpl));
  for i=1:ms,  % num of verts
    pt = simpl(i,:);
    fpt(i) = fun5_2(pt);
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





function pt_0 = calccenter(simpl)
  [ms, ns] = size(simpl);

 pt_0 = 0*simpl(1,:);
 for i=1:ms,  
   pt_0 = pt_0 + simpl(i,:);
 end
 pt_0 = pt_0/ms;

end


function plotsimplex(figno, simpl, c,flagtext, flagp)

 figure(figno)
 plot3(simpl(:,1),simpl(:,2),simpl(:,3),[c,'o'])
 hold on
 for i=1:4,
  k1 = i;
  for j=i:4,
   k2 = j;
   if k2>4,
    k2 = k2-4;
  end
   plot3([simpl(k1,1),simpl(k2,1)],[simpl(k1,2),simpl(k2,2)],[simpl(k1,3),simpl(k2,3)],[c,'-'])
  end
 end


 if flagtext ==1,
 dtext=0.1;
 fpt = fun5_2(simpl);
 for i=1:length(fpt),
  text(simpl(i,1)+dtext,simpl(i,2)+dtext,simpl(i,3)+dtext,num2str(fpt(i)));
 end
 end
 if flagp==1,
  pause(1)
 end


%  plot(pt_W(:,1),pt_W(:,2),'r*')
%  hold off
end
