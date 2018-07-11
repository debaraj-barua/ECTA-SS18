function output = poleBalanceGa(nHidden,nInputs, p)
if nargin<3 
    p.nHidden       = nHidden;
    p.nInputs       = nInputs;    
    p.nOutputs      = 1;
    p.popSize       = 100;
    p.nGenes        = (p.nInputs+p.nOutputs)*p.nHidden;
    p.nNode         = p.nHidden+p.nInputs+p.nOutputs;
    p.maxGen        = 30;
    p.sp            = 2;
    p.crossProb     = 0.1;
    p.mutProb       = 0.1;
    p.elitePerc     = 0.1;
    output          = p; 
    return;
end

fitMax = nan(1,p.maxGen);         % Record the maximum fitness
fitMed = nan(1,p.maxGen);         % Record the median  fitness
best   = nan(p.nGenes, p.maxGen); % Record the best individual


for iGen = 1: p.maxGen  
    %% Initialize population
    % - Initialize a population of random individuals and evaluate them.
    if iGen == 1
        pop = -1 + 2*rand([p.popSize, p.nGenes]);
        fitness= getFitness(pop,p);
    end
   
    
    %% Evolutionary Operators    
    % Selection -- Returns [MX2] indices of parents
    parentIds = my_selection(fitness, p); % Returns indices of parents
    
    % Crossover -- Returns children of selected parents
    children  = my_crossover(pop, parentIds, p);
    
    % Mutation  -- Applies mutation to newly created children
    children  = my_mutation(children, p);
    
    % Elitism   -- Select best individual(s) to continue unchanged
    eliteIds  = my_elitism(fitness, p);
    
    % Create new population -- Combine new children and elite(s)
    newPop    = [pop(eliteIds,:); children];
    pop       = newPop(1:p.popSize,:);  % Keep population size constant
    
    % Evaluate new population
    fitness= getFitness(pop,p);
    
    % Data Gathering
    [fitMax(iGen), iBest] = max(fitness); % 1st output is the max value, 2nd the index of that max value
    fitMed(iGen)          = median(fitness);
    best(:,iGen)          = pop(iBest,:);
    disp("----")
    disp(iGen)
    disp( max(fitness))
end

output.fitMax   = fitMax;
output.fitMed   = fitMed;
output.best     = best;
end

