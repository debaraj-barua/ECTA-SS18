%% Run the algorithm once
clear;
p = tspGa('tspFittness');        % Set hyperparameters
output = tspGa('tspFittness',p); % Run with hyperparameters

% View Result
cityData = importdata('cities.csv');
nCities = size(cityData.data, 1);
coords = cityData.data([1:nCities], [3 2])'; % <- switch to plot with north up after imagesc

% plotTsp(output.best(:,end)', coords)

plot([output.fitMax; output.fitMed]','LineWidth',3);
legend('Min Distance','Median Distance','Location','NorthWest');
xlabel('Generations'); ylabel('Distance'); set(gca,'FontSize',16);
title('Performance on TSP Task')