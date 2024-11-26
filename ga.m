function [promedio, desviacion_std, evolucion_mejor] = ga(func_objetivo, D, iteraciones, corridas)
    % Parámetros del algoritmo genético
    pop_size = 100; 
    mutation_rate = 0.1; 

    mejores_valores = zeros(corridas, 1);
    evolucion_mejor = zeros(iteraciones, 1); 

    for corrida = 1:corridas
        poblacion = rand(pop_size, D) * 10 - 5; % Inicializar población
        fitness = arrayfun(@(i) func_objetivo(poblacion(i, :)), 1:pop_size); % Calcular fitness

        for iter = 1:iteraciones
            % Selección por torneo
            indices = randi(pop_size, [pop_size, 2]); 
            padres = zeros(pop_size, 1); 
            for i = 1:pop_size
                competidores = indices(i, :);
                if fitness(competidores(1)) > fitness(competidores(2)) % Selección del mejor
                    padres(i) = competidores(1);
                else
                    padres(i) = competidores(2);
                end
            end

            % Crossover (cruce)
            hijos = poblacion(padres, :);
            for i = 1:2:pop_size-1
                if rand < 0.8 
                    punto = randi(D-1);
                    temp = hijos(i, punto+1:end);
                    hijos(i, punto+1:end) = hijos(i+1, punto+1:end);
                    hijos(i+1, punto+1:end) = temp;
                end
            end

            % Mutación
            for i = 1:pop_size
                if rand < mutation_rate
                    hijo = hijos(i, :);
                    hijo(randi(D)) = hijo(randi(D)) + randn * 0.5; % Mutación gaussiana
                    hijos(i, :) = hijo;
                end
            end

            % Actualizar población y fitness
            poblacion = hijos;
            fitness = arrayfun(@(i) func_objetivo(poblacion(i, :)), 1:pop_size);

            % Registrar el mejor fitness de esta iteración
            [mejor_fitness, ~] = max(fitness); % Ahora buscamos el máximo
            if corrida == 1 
                evolucion_mejor(iter) = mejor_fitness; 
            end
        end

        mejores_valores(corrida) = max(fitness); % Guardar el mejor fitness de esta corrida
    end

    promedio = mean(mejores_valores);
    desviacion_std = std(mejores_valores);
end
