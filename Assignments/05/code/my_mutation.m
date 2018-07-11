function children  = my_mutation(children, p)
doMut = (rand(p.popSize,p.nGenes)<p.mutProb);
children (doMut) = -1 + 2*rand([1 sum(doMut(:))]);

