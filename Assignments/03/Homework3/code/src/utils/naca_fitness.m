function fitness = naca_fitness(pop,p)

fitness = zeros([p.popSize 1]);

for index = 1:p.popSize
    if size(pop,2) == 1
        [foil, ~] = pts2ind(pop,p.numEvalPts);
    else
        [foil, ~] = pts2ind( pop(:,index), p.numEvalPts);
    end
    
    % Calculate pairwise error
    [~,errorTop] =    dsearchn(p.nacafoil(:,1:end/2)', foil(:,1:end/2)');
    [~,errorBottom] = dsearchn(p.nacafoil(:,1+end/2:end)', foil(:,1+end/2:end)');

    % Total fitness (mean squared error)
    fitness(index,:) = mean([errorTop.^2; errorBottom.^2]);

end