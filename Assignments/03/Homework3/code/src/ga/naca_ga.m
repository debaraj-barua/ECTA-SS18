function output = naca_ga(task,nacaNum, p)
%------- Default Hyperparameters -------
if nargin<3     
    p.task      = task;
    p.nGenes    = 32;
    p.maxGen    = 500;
    p.popSize   = 100;
    p.sp        = 3;
    p.crossProb = 0.8;
    p.mutProb   = 1/p.nGenes;
    p.elitePerc = 0.1;
    
    % NACA Parameters
    p.numEvalPts = 256;
    paramArray =  [[0, 0, 1, 2];[5, 5, 2, 2]; [9, 7, 3, 5]];
    p.nacafoil = create_naca(paramArray(nacaNum,:),p.numEvalPts);
    
    output      = p;             % Output default hyperparameters
    return
end
%------------- BEGIN CODE --------------
% Data recording
% - You will use this data to visualize your current run and compare across
% multiple runs. Though it is not required, we initialize the matrices
% which will hold the run data.
fitMax = nan(1,p.maxGen);         % Record the maximum fitness
fitMed = nan(1,p.maxGen);         % Record the median  fitness
best   = nan(p.nGenes, p.maxGen); % Record the best individual

%% Generation Loop
for iGen = 1:p.maxGen    
    %% Initialize population
    % - Initialize a population of random individuals and evaluate them.
    if iGen == 1
        pop = rand(p.popSize,p.nGenes)-0.5;
        fitness = feval(p.task, pop,p);        
    end
    
    % Selection -- Returns [MX2] indices of parents
    parentIds = ga_selection(fitness, p); % Returns indices of parents
    
    % Crossover -- Returns children of selected parents
    children  = ga_crossover(pop, parentIds, p);
    
    % Mutation  -- Applies mutation to newly created children
    children  = ga_mutation(children, p);
    
    % Elitism   -- Select best individual(s) to continue unchanged
    eliteIds  = ga_elitism(fitness, p);
    
    % Create new population -- Combine new children and elite(s)
    newPop    = [pop(eliteIds,:); children];
    pop       = newPop(1:p.popSize,:);  % Keep population size constant
    
    % Evaluate new population
    fitness   = feval(p.task, pop,p);
    
    % Data Gathering
    [fitMax(iGen), iBest] = min(fitness); % 1st output is the max value, 2nd the index of that max value    
    fitMed(iGen)          = median(fitness);
    best(:,iGen)          = pop(iBest,:);
end

output.fitMax   = fitMax;
output.fitMed   = fitMed;
output.best     = best;
%------------- END OF CODE --------------
