function output = naca_cmaes (task, nacaNum, p)

if nargin < 3
    
    p.task      = task;
    p.nGenes    = 32;
    p.maxGen    = 150;
    p.popSize   = 50;
    
    % NACA Parameters
    p.numEvalPts = 256;
    paramArray =  [[0, 0, 1, 2];[5, 5, 2, 2]; [9, 7, 3, 5]];
    p.nacafoil = create_naca(paramArray(nacaNum,:),p.numEvalPts);
    
    %CMAES params
    p.rho = 1; 
    p.mu = p.popSize/5;
    p.accuracy = 1e-4;
    p.weights = (-p.mu:-1)*-1/sum((1:p.mu)); 
    p.sigma = 0.075;
    p.updateSigmaTime = 5; %should be multiple of 5
    
    p.mu_eff = 1/sum(p.weights.^2);
    
    p.cov_mu = 0.125;%p.mu_eff/p.nGenes^2;
    
    p.cov_mu_min = 0.025;
    p.cov_mu_gens = 50;%p.maxGen/6;
    p.cov_mu_factor = (p.cov_mu-p.cov_mu_min)/p.cov_mu_gens;
        
    p.mean_g = rand(1,p.nGenes)-0.5;
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
cov = eye(32);

%% 
while iGen <= p.maxGen
    
    pop = create_children(p,cov);   
    fitness =  feval(p.task, pop,p);
    mutSuccessful = mutSuccessful + sum(fitness < p.mean_fit);
    
    if mod(iGen,p.updateSigmaTime) == 0 
        p.sigma = sigma_update(mutSuccessful,time,p);
        mutSuccessful = 0;
        time = 1;
    end 
    
    % select the p.mu best individuals 
    elite_ids = es_elitism(fitness,p);
    elite = pop(elite_ids,:);
    
    % get cov_mu^(g+1)
    cov_mu = estimate_C(elite,p,p.mean_g);
    
    % Update cov 
    cov = (1-p.cov_mu)*cov+p.cov_mu*(1/p.sigma^2)*cov_mu;  
    
    % calcuate mean = sum of weights_i*x_i, i = 1,...,p.mu 
    p.mean_g = get_mean(elite,p);
    p.mean_fit = feval(p.task, p.mean_g,p);
    
    
    if iGen < p.cov_mu_gens
        p.cov_mu = p.cov_mu - p.cov_mu_factor;
    end
    
    [fitMax(iGen), iBest] = min(fitness);
    fitMed(iGen)          = median(fitness);
    best(:,iGen)          = pop(iBest,:);
    iGen = iGen+1;
    time = time+1;
    
    if iGen > p.maxGen || median(fitness)< p.accuracy
        convergedGen = iGen-1;
        break;
    end 
    
end
output.fitMax = fitMax;
output.fitMed = fitMed;
output.best = best;
output.convergedGen = convergedGen;
