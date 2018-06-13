function children  = ga_mutation(children, p)
doMut = (rand(p.popSize,p.nGenes)<p.mutProb);
children (doMut) =  rand([1 sum(doMut(:))]) - 0.5;
