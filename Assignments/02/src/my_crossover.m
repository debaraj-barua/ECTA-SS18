function children  = my_crossover(pop, parentIds, p)
%Crossover - Creates child solutions by combining genes of parents
% - Single Point Crossover:
%   1) For each set of parents:
%   2) Determine whether or not to perform crossover (p.xoverChance)
%   3) If not, take first parent as child
%   4) If yes, choose random point along genome and:
%   5) Create child from genes behind point from parent A and in front of
%   that point from parent B
%
% Syntax:  children  = crossover(pop, parentIds, p)
%
% Inputs:
%    pop        - [M X N] - Population of M individuals
%    parentIds  - [M X 2] - Parent pair indices
%    p          - _struct - Hyperparameter struct
%     .crossProb            - Chance of performing crossover
%
% Outputs:
%    children   - [M X N] - New population of M individuals
%
% See also: selection, mutation, elitism, monkeyGa

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Feb 2018; Last revision: 20-Feb-2018

%------------- BEGIN CODE --------------

%% ONE POINT CROSSOVER SOLUTION
children = NaN(p.popSize, p.nGenes);
for index=1:p.popSize
    % Determine whether to do cross over or not
    doCrossOver = rand(1) < p.crossProb;
    
    if(doCrossOver)
        % Define cross over point
        crossOverPoint = randi(p.nGenes); 
        
        first_parent_index = parentIds(index,1);
         % Take first part from the first parent
        first_part = pop(first_parent_index,1:crossOverPoint);
        
        second_parent_index = parentIds(index,2);
        % Find genes not present in first part
        missing_genes = setdiff(1:p.nGenes,first_part);
        % Get the remaining genes from second parent
        second_part = intersect( pop(second_parent_index,:) ,missing_genes,'stable');
        
        % combine the two parts
        children(index,:) = [first_part second_part];
    else
        % Take first parent in case of no cross over
        children(index, :) = pop(parentIds(index,1), :);
    end
end
%------------- END OF CODE -------------