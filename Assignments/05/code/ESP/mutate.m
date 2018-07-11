function children = mutate(cummulative_fitness, pop_wtMatrix, count, p)
avg_fitness = cummulative_fitness./count;
[~,sortedIdx] = sort(avg_fitness,2,'descend');
lowestSortedIdx = fliplr(sortedIdx);

%half = round(p.nGenes*0.5);
half = round(p.nNode*0.5);

%lowestNeuronIdx = lowestSortedIdx(:,1:half)+ p.nInputs; 
lowestNeuronIdx = lowestSortedIdx(:,1:half); 

children = pop_wtMatrix;

rng('shuffle'); 
for i = 1:p.popSize
    for j = 1:half       
        %doMut = (rand(2,p.nGenes)<p.mutProb);
        doMut = (rand(2,p.nNode)<p.mutProb);        
        idx = lowestNeuronIdx(i,j);               
        row = pop_wtMatrix(idx,:,i);
        row(1,doMut(1,:)) = tan((rand(1,sum(doMut(1,:)))-0.5)*pi);
        
        col = pop_wtMatrix(:,idx,i);
        col(doMut(2,:),1) = tan((rand(1,sum(doMut(2,:)))-0.5)*pi);
        
                
        children (idx,:,i) = row;
        children (:,idx,i) =col;
    end
end

%------------- END OF CODE --------------