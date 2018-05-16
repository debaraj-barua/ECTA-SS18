function fitness = tspFittness(pop)

cityData = importdata('cities.csv');
nCities = size(cityData.data, 1);

% If this function is called with no arguments it returns the expected
% length of the genome.
if nargin == 0; fitness = nCities; return; end

% Otherwise it returns fitness
coords = cityData.data([1:nCities], [3 2])'; % <- switch to plot with north up after imagesc
distMat = squareform(pdist(coords')); % Precalculate Distance Matrix
fitness = NaN(size(pop,1), 1);

for i=1:size(pop,1)
    ind = pop(i,:);
    distance = distMat(ind(1), ind(end));
    for iCity = 2:size(pop,2)
        twoCityIndices= [ind(iCity-1), ind(iCity)]; % Indices of distance matrix
        distance = distance + distMat(twoCityIndices(1), twoCityIndices(2));
    end
    fitness(i,1) = distance;
end
