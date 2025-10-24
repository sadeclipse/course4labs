function [xopt, funopt] = opt1ddir(func, x0, h, nmax)
% Одномерная оптимизация вдоль направления
% Для функции f(x,y) = x^3 + y^3 - 3xy

eps = 0.001; % Увеличена точность для нелинейной функции
dx = h;

flagexit = 0;
x = x0;
n = 1;

% Начальное значение функции
f0 = feval(func, x);

while flagexit == 0
    x1 = x + dx;
    f1 = feval(func, x1);
    
    % Для нелинейной функции проверяем оба направления более тщательно
    if f1 > f0
        dx = -dx; % Меняем направление
        x1 = x + dx;
        f1 = feval(func, x1);
        
        if f1 > f0
            % Пробуем меньший шаг в обоих направлениях
            dx_small = dx/2;
            x1_small = x + dx_small;
            f1_small = feval(func, x1_small);
            
            if f1_small < f0
                x1 = x1_small;
                f1 = f1_small;
                dx = dx_small;
            else
                % Если ни в одном направлении нет улучшения, останавливаемся
                x1 = x;
                flagexit = 1;
            end
        end
    end
    
    % Обновляем значения для следующей итерации
    x = x1;
    f0 = f1;
    n = n + 1;
    
    % Проверяем условия остановки
    if n > nmax
        flagexit = 1;
    end
    
    % Дополнительное условие остановки по маленькому изменению
    if abs(dx) < eps
        flagexit = 1;
    end
end

xopt = x;
funopt = feval(func, xopt);
end