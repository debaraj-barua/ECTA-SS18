function sigma = sigma_update(mutSuccessful,time,p)
gamma = 1.1;%(20/17)^(1/p.nGenes);

if (mutSuccessful/time)/p.popSize < 0.2
    sigma = p.sigma/gamma;  
elseif (mutSuccessful/time)/p.popSize > 0.2
    sigma = p.sigma*gamma;
else 
    sigma = p.sigma;    
end
