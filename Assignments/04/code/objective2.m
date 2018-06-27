function output = objective2(ind, p)
%------------- BEGIN CODE --------------
leading_zeros = 0;
trailing_ones = 0;
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

output = [leading_zeros trailing_ones];
