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

%% No mutation happening, can you do better?
children = children; 

%% POINT MUTATION SOLUTION
for childIndex=1:p.popSize
    genes = children(childIndex, :);
    
    doMutationFlag = rand(1, p.nGenes) < p.mutProb;
    doMutationInverseFlag = ~doMutationFlag;
    
    genes = genes .* doMutationInverseFlag;  % Set 0 for the genes to change
    newGenes = randi([0,27],[1,p.nGenes]) .* doMutationFlag; % Set 0 for the genes not to change
    genes = genes + newGenes; % Combine the original genes with new values
    
    children(childIndex, :) = genes;
end
%------------- END OF CODE --------------