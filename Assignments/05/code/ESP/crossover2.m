function children = crossover2(cummulative_fitness, pop_wtMatrix, count, p)
avg_fitness = cummulative_fitness./count;
[~,sortedIdx] = sort(avg_fitness,2,'descend');

%quartile = round(p.nGenes*0.25);
quartile = round(p.nNode*0.25);

% get matrix of (popsize, no of top quartile)
%selectedNeuronsIdx = sortedIdx(:,1:quartile); 
children = pop_wtMatrix;

for i = 1:p.popSize
    for j = 1:quartile
        idx1 = sortedIdx(i,j);
        idx2 = sortedIdx(i,randi(p.nNode,1));
        idx3 = sortedIdx(i,j*2);
        idx4 = sortedIdx(i,j*2+1);
        
        n1row = pop_wtMatrix(idx1,:,i);
        n1col = pop_wtMatrix(:,idx1,i);
        
        n2row = pop_wtMatrix(idx2,:,i);
        n2col = pop_wtMatrix(:,idx2,i);
        
        n3row = pop_wtMatrix(idx3,:,i);
        n3col = pop_wtMatrix(:,idx3,i);
        
        n4row = pop_wtMatrix(idx4,:,i);
        n4col = pop_wtMatrix(:,idx4,i);
        
        crossPt = randi(p.nNode,1);
        for k = 1:p.nNode
            if k <crossPt
                n3row(k)=n1row(k);
                n3col(k)=n1col(k);
            else
                n4row(k)=n2row(k);
                n4col(k)=n2col(k);
            end
        end
        children(idx3,:,i)= n3row;
        children(:,idx3,i)= n3col;
        
        children(idx4,:,i)= n4row;
        children(:,idx4,i)= n4col;
    end

end


%------------- END OF CODE --------------