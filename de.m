function [mejores_valores, promedio, desviacion_estandar] = de(fobj, D, iteraciones, corridas, NP, lb, ub, F, CR)

    mejores_valores = zeros(corridas, 1);

    for run = 1:corridas
        poblacion = lb + (ub - lb) * rand(NP, D);
        fitness = zeros(NP, 1); 
        for i = 1:NP
            fitness(i) = fobj(poblacion(i, :)); 
        end
        
        [mejor_valor, idx_mejor] = max(fitness); 
        
        if run == 1
            evolucion = zeros(iteraciones, 1); 
        end
        
        for iter = 1:iteraciones
            nueva_poblacion = poblacion;
            for i = 1:NP
                % Seleccionar tres índices distintos
                indices = randperm(NP, 3);
                while any(indices == i)
                    indices = randperm(NP, 3);
                end
                
                v = poblacion(indices(1), :) + F * (poblacion(indices(2), :) - poblacion(indices(3), :));
                v = min(max(v, lb), ub);
                
                u = poblacion(i, :);
                for j = 1:D
                    if rand <= CR || j == randi(D)
                        u(j) = v(j);
                    end
                end
                
                nuevo_fitness = fobj(u); 
                if nuevo_fitness > fitness(i) 
                    nueva_poblacion(i, :) = u;
                    fitness(i) = nuevo_fitness;
                end
            end
            poblacion = nueva_poblacion;
            [mejor_valor, idx_mejor] = max(fitness); 
            
            if run == 1
                evolucion(iter) = mejor_valor; 
            end
        end
        mejores_valores(run) = mejor_valor;
    end

    promedio = mean(mejores_valores);
    desviacion_estandar = std(mejores_valores);

    figure;
    semilogy(1:iteraciones, evolucion, 'LineWidth', 2);
    xlabel('Iteraciones');
    ylabel('Mejor Valor de la Función Objetivo');
    title('Evolución del Valor de la Función Objetivo (Maximización)');
    grid on;

    fprintf('Promedio del mejor valor: %.4f\n', promedio);
    fprintf('Desviación estándar: %.4f\n', desviacion_estandar);
end
