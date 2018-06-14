function children  = ga_crossover(pop, parentIds, p)

children = NaN(p.nGenes,p.popSize);
for index=1:p.popSize
    doCrossOver = rand(1) < p.crossProb;    % Determine whether to do cross over or not
    first_parent_index = parentIds(index,1);
    second_parent_index = parentIds(index,2);
    
    if(doCrossOver) 
        parent1Genes = pop(:,first_parent_index);        
        parent2Genes = pop(:,second_parent_index);
        
        children(:,index) = (parent1Genes + parent2Genes)/2; % combine the two parts
    else
        children(:,index) = pop(:, first_parent_index);    % Take first parent in case of no cross over
    end
end