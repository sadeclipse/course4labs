clear,clc; 
x = 2:0.001:12; 
f = fun2(x); 
text = sprintf("Минимальное значение ф-ии:\t%.3f\n",min(f)); 
disp(text);
text = sprintf("Максимальное значение ф-ии:\t%.3f\n",max(f)); 
disp(text);
