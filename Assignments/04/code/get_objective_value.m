function output = get_objective_value(pop, p)
    output = nan(p.popSize, p.nGenes + p.nObj);
    
    for i= 1:size(pop,1)
        objective_values = feval(p.obj_function, pop(i,:), p);
        output(i, :) = [pop(i,:) objective_values];
    end
end
