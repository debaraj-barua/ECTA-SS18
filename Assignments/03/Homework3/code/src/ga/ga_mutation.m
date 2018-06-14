function children  = ga_mutation(children, p)
doMut = (rand(p.nGenes,p.popSize)<p.mutProb);
children (doMut) =  rand([sum(doMut(:)) 1]) - 0.5;