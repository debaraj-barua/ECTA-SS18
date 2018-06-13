%% GA
clc;clear;
Nacanum = 3;
p = naca_ga('naca_fitness',Nacanum);
tic
disp('start')
output = naca_ga('naca_fitness',Nacanum,p);
toc
%% save
save op/ga_p.mat p
save op/ga_output.mat output
%% Visualization of GA
bestIndividual = output.best(:,p.maxGen)';
%%
figure(1)
visualize(bestIndividual, p);
figure(2)
fitPlot(output.fitMax, output.fitMed);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ES
clc;clear;
Nacanum = 3;
p = naca_es('naca_fitness',Nacanum);
%% 
tic
disp('start')
output = naca_es('naca_fitness',Nacanum,p);
toc
%% save
save op/es_p.mat p
save op/es_output.mat output
%% Visualization of ES
bestIndividual = output.best(:,output.convergedGen)';
%%
figure(1)
visualize(bestIndividual, p);
figure(2)
fitPlot(output.fitMax, output.fitMed);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CMAES
%
clc;clear;
Nacanum = 3;
p = naca_cmaes('naca_fitness',Nacanum);
%% 
tic
disp('start')
output = naca_cmaes('naca_fitness',Nacanum,p);
toc
%% save
save op/cmaes_p.mat p
save op/cmaes_output.mat output
%% Visualization of CMAES
bestIndividual = output.best(:,output.convergedGen)';
%%
figure(1)
visualize(bestIndividual, p);
figure(2)
fitPlot(output.fitMax, output.fitMed);

%% CMAES-EP
clc;clear;
Nacanum = 3;
p = naca_cmaes_ep('naca_fitness',Nacanum);
%% 
tic
disp('start')
output = naca_cmaes_ep('naca_fitness',Nacanum,p);
toc
%% save
save op/cmaes_p.mat p
save op/cmaes_output.mat output
%% Visualization of CMAES-EP
bestIndividual = output.best(:,output.convergedGen)';
%%
figure(1)
visualize(bestIndividual, p);
figure(2)
fitPlot(output.fitMax, output.fitMed)