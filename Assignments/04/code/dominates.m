function output = dominates(genome_1, genome_2)
    output = 1;
    for i=1: length(genome_1)
        if genome_1(i) < genome_2(i)
            output=0;
            break;
        end
    end
end

