function children  = my_crossover(pop, parentIds, p)

children = NaN(p.popSize, p.nGenes);
for index=1:p.popSize
    doCrossOver = rand(1) < p.crossProb;    % Determine whether to do cross over or not
    first_parent_index = parentIds(index,1);
    second_parent_index = parentIds(index,2);
    
    if(doCrossOver)
        crossOverPoint = randi(p.nGenes-1);   
        parent1Genes = pop(first_parent_index,1:crossOverPoint);
        
        parent2Genes = pop(second_parent_index,1+crossOverPoint:p.nGenes);
                
        children(index,:) = [parent1Genes parent2Genes];   % combine the two parts
    else
        children(index, :) = pop(first_parent_index, :);    % Take first parent in case of no cross over
    end
end