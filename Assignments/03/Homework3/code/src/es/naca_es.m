function output = naca_es(task,nacaNum, p)

if nargin < 3
    
    p.task      = task;
    p.nGenes    = 32;
    p.maxGen    = 2000;
    p.popSize   = 10;
    
    % NACA Parameters
    p.numEvalPts = 256;
    paramArray =  [[0, 0, 1, 2];[5, 5, 2, 2]; [9, 7, 3, 5]];
    p.nacafoil = create_naca(paramArray(nacaNum,:),p.numEvalPts);
    
    % breaking condition
    p.accuracy = 1e-4; 
    
    % ES params
    p.noOfElites = p.popSize/5;
    p.weights = (-p.noOfElites:-1)*-1/sum((1:p.noOfElites)); 
    p.sigma = 0.01;    
    p.updateSigmaTime = 5; %should be multiple of 5

    %p.k = inf(1); 
    %p.lambda = 1;
    %p.rho = 1;

    % Elitism params
    p.mean_g = rand(p.nGenes , 1)-0.5;
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
    pop = create_children(p);
    fitness = feval(p.task, pop, p);
    mutSuccessful = mutSuccessful + sum(fitness < p.mean_fit);

    if mod(iGen,p.updateSigmaTime) == 0    
        p.sigma = sigma_update(mutSuccessful,time,p);
        mutSuccessful = 0;
        time = 1;
    end
    
    % select the p.noOfElites best individuals
    elite_ids = es_elitism(fitness,p);
    elite = pop(:,elite_ids);
    
    % update mean individual from elites
    p.mean_g = get_mean(elite,p);
    p.mean_fit = feval(p.task, p.mean_g,p);
    
    % Data Gathering
    [fitMax(iGen), iBest] = min(fitness); % 1st output is the max value, 2nd the index of that max value    
    fitMed(iGen)          = median(fitness);
    best(:,iGen)          = pop(:,iBest);
    
    % break when converged
    if iGen >= p.maxGen || (iGen>50 &&  mean(fitMed(iGen-50:iGen))< p.accuracy && mean(fitness)<p.accuracy)
        convergedGen = iGen;
        %break;
    end 
    iGen = iGen+1;
    time = time+1;
end
output.fitMax = fitMax;
output.fitMed = fitMed;
output.best = best;
output.convergedGen = convergedGen;