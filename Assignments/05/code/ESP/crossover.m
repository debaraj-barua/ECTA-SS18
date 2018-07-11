function children = crossover(cummulative_fitness, pop_wtMatrix, count, p)
avg_fitness = cummulative_fitness./count;
[~,sortedIdx] = sort(avg_fitness,2,'descend');
lowestSortedIdx = fliplr(sortedIdx);

%quartile = round(p.nGenes*0.25);
quartile = round(p.nNode*0.25);

% get matrix of (popsize, no of top quartile)
selectedNeuronsIdx = sortedIdx(:,1:quartile); 
lowestNeuronIdx = lowestSortedIdx(:,1:quartile); 

children = pop_wtMatrix;

rng('shuffle'); 
for i = 1:p.popSize
    for j = 2:quartile
        
        %doMut = (rand(4,p.nGenes)<p.mutProb);
        doMut = (rand(4,p.nNode)<p.mutProb);
        
        idx1 = selectedNeuronsIdx(i,j-1);
        idx2 = selectedNeuronsIdx(i,j);
        
        lowestIdx1 = lowestNeuronIdx(i,j-1);
        lowestIdx2 = lowestNeuronIdx(i,j);
        
        p1row = pop_wtMatrix(:,idx2,i)';
        p1row(1,doMut(1,:)) = tan((rand(1,sum(doMut(1,:)))-0.5)*pi);                        
        
        p1col = pop_wtMatrix(idx2,:,i)';
        p1col(doMut(2,:),1) =  tan((rand(1,sum(doMut(2,:)))-0.5)*pi);
        
        p2row = pop_wtMatrix(:,idx1,i)';
        p2row(1,doMut(3,:)) =  tan((rand(1,sum(doMut(3,:)))-0.5)*pi);
        
        p2col = pop_wtMatrix(idx1,:,i)';
        p2col(doMut(4,:),1) =  tan((rand(1,sum(doMut(4,:)))-0.5)*pi);
        
        children (lowestIdx1,:,i) =p1row;
        children (:,lowestIdx1,i) = p1col;
        
        
        children (lowestIdx2,:,i) = p2row;
        children (:,lowestIdx2,i) =p2col;
    end
end

%------------- END OF CODE --------------