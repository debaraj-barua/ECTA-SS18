%% Run the algorithm once
clear;
tic;
p = nsga();        % Set hyperparameters
output = nsga(p);  % Run with hyperparameters

disp(['Execution time: ' num2str(toc)]);
