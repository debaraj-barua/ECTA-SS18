function pop = create_pop(Covariance,p)
%%
individual = p.mean_g;
pop = nan(p.popSize,p.nGenes);
mu = zeros([1 p.nGenes]);
for i = 1:p.popSize
    pop(i,:) = individual + p.sigma * mvnrnd(mu,Covariance);
end