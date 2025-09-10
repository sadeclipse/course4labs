n = 1; %% номер варианта
%a
a  = randi(44, 5, 1);
b = randi(44, 5, 1);
%b
sum = a + b;
%c
prod = a* (b.');
%d
A = randi(88, 3, 4);
%e
second_row = A(2,:);
%f
third_col = A(:, 3);
%g
C = randi(4, 4, 4);
%h
c_det = det(C);
%i
eig_c = eig(C);
%j
max_c = max(max(C));
%k
max_second_col = max(C);
max_second_col = max_second_col(2);
%l
s = [1 + n, 7, 8 - n];
coefs = poly(s);
%m
sin_deg = sin(deg2rad(21 + n));
cos_deg = cos(deg2rad(21 + n));
tan_deg = tan(deg2rad(21 + n));

%n
reminder = mod((38*n), (6 + n)) 
