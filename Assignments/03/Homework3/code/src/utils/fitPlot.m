function fitPlot (fitMax, fitMed)

plot([fitMax;fitMed]', 'LineWidth',3);
legend( 'fitnessMax', 'fitnessMed' , 'Location', 'SouthEast');
grid on; xlabel('Generations'); ylabel('Fitness'); 
title('Fitness'); 
set(gca,'YScale', 'log', 'Fontsize', 24);

