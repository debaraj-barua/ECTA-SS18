function eliteIds = my_elitism(fitness, p)

[~,sorted_population_indices]= sort(fitness,'descend');

% Take population with highest fitness
eliteIds = sorted_population_indices(1:ceil(p.popSize * p.elitePerc));   
