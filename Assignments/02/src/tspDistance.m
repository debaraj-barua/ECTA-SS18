function distance = tspDistance(ind)
    %cityData = importdata('cities.csv');
    %nCities = size(cityData.data, 1);
    %coords = cityData.data([1:nCities], [3 2])'; % <- switch to plot with north up after imagesc
    
    %distMat = squareform(pdist(coords')); % Precalculate Distance Matrix
    load('distMat.mat');
    distance = distMat(ind(1), ind(end));
    for iCity = 2:size(ind, 2)
        twoCityIndices= [ind(iCity-1), ind(iCity)]; % Indices of distance matrix
        distance = distance + distMat(twoCityIndices(1), twoCityIndices(2));
    end
end