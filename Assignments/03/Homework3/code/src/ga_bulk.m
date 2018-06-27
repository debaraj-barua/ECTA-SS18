%% 
%
clc;clear;
Nacanum = 3;
maxGen =200;
numOfRuns = 20;
%%
AA = 1;
fitMed = zeros(maxGen,1);        

fitMax_run = nan(numOfRuns,maxGen);
tic
parfor i = 1:numOfRuns
    p = naca_ga('naca_fitness',Nacanum);
    output = naca_ga('naca_fitness',Nacanum,p);
    fitMax_run(i,:) = output.fitMax;
end
toc
%%
fitMed(:,1)=median(fitMax_run);
plot([fitMed]', 'LineWidth',3);
legend( 'Minimum Fitness',  'Location', 'NorthEast');
grid on; xlabel('Generations'); ylabel('Fitness'); 
title('Median values over 20 runs with 200 generataion and 100 population size each of a GA for the shape matching problem.'); 
set(gca,'YScale', 'log', 'Fontsize', 24);

