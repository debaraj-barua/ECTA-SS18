function C_mu = estimate_C(elite,p,mean_g)
%%
C_mu = zeros([p.nGenes p.nGenes]);
for i = 1:p.mu
    C_mu = C_mu + p.weights(i)*(elite(i,:)-mean_g)*(elite(i,:)-mean_g)';
    
end
C_mu = C_mu/p.mu;


%disp(C_mu)
