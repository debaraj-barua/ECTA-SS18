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

%% Plot different crossover rates
load('c_01_m_99.mat');
load('c_10_m_99.mat');
load('c_50_m_99.mat');
load('c_99_m_99.mat');


plot([c_01_m_99.fitMax; c_10_m_99.fitMax; c_50_m_99.fitMax; c_99_m_99.fitMax]','LineWidth',3);
legend('Crossover 1%','Crossover 10%', 'Crossover 50%', 'Crossover 99%', 'Location','NorthEast');
xlabel('Generation'); ylabel('Distance'); set(gca,'FontSize',16);
title('Minimum distance for different crossover rate and 80% mutation rate')

%% Plot different mutation rates
load('m_01_c_99.mat');
load('m_10_c_99.mat');
load('m_50_c_99.mat');
load('m_99_c_99.mat');


plot([m_01_c_99.fitMax; m_10_c_99.fitMax; m_50_c_99.fitMax; m_99_c_99.fitMax]','LineWidth',3);
legend('Mutation 1%','Mutation 10%', 'Mutation 50%', 'Mutation 99%', 'Location','NorthEast');
xlabel('Generation'); ylabel('Distance'); set(gca,'FontSize',16);
title('Minimum distance for different mutation rate and 80% crossover rate')

%% Save result
mc_50_99 = output;
save('mc_50_99.mat','mc_50_99');

%% Repeat 30 times and record distance
min_distance = NaN(1,30);
for i=1:30
    disp(['Run: ' num2str(i)])
    
    p = tspGa('tspFittness');        % Set hyperparameters
    output = tspGa('tspFittness',p); % Run with hyperparameters
    
    distance = tspDistance(output.best(:, end)');
    min_distance(i) = distance;

end

%% Calculate and plot distance for 30 runs
load('mc_30_99_99.mat');

median_value = median(mc_30_99_99);
disp(['Median for 30 repeatation is: ' num2str(median_value)]);

