function R_mu = cmaes_ep_rank_mu_update(pop,p)

R_mu = zeros(p.nGenes);
for i = 1:p.noOfElites
    y = (pop(i,:) - p.mean_g)/p.sigma;
    R_mu = R_mu + p.weights(i) * (y * y');
end
R_mu = R_mu * p.cov_mu;