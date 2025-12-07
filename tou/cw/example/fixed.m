clear
global flagplot parmodel
% for part 2
needOpt = 1; % 0 – simulation only

%PUT YOUR DATA HERE
kv = 0.000874; % 0.5*Omega*C/m
vmax = 14*0.514; %m/s
reverse = 1; %enable reverese
kregv = 6; % av: kv*(V*-v)
kregi = 0.001; % ai
distance_nm = 5; %mileage
distance = distance_nm*1852; %m:
vset = 12*0.514; %m/s
vcur = 0*0.514; % current spd, m/s
vwind = 6; % wind spd, m/s

% Simulation settings
dt = 0.5;
tmax = 10*distance/vmax;
if reverse==0,
    tmax = tmax*2;
end
vend = 0.1; %v<vend in the end of trackstop
parmodel = [distance, vset, kregv, kv, vmax, dt, tmax, reverse, vend, vcur, kregi];

% Начальные параметры
t1 = 92.256;
stopdistance = 1129.4;
params = [t1, stopdistance];

% Оптимизация с сохранением результата
if needOpt,
    flagplot = 0; % Отключаем графику для оптимизации
    
    % Настраиваем оптимизатор
    opt = optimset('fminsearch');
    opt.Display = 'iter';
    opt.OutputFcn = []; % Можно добавить свою output функцию при необходимости
    
    % Выполняем оптимизацию и сохраняем ВСЕ выходные данные
    [paropt, J_opt, exitflag, output] = fminsearch(@kurscrit, params, opt);
    
    % ВЫВОД РЕЗУЛЬТАТОВ
    fprintf('\n========== РЕЗУЛЬТАТЫ ОПТИМИЗАЦИИ ==========\n');
    fprintf('Оптимальные параметры:\n');
    fprintf('  t1 (время) = %.4f с\n', paropt(1));
    fprintf('  S2 (дистанция) = %.4f м\n', paropt(2));
    fprintf('\nОптимальное значение целевой функции: J = %.6f\n', J_opt);
    fprintf('Количество итераций: %d\n', output.iterations);
    fprintf('Количество вычислений функции: %d\n', output.funcCount);
    fprintf('Алгоритм: %s\n', output.algorithm);
    
    if exitflag == 1
        fprintf('Статус: Оптимизация успешно завершена\n');
    else
        fprintf('Статус: Оптимизация завершена по другому условию\n');
    end
    
    % Теперь запускаем симуляцию с оптимальными параметрами
    flagplot = 1;
    fprintf('\nЗапуск финальной симуляции с оптимальными параметрами...\n');
    J_final = kurscrit(paropt);
    fprintf('Значение целевой функции в финальной симуляции: J = %.6f\n', J_final);
    
    % ДИАПАЗОН ВОКРУГ ОПТИМАЛЬНЫХ ПАРАМЕТРОВ:
    t1_opt = paropt(1);
    S2_opt = paropt(2);
    
    time1 = (t1_opt-40):10:(t1_opt+40);    % ±40 вокруг оптимума
    sur2 = (S2_opt-400):100:(S2_opt+400);  % ±400 вокруг оптимума
    
    n_time1 = length(time1);
    n_sur2 = length(sur2);
    
    J1 = zeros(n_time1, n_sur2);
    
    flagplot = 0;  % Отключаем графику для ускорения
    fprintf('\nПостроение поверхности целевой функции...\n');
    for i = 1:n_time1
        for j = 1:n_sur2
            J1(i,j) = kurscrit([time1(i), sur2(j)]);
        end
        fprintf('Завершено %d/%d\n', i, n_time1);
    end
    flagplot = 1;  % Включаем обратно
    
    % Построение графика
    figure;
    mesh(time1, sur2, J1');
    hold on
    scatter3(t1_opt, S2_opt, J_opt, 100, 'r', 'filled', 'MarkerEdgeColor', 'k', 'LineWidth', 2);
    hold off
    xlabel('t1, c');
    ylabel('S2, м');
    zlabel('J (целевая функция)');
    title(sprintf('Поверхность целевой функции. Оптимум: J = %.4f', J_opt));
    grid on;
    
    % Дополнительный 2D график
    figure;
    contour(time1, sur2, J1', 20);
    hold on;
    plot(t1_opt, S2_opt, 'r*', 'MarkerSize', 15, 'LineWidth', 2);
    xlabel('t1, c');
    ylabel('S2, м');
    title('Линии уровня целевой функции с оптимальной точкой');
    colorbar;
    grid on;
    
    % Вывод сравнения начальных и конечных значений
    fprintf('\n========== СРАВНЕНИЕ ==========\n');
    J_initial = kurscrit(params);
    fprintf('Начальное значение J: %.6f\n', J_initial);
    fprintf('Оптимальное значение J: %.6f\n', J_opt);
    fprintf('Улучшение: %.2f%%\n', (J_initial - J_opt)/J_initial * 100);
    
else
    % Только симуляция без оптимизации
    flagplot = 1;
    J_current = kurscrit(params);
    fprintf('Значение целевой функции для начальных параметров: J = %.6f\n', J_current);
end