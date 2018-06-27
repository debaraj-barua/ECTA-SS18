function parentIds = selection(fitness, p)
%------------- BEGIN CODE --------------

%% TOURNAMENT SELECTION SOLUTION
for child_count = 1:size(fitness, 1)
    group = randi(size(fitness, 1), [p.sp,2]); % Get two sets of random individuals
    
    first_parent_index = group(1,1);
    for i = 1:p.sp
        if fitness(group(i,1),1) < fitness(first_parent_index,1)
            first_parent_index = i;
        elseif fitness(group(i,1),1) == fitness(first_parent_index,1) && ...
                fitness(group(i,1),2) > fitness(first_parent_index,2)
            first_parent_index=i;
        end
    end
    
    second_parent_index = group(1,2);
    for i = 1:p.sp
        if fitness(group(i,2),1) < fitness(second_parent_index,1)
            second_parent_index = i;
        elseif fitness(group(i,2),1) == fitness(second_parent_index,2) && ...
                fitness(group(i,2),2) > fitness(second_parent_index,2)
            second_parent_index=i;
        end
    end
    
    parentIds(child_count, :) = [first_parent_index second_parent_index];
end
%------------- END OF CODE --------------