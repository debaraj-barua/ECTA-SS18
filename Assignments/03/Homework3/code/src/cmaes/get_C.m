function R_mu = get_C(pop,p)

R_mu = zeros(p.nGenes);
for i = 1:p.mu
    y = (pop(i,:) - p.mean_g)/p.sigma;
    R_mu = R_mu + p.weights(i) * (y * y');
end
R_mu = R_mu * p.cov_mu;