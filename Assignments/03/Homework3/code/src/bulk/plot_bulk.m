%% Plot
clear;

% load GA data
load('real_valued_GA_foil1.mat');
load('real_valued_GA_foil2.mat');
load('real_valued_GA_foil3.mat');

min_ga = min([min(ga_foil1); min(ga_foil2); min(ga_foil3)]);

% load ES data
load('real_valued_ES_foil1.mat');
load('real_valued_ES_foil2.mat');
load('real_valued_ES_foil3.mat');

min_es = min([min(es_foil1); min(es_foil2); min(es_foil3)]);

% load CMAES data
load('real_valued_CMAES_foil1.mat');
load('real_valued_CMAES_foil2.mat');
load('real_valued_CMAES_foil3.mat');

min_cmaes = min([min(cmaes_foil1); min(cmaes_foil2); min(cmaes_foil3)]);

% load CMAES EP data
load('real_valued_CMAES_EP_foil1.mat');
load('real_valued_CMAES_EP_foil2.mat');
load('real_valued_CMAES_EP_foil3.mat');
%%
min_cmaes_ep = min([min(cmaesep_foil1); min(cmaesep_foil2); min(cmaesep_foil2)]);

% step sizes
step_size_ga = 0:100:20000;
step_size_ga = step_size_ga(2:201);

step_size_es = 0:10:20000;
step_size_es = step_size_es(2:2001);

step_size_cmaes = 0:10:20000;
step_size_cmaes = step_size_cmaes(2:2001);

step_size_cmaesep = 0:50:20000;
step_size_cmaesep = step_size_cmaesep(2:401);

% View Result
hold on;
plot(step_size_ga, min_ga,'LineWidth',1);

plot(step_size_es, min_es,'LineWidth',1);

plot(step_size_cmaes, min_cmaes,'LineWidth',1);

plot(step_size_cmaesep, min_cmaes_ep,'LineWidth',1);

legend('GA','ES', 'CMAES','CMAES EP', 'Location','NorthEast');
xlabel('Generations'); ylabel('Fitness'); set(gca,'FontSize',16); set(gca,'YScale','log')
title('Performance on ShapeMatching over 20 runs using 20,000 evaluations');
hold off;