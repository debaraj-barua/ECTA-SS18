function mean_g = get_mean(elite,p)
mean_g = zeros([p.nGenes 1]);
for i = 1:p.noOfElites
    mean_g = mean_g + elite(:,i)*p.weights(i);
end
