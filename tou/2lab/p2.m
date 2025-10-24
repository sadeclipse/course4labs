clear,clc; 
x = 2:0.001:12; 
f = fun1(x); 
text = sprintf("Минимальное значение функции:\t%.3f\n",min(f)); 
disp(text);
