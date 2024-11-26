clc;
clear;
close all;


bestSolPso = NaN;
matrizCosto = [];
costos = [];
disp("PSO")
for i = 1:10
    [bs, bc] = pso();
    costos(i) = bs.Cost;

    if (bs.Cost > bestSolPso || isnan(bestSolPso))
        matrizCosto = bc;
    end
end

disp("Resultados obtenidos:");
disp(costos);

promedio = mean(costos);
disp(['El promedio es: ', num2str(promedio)]);

desviacion = std(costos);
disp(['La desviación estándar es: ', num2str(desviacion)]);

figure;
%plot(BestCost, 'LineWidth', 2);
semilogy(matrizCosto, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;

disp([newline,'GA']);
% Definimos la funcion objetivo
fobj = @(x) -Matya(x);

% Parámetros ga
D = 2; % Dimensiones
iteraciones = 500; % Iteraciones
corridas = 10; % Corridas

% Llamar al algoritmo genético
[promedio, desviacion, evolucion] = ga(fobj, D, iteraciones, corridas);

% Graficar ga
figure;
plot(1:iteraciones, evolucion, 'LineWidth', 2);
xlabel('Iteraciones');
ylabel('Valor de la Función Objetivo');
title('Evolución del Mejor Valor');
grid on;

% Mostrar resultados ga
fprintf('Promedio: %.4f, Desviación Estándar: %.4f\n', promedio, desviacion);

disp([newline,'DE']);

NP = 100; % Tamaño de la población
lb = -10; % Límite inferior
ub = 10; % Límite superior
F = 0.8; % Factor de escala
CR = 0.9; % Probabilidad de recombinación

[mejores_valores, promedio, desviacion_estandar] = de(fobj, D, iteraciones, corridas, NP, lb, ub, F, CR);

disp('Resultados de las corridas:');
disp(mejores_valores');