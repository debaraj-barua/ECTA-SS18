function contains_item = contains_ind(pop, ind, p)
    contains_item = 0;
    for i=1: size(pop,1)
        if is_equal(pop(i, 1: p.nGenes + p.nObj), ind(1: p.nGenes + p.nObj))
            contains_item = 1;
            break;
        end
    end
end

