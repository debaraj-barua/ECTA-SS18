
%% Run twenty times
% GA
clear;clc;
Nacanum = 1;
p = naca_ga('naca_fitness',Nacanum);
disp('1')
parfor iExp = 1:2
   out = naca_ga('naca_fitness',Nacanum,p);
   output(iExp) = out;
   fitness(iExp,:) = out.fitMax;
end
ga_foil1 = fitness;
save('real_valued_GA_foil1.mat', 'ga_foil1');

disp('2')
clear;
Nacanum = 2;
p = naca_ga('naca_fitness',Nacanum);
parfor iExp = 1:2
   out = naca_ga('naca_fitness',Nacanum,p);
   output(iExp) = out;
   fitness(iExp,:) = out.fitMax;
end

ga_foil2 = fitness;
save('real_valued_GA_foil2.mat', 'ga_foil2');

disp('3')
clear;
Nacanum = 3;
p = naca_ga('naca_fitness',Nacanum);
parfor iExp = 1:2
   out = naca_ga('naca_fitness',Nacanum,p);
   output(iExp) = out;
   fitness(iExp,:) = out.fitMax;
end

ga_foil3 = fitness;
save('real_valued_GA_foil3.mat', 'ga_foil3');
%%
% ES
clear;clc;
Nacanum = 1;
p = naca_es('naca_fitness',Nacanum);
disp('1')
parfor iExp = 1:2
   out = naca_es('naca_fitness',Nacanum,p);
   output(iExp) = out;
   fitness(iExp,:) = out.fitMax;
end

es_foil1 = fitness;
save('real_valued_ES_foil1.mat', 'es_foil1');

clear;clc;
Nacanum = 2;
p = naca_es('naca_fitness',Nacanum);
disp('2')
parfor iExp = 1:2
   out = naca_es('naca_fitness',Nacanum,p);
   output(iExp) = out;
   fitness(iExp,:) = out.fitMax;
end

es_foil2 = fitness;
save('real_valued_ES_foil2.mat', 'es_foil2');

clear;clc;
Nacanum = 3;
p = naca_es('naca_fitness',Nacanum);
disp('3')
parfor iExp = 1:2
   out = naca_es('naca_fitness',Nacanum,p);
   output(iExp) = out;
   fitness(iExp,:) = out.fitMax;
end

es_foil3 = fitness;
save('real_valued_ES_foil3.mat', 'es_foil3');
%%
% CMAES
clear;clc;
Nacanum = 1;
p = naca_cmaes('naca_fitness',Nacanum);
disp('1')
parfor iExp = 1:2
   out = naca_cmaes('naca_fitness',Nacanum,p);
   output(iExp) = out;
   fitness(iExp,:) = out.fitMax;
end

cmaes_foil1 = fitness;
save('real_valued_CMAES_foil1.mat', 'cmaes_foil1');

clear;clc;
Nacanum = 2;
p = naca_cmaes('naca_fitness',Nacanum);
disp('2')
parfor iExp = 1:2
   out = naca_cmaes('naca_fitness',Nacanum,p);
   output(iExp) = out;
   fitness(iExp,:) = out.fitMax;
end

cmaes_foil2 = fitness;
save('real_valued_CMAES_foil2.mat', 'cmaes_foil2');

clear;clc;
Nacanum = 3;
p = naca_cmaes('naca_fitness',Nacanum);
disp('3')
parfor iExp = 1:2
   out = naca_cmaes('naca_fitness',Nacanum,p);
   output(iExp) = out;
   fitness(iExp,:) = out.fitMax;
end

cmaes_foil3 = fitness;
save('real_valued_CMAES_foil3.mat', 'cmaes_foil3');
%%
% CMAES -EP
clear;clc;
Nacanum = 1;
disp('1')
p = naca_cmaes_ep('naca_fitness',Nacanum);
parfor iExp = 1:2
   out = naca_cmaes_ep('naca_fitness',Nacanum,p);
   output(iExp) = out;
   fitness(iExp,:) = out.fitMax;
end

cmaesep_foil1 = fitness;
save('real_valued_CMAES_EP_foil1.mat', 'cmaesep_foil1');

clear;
Nacanum = 2;
p = naca_cmaes_ep('naca_fitness',Nacanum);
disp('2')
parfor iExp = 1:2
   out = naca_cmaes_ep('naca_fitness',Nacanum,p);
   output(iExp) = out;
   fitness(iExp,:) = out.fitMax;
end

cmaesep_foil2 = fitness;
save('real_valued_CMAES_EP_foil2.mat', 'cmaesep_foil2');

clear;
Nacanum = 3;
p = naca_cmaes_ep('naca_fitness',Nacanum);
disp('3')
parfor iExp = 1:2
   out = naca_cmaes_ep('naca_fitness',Nacanum,p);
   output(iExp) = out;
   fitness(iExp,:) = out.fitMax;
end

cmaesep_foil3 = fitness;
save('real_valued_CMAES_EP_foil3.mat', 'cmaesep_foil3');
