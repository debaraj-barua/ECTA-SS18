function children  = my_mutation(children, p)
for i = 1 : p.popSize
    doMut = (rand(1 , p.nGenes) < p.mutProb);     % Mutate genes or not?
    n = sum(doMut(:));
    genes = children(i, :);
    modIndex = genes (doMut);
    if (n>=1)
        for j = 1 : n-1
            temp = modIndex(j);
            modIndex(j) = modIndex (j+1);
            modIndex(j+1) = temp;
        end
    end
    genes (doMut) = modIndex;
    children (i,:) = genes;
end
    

