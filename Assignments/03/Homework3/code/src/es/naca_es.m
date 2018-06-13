function output = naca_es(task,nacaNum, p)

if nargin < 3
    
    p.task      = task;
    p.nGenes    = 32;
    p.maxGen    = 150;
    p.popSize   = 50;
    
    % NACA Parameters
    p.numEvalPts = 256;
    paramArray =  [[0, 0, 1, 2];[5, 5, 2, 2]; [9, 7, 3, 5]];
    p.nacafoil = create_naca(paramArray(nacaNum,:),p.numEvalPts);
   
    % ES params    
    p.accuracy = 1e-4;    
    p.sigma = 0.01;    
    p.updateSigmaTime = 5; %should be multiple of 5
    
    p.mu = 10;
    %p.mu = 1;
%     p.k = inf(1); 
%     p.lambda = 1;
%     p.rho = 1;

    p.weights = (-p.mu:-1)*-1/sum((1:p.mu)); 
    p.mean_g = rand(1, p.nGenes)-0.5;
    p.mean_fit = feval(p.task,p.mean_g,p);
    
    output = p;
    return
end
%%
fitMax = nan(1,p.maxGen);       
fitMed = nan(1,p.maxGen);        
best   = nan(p.nGenes, p.maxGen); 
iGen = 1;
mutSuccessful = 0;
time = 1;
%% 
while iGen <= p.maxGen
%     
%     Q = [];
%     
%     for i = 1:p.lambda
%         % Selection -- Returns [MX2] indices of parents
%         parentIds = randi(p.popSize, [p.rho,1]);
%     end


    pop = create_children(p);
    fitness = feval(p.task, pop, p);
    mutSuccessful = mutSuccessful + sum(fitness < p.mean_fit);

    if mod(iGen,p.updateSigmaTime) == 0    
        p.sigma = sigma_update(mutSuccessful,time,p);
        mutSuccessful = 0;
        time = 1;
    end
    
    % select the p.mu best individuals
    elite_ids = es_elitism(fitness,p);
    elite = pop(elite_ids,:);
     
    p.mean_g = get_mean(elite,p);
    p.mean_fit = feval(p.task, p.mean_g,p);
    
    % Data Gathering
    [fitMax(iGen), iBest] = min(fitness); % 1st output is the max value, 2nd the index of that max value    
    fitMed(iGen)          = median(fitness);
    best(:,iGen)          = pop(iBest,:);
    
    iGen = iGen+1;
    time = time+1;
    
    if iGen > p.maxGen || median(fitness) < p.accuracy
        convergedGen = iGen-1;
        break;
    end 
    
end
output.fitMax = fitMax;
output.fitMed = fitMed;
output.best = best;
output.convergedGen = convergedGen;