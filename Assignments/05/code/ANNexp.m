%% 2 Pole with Velocity
clear;clc;
nInputs = 6;
nHidden = 2;
%%
p = poleBalanceGa(nHidden,nInputs);
%%
output2Pol = poleBalanceGa(nHidden,nInputs, p);

%% #########################################################################
%% 1 Pole with Velocity
clear;clc;
nInputs = 4;
nHidden = 2;
%%
p = poleBalanceGa(nHidden,nInputs);
%%
output1Pol = poleBalanceGa(nHidden,nInputs, p);
%% #########################################################################
%% INCOMPLETE
%% 2 Pole w/o Velocity
clear;clc;
nInputs = 3;
nHidden = 2;
%%
p = poleBalanceGa(nHidden,nInputs);
%%
output2PolNv = poleBalanceGa(nHidden,nInputs, p);
%% Show plot for the fitness
fig = figure(1);
plot([output.fitMax; output.fitMed]','LineWidth',3);
legend('Max Fitness','Median Fitness');
xlabel('Generations'); ylabel('Fitness'); set(gca,'FontSize',16);
title('Performance')
