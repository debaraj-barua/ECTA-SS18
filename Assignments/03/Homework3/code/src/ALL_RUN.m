%% Run Experiment with GA
clear;clc;
Nacanum = 3;
p = naca_ga('naca_fitness',Nacanum);
output = naca_ga('naca_fitness',Nacanum,p);
% view
bestIndividual = output.best(:,output.convergedGen)';
figure(1)
visualize(bestIndividual, p);
figure(2)
fitPlot(output.fitMax, output.fitMed);

%% Run Experiment with ES
clear;
Nacanum = 3;
p = naca_es('naca_fitness',Nacanum);
output = naca_es('naca_fitness',Nacanum,p);
% view
bestIndividual = output.best(:,output.convergedGen)';
figure(1)
visualize(bestIndividual, p);
figure(2)
fitPlot(output.fitMax, output.fitMed);

%% Run Experiment with CMAES
clear;
Nacanum = 3;
p = naca_cmaes('naca_fitness',Nacanum);
output = naca_cmaes('naca_fitness',Nacanum,p);
% view
bestIndividual = output.best(:,output.convergedGen)';
figure(1)
visualize(bestIndividual, p);
figure(2)
fitPlot(output.fitMax, output.fitMed);

%% Run Experiment with CMAES EP
clear;
Nacanum = 3;
p = naca_cmaes_ep('naca_fitness',Nacanum);
output = naca_cmaes_ep('naca_fitness',Nacanum,p);
% view
bestIndividual = output.best(:,output.convergedGen)';
figure(1)
visualize(bestIndividual, p);
figure(2)
fitPlot(output.fitMax, output.fitMed);
