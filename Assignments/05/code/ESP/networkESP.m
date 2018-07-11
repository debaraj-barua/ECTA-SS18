function output = networkESP(nHidden,nInputs,nOutputs, p)
if nargin<4 
    p.nSample       = 1;
    p.nHidden       = nHidden;
    p.nOutputs      = nOutputs;
    p.nInputs       = nInputs;    
    p.popSize       = nInputs+nHidden+nOutputs;%nHidden;
    %p.nGenes        = nInputs+nHidden+nOutputs;%nHidden;
    p.nNode         = nInputs+nHidden+nOutputs;
    p.maxGen        = 60; 
    p.burstMutateDur= 15;
    p.maxBurstMutate= 80;
    p.mutProb       = 0.2;
    output          = p; 
    return;
end

fit = nan(1,p.maxGen);         % Record the median  fitness
best = 0;
best_gen = 0;
best_wtMatrix = nan(p.nNode ,p.nNode);
best_pop = nan(p.nNode ,p.nNode,p.popSize);

%% Initialization

% Population Creation
pop_wtMatrix = rand(p.nNode ,p.nNode ,p.popSize);

wtMatrix = nan(p.nNode ,p.nNode);

% wActive = zeros(p.nNode,p.nNode);
% 
% % In to Hidden & Hidden to hidden connections
% input_hidden_r = linspace(1,p.nInputs+p.nHidden,p.nInputs+p.nHidden);
% input_hidden_c = linspace(p.nInputs+1,p.nInputs+p.nHidden,p.nHidden);
% wActive(input_hidden_r, input_hidden_c) = 1; 
% 
% % Hidden to Out connections
% hidden_output_r = linspace(p.nInputs+1,p.nInputs+p.nHidden,p.nHidden);
% wActive(hidden_output_r , end) = 1; 
% 
% wAct = ones(p.nNode,p.nNode);
% wAct(input_hidden_r, input_hidden_c) = 0;
% wAct(hidden_output_r , end) = 0; 


%% Generation Loop
iGen =0;
nReseed = 0;
while(iGen<=p.maxGen)
    
    iGen=iGen+1;
    cummulative_fitness = zeros(p.popSize,p.nNode);
    count = zeros(p.popSize,p.nNode);
    iteration = 0;
    
    %% Evaluation
    while(true)
        % get the idx of hidden neuron to pick from each individual in the pop
        %neuron_idx=randi([p.nInputs+1 p.nInputs+p.nHidden],[p.popSize 1]); 
        
        neuron_idx=randi([1 p.nNode],[p.popSize 1]); 
        for i = 1:p.popSize
            idx = neuron_idx(i);
            wtMatrix (:,idx) = pop_wtMatrix(:,idx,i);
            wtMatrix (idx,:) = pop_wtMatrix(idx,:,i);
            %count(i,idx-p.nInputs)=count(i, idx-p.nInputs)+1;
            count(i,idx)=count(i, idx)+1;
            
        end

        %fitness = getFitness(wtMatrix,p);
        fitness = getFitnessSingle(wtMatrix,p);
        if (fitness>best)
            best = fitness;
            %best_gen = iGen;
            cur_best_gen =iGen;
            best_wtMatrix = wtMatrix;
            %best_pop = pop_wtMatrix;
            disp('--');
            disp(fitness);
            if fitness>=1000
                break;
            end
        end
        
        for i = 1:p.popSize
            idx = neuron_idx(i);
            cummulative_fitness(i, idx)=cummulative_fitness(i, idx)+fitness;
        end    
        
        iteration = iteration+1;
        if all(mean(count,2)>=10) 
            break;
        end
    end
    fit(:,iGen) = fitness;
    disp(iGen)
    %disp(fitness)
    

    if fitness>=1000
        output.weightMatrix     = pop_wtMatrix;
        output.fitnessGen       = fit;
        output.best_wtMatrix    = best_wtMatrix;
        output.best             = best;
        return;
    end
    %% Recombination            
    % crossover & mutation
    pop_wtMatrix = crossover2 (cummulative_fitness,pop_wtMatrix,count,p);
    pop_wtMatrix = mutate (cummulative_fitness,pop_wtMatrix,count,p);
    
    %% Burst Mutation
    if (iGen-cur_best_gen>=p.burstMutateDur && ...        
        (nReseed<p.maxBurstMutate))
    
        disp(["Reseeding.. ",num2str(nReseed)]);         
        iGen=0;
        cur_best_gen=0;
        nReseed=nReseed+1;
        %pop_wtMatrix = rand(p.nNode ,p.nNode ,p.nNode );

        % GENERATE new around the best network
        for i = 1:p.popSize
            rng('shuffle');
            pop_wtMatrix(:,:,i) = best_wtMatrix+ tan((rand(p.nNode ,p.nNode)-0.5)*pi);
        end
        %pop_wtMatrix=best_pop+tan((rand(p.nNode ,p.nNode,p.popSize)-0.5)*pi);
        wtMatrix = best_wtMatrix+tan((rand(p.nNode ,p.nNode)-0.5)*pi);
    end
 
end

output.weightMatrix     = pop_wtMatrix;
output.fitnessGen       = fit;
output.best_wtMatrix    = best_wtMatrix;
output.best             = best;