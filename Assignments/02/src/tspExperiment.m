%% Set Hyperparameters
clear;
p = tspGa('tspFittness'); 
%% Run once
output = tspGa('tspFittness',p);

%% View Result
cityData = importdata('cities.csv');
nCities = size(cityData.data, 1);
coords = cityData.data([1:nCities], [3 2])'; % <- switch to plot with north up after imagesc

%% Show plot for the fitness
plot([output.fitMax; output.fitMed]','LineWidth',3);
legend('Min Distance','Median Distance','Location','NorthWest');
xlabel('Generations'); ylabel('Distance'); set(gca,'FontSize',16);
title('Performance on TSP Task')

%% Plot in map
plotTsp(output.best(:,end)', coords)

%% Get the best distance
coords = cityData.data([1:nCities], [3 2])'; % <- switch to plot with north up after imagesc
distMat = squareform(pdist(coords')); % Precalculate Distance Matrix
ind = output.best(:, end);
minDistance = distMat(ind(1), ind(end));
for iCity = 2:p.popSize
    twoCityIndices= [ind(iCity-1), ind(iCity)]; % Indices of distance matrix
    minDistance = minDistance + distMat(twoCityIndices(1), twoCityIndices(2));
end

disp(['Minimum distance: ' num2str(minDistance)])
