%% Run the algorithm once
clear;
tic;
p = tspGa('tspFittness');        % Set hyperparameters
output = tspGa('tspFittness',p); % Run with hyperparameters
endTime = toc;

% View Result
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
minDistance = tspDistance(output.best(:, end)');
disp(['Minimum distance: ' num2str(minDistance)])
disp(['Total time: ' num2str(endTime)])
