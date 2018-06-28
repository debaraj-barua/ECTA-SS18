function output = nsga(p)
    if nargin<1
        p.nObj         = 3;
        p.obj_function = 'objective3';
        p.nGenes       = 20;
        p.maxGen       = 200;
        p.popSize      = 200;
        p.sp           = 2;
        p.crossProb    = 0.8;
        p.mutProb      = 1/p.nGenes;
        p.elitePerc    = 0.1;
        output         = p;             % Output default hyperparameters
        return
end
%------------- BEGIN CODE --------------

% Initialize population
pop = randi([0 1], [p.popSize, p.nGenes]); % (range, matrix dimensions)
pop = get_objective_value(pop, p);

pop = non_domination_sort(pop, p);

%% Generation Loop
for iGen = 1:p.maxGen
    %% Evolutionary Operators  
    % Selection -- Returns [MX2] indices of parents
    parentIds = selection(pop(:, p.nGenes + p.nObj + 1: end), p); % Returns indices of parents
    
    % Crossover -- Returns children of selected parents
    current_pop = pop(:,:); % used for plotting 
    
    pop = pop(:, 1:p.nGenes);
    children  = crossover(pop, parentIds, p);
    
    % Mutation  -- Applies mutation to newly created children
    children  = mutation(children, p);
    
    [parent_pop,~] = size(pop);
    [children_pop,~] = size(children);

    combined(1:parent_pop,:) = pop;
    combined(parent_pop + 1 : parent_pop + children_pop,1 : p.nGenes) = ...
        children;
    
    pop = get_objective_value(combined, p);
    pop = non_domination_sort(pop, p);

    pop = get_unique(pop, p);
    next_pop_size = min(p.popSize, size(pop,1));
    pop = pop(1:next_pop_size, :);
    
    %% Plot Population Progress
    if iGen == 1
        set(gcf, 'Position', get(0, 'Screensize'));
    end
    
    marker_colors = nan(size(current_pop,1), 3);
   
    for i = 1: size(current_pop,1)
        if contains_ind(pop, current_pop(i,:), p)
            marker_colors(i,:) = [0 1 0];
        else
            marker_colors(i,:) = [1 0 0];
        end
    end
    
    displayFronts(current_pop(:, p.nGenes + p.nObj + 1),...
        current_pop(:, p.nGenes + 1: p.nGenes + p.nObj), current_pop(:, 1:p.nGenes),...
        marker_colors);

    if iGen == 1
        gif('plot.gif', 'DelayTime', 10.0/p.maxGen, 'frame',gcf);
    end
    gif
end
output = pop;
%------------- END OF CODE --------------