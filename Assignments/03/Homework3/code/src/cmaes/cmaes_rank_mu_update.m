function C_mu = cmaes_rank_mu_update(elite,p,mean_g)

C_mu = zeros([p.nGenes p.nGenes]);
for i = 1:p.noOfElites
    %x = (elite(i,:)-mean_g);
    %C_mu = C_mu + p.weights(i) * (x * x');    
    %C_mu = C_mu + p.weights(i) * x * x';   
    C_mu = C_mu + p.weights(i)*(elite(i,:)-mean_g)*(elite(i,:)-mean_g)';
end
C_mu = C_mu/p.noOfElites;

