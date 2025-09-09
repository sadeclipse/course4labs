%
clear
clc
close all


disp('')
disp('����������� ����������� � ������������, �������� �������')
disp('')
disp('�������������� ������ ���� ������ �������  � ����� fun6.m')
disp('������� ������� ��� ���������� �������� � �����. ')


% ������� ��� ���������� ��������
N = 100;
ax = -10;
bx = 10;
hx = (bx-ax)/N;
ay = -10;
by = 10;
hy = (by-ay)/N;
disp(['������� �� ��� X: ', num2str([ax,bx])])
disp(['������� �� ��� Y: ', num2str([ay,by])])

[X,Y] = meshgrid(ax:hx:bx,ay:hy:by);
Z = fun6(X,Y);
figure(1)
contour(X,Y,Z,30)
[U,V] = gradient(Z,0.2,0.2);
hold on
quiver(X,Y,U,V)




disp('������� ��������� ����� ���������� ')
p0 = ginput(1);



disp(['��������� �����: ', num2str(p0)])


opt = optimset ("fminsearch")
opt.Display = "iter"
x0=p0
[x fval] = fminsearch ( 'fun6_', x0, opt)

figure(1)
plot(p0(1),p0(2),'r*')
hold on
plot(x(1),x(2),'b*')


figure(2)
mesh(X,Y,Z)
hold on
f0=fun6_(p0);
plot3(p0(1),p0(2),f0,'r*')
plot3(x(1),x(2),fval,'b*')
