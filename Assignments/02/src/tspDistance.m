function distance = tspDistance(ind)
    cityData = importdata('cities.csv');
    nCities = size(cityData.data, 1);
    coords = cityData.data([1:nCities], [3 2])'; % <- switch to plot with north up after imagesc
    
    distance = pdist( coords(:,ind([1 end]) )'  );
    for iCity = 2:nCities
        twoCityCoords = coords(:,ind([iCity-1:iCity]) );
        distance = distance + pdist( twoCityCoords'); % pDist expects columns to be cities so must transpose twoCityCoords
    end
end