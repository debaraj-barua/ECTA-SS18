function parentIds = my_selection(fitness, p)

parentIds = NaN(p.popSize, 2);
for child_count = 1:p.popSize
    group = randi(p.popSize, [p.sp,2]); % Get two sets of random individuals
    [~, winner_index] = min(fitness(group)); % Get a parent from each set based on highest fitness
    
    first_parent_index = group(winner_index(1,1), 1);   % Get the first parent
    second_parent_index = group(winner_index(1,2), 2);  % Get the second parent
    
    parentIds(child_count, :) = [first_parent_index second_parent_index];
end
