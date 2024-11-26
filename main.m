%
% Copyright (c) 2015, Mostapha Kalami Heris & Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "LICENSE" file for license terms.
%
% Project Code: YPEA102
% Project Title: Implementation of Particle Swarm Optimization in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Cite as:
% Mostapha Kalami Heris, Particle Swarm Optimization in MATLAB (URL: https://yarpiz.com/50/ypea102-particle-swarm-optimization), Yarpiz, 2015.
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

clc;
clear;
close all;


bestSolPso = NaN;
matrizCosto = [];
costos = [];
disp("PSO")
for i = 1:10
    disp(["Corrida " , i]);
    [bs, bc] = pso();
    disp(["Mejor costo ", bs.Cost]);
    costos(i) = bs.Cost;

    if (bs.Cost > bestSolPso || isnan(bestSolPso))
        matrizCosto = bc;
    end
end

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
fobj = @(x) -SumSquare(x);

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

NP = 50; % Tamaño de la población
lb = -5.12; % Límite inferior
ub = 5.12; % Límite superior
F = 0.8; % Factor de escala
CR = 0.9; % Probabilidad de recombinación

[mejores_valores, promedio, desviacion_estandar] = de(fobj, D, iteraciones, corridas, NP, lb, ub, F, CR);

disp('Resultados de las corridas:');
disp(mejores_valores');