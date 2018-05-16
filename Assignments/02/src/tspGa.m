function output = tsp_ga(task, p)
%------- Default Hyperparameters -------
if nargin<2     % > When called with only the task name, this function 
                %   only outputs the default hyperparameters. The function
                %   runs when it is given both a task and a hyperparameter
                %   set
    p.task      = task;          % > The task here is a string, which is 
                                 %   the function name.
    p.nGenes    = feval(p.task); % > feval evaluates a function. we have 
                                 %   programmed our fitness functions to 
                                 %   return the number of genes when no
                                 %   input arguments are given to make it
                                 %   easier to switch between tasks.
    p.maxGen    = 1000;
    p.popSize   = 50;
    p.sp        = 2;
    p.crossProb = 0.80;
    p.mutProb   = 0.99;
    p.elitePerc = 0.1;
    output      = p;             % Output default hyperparameters
    return
end
%------------- BEGIN CODE --------------
p.task      = task;
p.nGenes    = feval(p.task);

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
        pop = NaN(p.popSize, p.nGenes);
        for iPop = 1:p.popSize
            pop(iPop,:) = randperm(p.nGenes);
        end
        fitness     = feval(p.task, pop);        
    end

    % Data Gathering
    [fitMax(iGen), iBest] = min(fitness); % 1st output is the max value, 2nd the index of that max value
    fitMed(iGen)          = median(fitness);
    best(:,iGen)          = pop(iBest,:);
    
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
    fitness   = feval(p.task, pop);
end

output.fitMax   = fitMax;
output.fitMed   = fitMed;
output.best     = best;
%------------- END OF CODE --------------
