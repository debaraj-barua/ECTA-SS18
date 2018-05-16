function children  = my_crossover(pop, parentIds, p)

children = NaN(p.popSize, p.nGenes);
for index=1:p.popSize
    doCrossOver = rand(1) < p.crossProb;    % Determine whether to do cross over or not
    first_parent_index = parentIds(index,1);
    second_parent_index = parentIds(index,2);
    
    if(doCrossOver)
        crossOverPoint = randi(p.nGenes);    % Define cross over point in case of cross over
        
        
        
        parent1Genes = pop(first_parent_index,1:crossOverPoint);

        % Find the values in [1:nCities] that are NOT in parent1Genes
        missing = setdiff(1:p.nGenes,parent1Genes);
        
        % Get those missing values in parent2, in the same order ('stable') 
        parent2Genes = intersect( pop(second_parent_index,:) ,missing,'stable');
                
        children(index,:) = [parent1Genes parent2Genes];   % combine the two parts
    else
        children(index, :) = pop(first_parent_index, :);    % Take first parent in case of no cross over
    end
end

