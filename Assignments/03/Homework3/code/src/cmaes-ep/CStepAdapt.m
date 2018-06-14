function [psigma, sigma] = CStepAdapt(p,C,mean_g1)

psigma = (1-p.csigma)*p.psigma + sqrt(p.csigma*(2-p.csigma)*p.mu_eff)*sqrt(C)*((mean_g1-p.mean_g)/p.sigma);
sigma = p.sigma * exp((p.csigma/p.dsigma)*(norm(psigma)/norm(randn(p.nGenes,1))-1));
 