function fitness = tspFittness(pop)
%hamletQuote - Returns fitness reward for matching hamlet quote
% Target quote:'to be or not to be'
% or as a genotype: [20,15,0,2,5,0,15,18,0,14,15,20,0,20,15,0,2,5]
%
% Syntax:  fitness = hamletQuote(genomes)
%
% Inputs:
%    genomes - [M X N] - M genomes of length N, ints between 0 and 26
%
% Outputs:
%    fitness - [M X 1] - Fitness values of each genome
%
% Example: 
%    pop = randi([0 26], [200 18]); % Create 200 individuals
%    fitness = hamletQuote(pop);    % Get their fitness
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: text2gene,  gene2text, hamletSoliloquy

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Feb 2018; Last revision: 20-Feb-2018

%------------- BEGIN CODE --------------
cityData = importdata('cities.csv');
nCities = size(cityData.data, 1);

% If this function is called with no arguments it returns the expected
% length of the genome.
if nargin == 0; fitness = nCities; return; end

% Otherwise it returns the number of matching genes in each individual
populatinSize = size(pop, 1);

coords = cityData.data([1:nCities], [3 2])'; % <- switch to plot with north up after imagesc

fitness = NaN(populatinSize, 1);
for i=1:populatinSize
    ind = pop(i,:);
    distance = pdist( coords(:,ind([1 end]) )'  );
    for iCity = 2:nCities
        twoCityCoords = coords(:,ind([iCity-1:iCity]) );
        distance = distance + pdist( twoCityCoords'); % pDist expects columns to be cities so must transpose twoCityCoords
    end
    fitness(i, 1) = distance;
end

end