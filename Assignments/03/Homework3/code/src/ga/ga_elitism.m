function eliteIds = ga_elitism(fitness, p)

[~,sorted_population_indices]= sort(fitness,'ascend');

% Take population with highest fitness
eliteIds = sorted_population_indices(1:ceil(p.popSize * p.elitePerc));   
