function f = non_domination_sort(pop, p)
%% Non-Dominated sort.
% Initialize the front number to 1.
front = 1;

F(front).f = [];
individuals = [];

for i = 1 : size(pop, 1)
    % Number of individuals that dominate this individual
    ind.n = 0;
    % Individuals which this individual dominate
    ind.p = [];
    for j = 1 : size(pop, 1)
        if i ~= j
            obj_i = pop(i, p.nGenes+1:p.nGenes + p.nObj);
            obj_j = pop(j, p.nGenes+1:p.nGenes + p.nObj);
            if dominates(obj_i, obj_j) == 1 
                ind.p = [ind.p j];
            elseif dominates(obj_j, obj_i) == 1
                ind.n = ind.n + 1;
            end
        end
    end   
    if ind.n == 0
        pop(i,p.nGenes + p.nObj + 1) = 1;
        F(front).f = [F(front).f i];
    end
    individuals = [individuals ind];
end
% Find the subsequent fronts
while ~isempty(F(front).f)
   Q = [];
   for i = 1 : length(F(front).f)
       if ~isempty(individuals(F(front).f(i)).p)
        	for j = 1 : length(individuals(F(front).f(i)).p)
            	individuals(individuals(F(front).f(i)).p(j)).n = ...
                	individuals(individuals(F(front).f(i)).p(j)).n - 1;
        	   	if individuals(individuals(F(front).f(i)).p(j)).n == 0
               		pop(individuals(F(front).f(i)).p(j),p.nObj + p.nGenes + 1) = front + 1;
                    Q = [Q individuals(F(front).f(i)).p(j)];
                end
            end
       end
   end
   front =  front + 1;
   F(front).f = Q;
end

[~,index_of_fronts] = sort(pop(:,p.nObj + p.nGenes + 1));
for i = 1 : length(index_of_fronts)
    sorted_based_on_front(i,:) = pop(index_of_fronts(i),:);
end

%% Crowding distance
current_index = 0;
for front = 1 : (length(F) - 1)
%    objective = [];
    distance = 0;
    y = [];
    previous_index = current_index + 1;
    for i = 1 : length(F(front).f)
        y(i,:) = sorted_based_on_front(current_index + i,:);
    end
    current_index = current_index + i;
    % Sort each individual based on the objective
    sorted_based_on_objective = [];
    for i = 1 : p.nObj
        [sorted_based_on_objective, index_of_objectives] = ...
            sort(y(:,p.nGenes + i));
        sorted_based_on_objective = [];
        for j = 1 : length(index_of_objectives)
            sorted_based_on_objective(j,:) = y(index_of_objectives(j),:);
        end
        f_max = ...
            sorted_based_on_objective(length(index_of_objectives), p.nGenes + i);
        f_min = sorted_based_on_objective(1, p.nGenes + i);
        y(index_of_objectives(length(index_of_objectives)),p.nObj + p.nGenes + 1 + i)...
            = Inf;
        y(index_of_objectives(1),p.nObj + p.nGenes + 1 + i) = Inf;
         for j = 2 : length(index_of_objectives) - 1
            next_obj  = sorted_based_on_objective(j + 1,p.nGenes + i);
            previous_obj  = sorted_based_on_objective(j - 1,p.nGenes + i);
            if (f_max - f_min == 0)
                y(index_of_objectives(j),p.nObj + p.nGenes + 1 + i) = Inf;
            else
                y(index_of_objectives(j),p.nObj + p.nGenes + 1 + i) = ...
                     (next_obj - previous_obj)/(f_max - f_min);
            end
         end
    end
    distance = [];
    distance(:,1) = zeros(length(F(front).f),1);
    for i = 1 : p.nObj
        distance(:,1) = distance(:,1) + y(:, p.nObj + p.nGenes + 1 + i);
    end
    y(:,p.nObj + p.nGenes + 2) = distance;
    y = y(:,1 : p.nObj + p.nGenes + 2);
    
    [~, index_of_crowding_distance] = sort(y(:,end), 'descend');
    y = y(index_of_crowding_distance, :);
    
    z(previous_index:current_index,:) = y;
end
f = z();
