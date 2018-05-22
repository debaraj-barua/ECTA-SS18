%% Load Data
cityData = importdata('cities.csv');
nCities = size(cityData.data, 1);
coords = cityData.data([1:nCities], [3 2])'; % <- switch to plot with north up after imagesc
distMat = squareform(pdist(coords')); % Precalculate Distance Matrix
save distMat.mat distMat

%% Run the algorithm once
tic;
p = tspGa('tspFittness');        % Set hyperparameters
output = tspGa('tspFittness',p); % Run with hyperparameters
endTime = toc;

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
load('output_c_01_m_100.mat');
load('output_c_10_m_100.mat');
load('output_c_99_m_100.mat');
load('output_c_100_m_100.mat');


plot([output_c_01_m_100; output_c_10_m_100; output_c_99_m_100; output_c_100_m_100]','LineWidth',1);
legend('Crossover 1%','Crossover 10%', 'Crossover 99%', 'Crossover 100%', 'Location','NorthEast');
xlabel('Generation'); ylabel('Distance'); set(gca,'FontSize',16);
title('Minimum distance for different crossover rate and 100% mutation rate')

%% Plot different mutation rates
load('output_c_100_m_01.mat');
load('output_c_100_m_10.mat');
load('output_c_100_m_99.mat');
load('output_c_100_m_100.mat');


plot([output_c_100_m_01; output_c_100_m_10; output_c_100_m_99; output_c_100_m_100]','LineWidth',1);
legend('Mutation 1%','Mutation 10%', 'Mutation 99%', 'Mutation 100%', 'Location','NorthEast');
xlabel('Generation'); ylabel('Distance'); set(gca,'FontSize',16);
title('Minimum distance for different mutation rate and 100% crossover rate')

%% Save result
result = NaN(30, 1000);
for c = 1:size(result, 1)
    p = tspGa('tspFittness');        % Set hyperparameters
    output = tspGa('tspFittness',p); % Run with hyperparameters
    
    result(c,:) = output.fitMax;
    disp(['Current index: ' num2str(c)])
end

output_c_100_m_99 = median(result);
save('output_c_100_m_99.mat','output_c_100_m_99');

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
load('output_30_c_99_m_99.mat');

median_value = median(output_30_c_99_m_99);
disp(['Median for 30 repeatation is: ' num2str(median_value)]);

hist(output_30_c_99_m_99, 25);
xlabel('Minimum distance'); ylabel('Frequency'); set(gca,'FontSize',16);
title('Minimum distance for 30 repeatation with 99% crossover and mutation')

%% Calculate average distance
load('output_c_01_m_100.mat');
load('output_c_10_m_100.mat');
load('output_c_99_m_100.mat');

load('output_c_100_m_01.mat');
load('output_c_100_m_10.mat');
load('output_c_100_m_99.mat');

load('output_c_100_m_100.mat');

total = output_c_01_m_100(end) + output_c_10_m_100(end) + output_c_99_m_100(end) + output_c_100_m_01(end) + output_c_100_m_10(end) + output_c_100_m_99(end) + output_c_100_m_100(end);

disp(['Average distance is: ' num2str(total / 7.0)]);


