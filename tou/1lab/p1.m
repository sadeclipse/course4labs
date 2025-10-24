n = 1; %% номер варианта
%a
disp('Пункт a')
a  = randi(44, 5, 1)
b = randi(44, 5, 1)
%b
disp('Пункт b')
sum = a + b
%c
disp('Пункт c')
prod = a* (b.')
%d
disp('Пункт d')
A = randi(88, 3, 4)
%e
disp('Пункт e')
second_row = A(2,:)
%f
disp('Пункт f')
third_col = A(:, 3)
%g
disp('Пункт g')
C = randi(4, 4, 4)
%h
disp('Пункт h')
c_det = det(C)
%i
disp('Пункт i')
eig_c = eig(C)
%j
disp('Пункт j')
max_c = max(max(C))
%k
disp('Пункт k')
max_second_col = max(C)
max_second_col = max_second_col(2)
%l
disp('Пункт l')
s = [1 + n, 7, 8 - n]
coefs = poly(s)
%m
disp('Пункт m')
sin_deg = sin(deg2rad(21 + n))
cos_deg = cos(deg2rad(21 + n))
tan_deg = tan(deg2rad(21 + n))
%n
disp('Пункт n')
reminder = mod((38*n), (6 + n)) 
