function output = objective3(ind, p)
%------------- BEGIN CODE --------------
leading_zeros = 0;
trailing_ones = 0;
non_consecutive = 0;
for i = 1:p.nGenes
    if(ind(i) == 1)
        break;
    end
    leading_zeros = leading_zeros + 1;
end

for i = p.nGenes:-1:1
    if(ind(i) == 0)
        break;
    end
    trailing_ones = trailing_ones + 1;
end

for i = 1:p.nGenes
    prev = 2;
    next = 2;
    
    if(i > 1)
        prev = ind(i-1);
    end
    
    if(i < p.nGenes)
        next = ind(i+1);
    end
    
    if(ind(i) ~= prev && ind(i) ~= next)
        non_consecutive = non_consecutive + 1;
    end
end

output = [leading_zeros trailing_ones non_consecutive];
