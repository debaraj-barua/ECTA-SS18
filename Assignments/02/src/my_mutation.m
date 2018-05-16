function children  = my_mutation(children, p)
%Mutation - Make random changes in the child population
% - Point mutation:
%   1) Determine which genes will be mutated -- all have an equal chance
%   2) Change every gene chosen for mutation to another random value
%
% Syntax:  children  = my_mutation(children, p);
%
% Inputs:
%    children   - [M X N] - Population of M individuals
%    p          - _struct - Hyperparameter struct
%     .mutProb              - Chance per gene of performing mutation
%
% Outputs:
%    children   - [M X N] - New population of M individuals
%
% See also: selection, crossover, elitism, monkeyGa

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Feb 2018; Last revision: 20-Feb-2018

%------------- BEGIN CODE --------------

%% POINT MUTATION SOLUTION
for childIndex=1:p.popSize   
    % Determines whether do mutation or not
    doMutation = rand(1) < p.mutProb;   
    if doMutation
        genes = children(childIndex, :);
        
        index_1 = randi(p.nGenes);
        index_2 = randi(p.nGenes);
        
        start_index = min(index_1, index_2);
        end_index = max(index_1, index_2);
        
        first_part = genes(1 : start_index);
        second_part = genes(start_index+1 : end_index);
        third_part = genes(end_index+1 : end);
        
        genes = [third_part first_part second_part];
        
        children(childIndex, :) = genes;
    end
end
%------------- END OF CODE --------------