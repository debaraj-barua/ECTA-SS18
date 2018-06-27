function output = get_unique(pop, p)
    output = [];
    for i=1: size(pop,1)
        is_duplicate = 0;
        for j=1:size(output,1)
            if is_equal(pop(i, p.nGenes+1: p.nGenes + p.nObj), output(j, p.nGenes+1: p.nGenes + p.nObj))
                is_duplicate = 1;
                break;
            end
        end
        
        if is_duplicate == 0
            output = [output ; pop(i,:)];
        end
    end
end

