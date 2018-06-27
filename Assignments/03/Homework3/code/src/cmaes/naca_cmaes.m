function output = naca_cmaes (task, nacaNum, p)

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
    % p.rho = 1;
    % p.k = inf(1); 
    % p.lambda = 1;
    p.noOfElites = p.popSize/5;
    p.weights = (-p.noOfElites:-1)*-1/sum((1:p.noOfElites)); 
    p.sigma = 0.075;
    p.updateSigmaTime = 5; %should be multiple of 5
    
    % CMAES params
    p.mu_eff = 1/sum(p.weights.^2);    
    p.cov_mu = 0.125; %p.mu_eff/p.nGenes^2;    
    p.cov_mu_min = 0.025;
    p.cov_mu_gens = 50; %p.maxGen/6;
    p.cov_mu_factor = (p.cov_mu-p.cov_mu_min)/p.cov_mu_gens;
    
    % Elitism params
    p.mean_g = rand(p.nGenes,1)-0.5;
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
    
    % select the p.noOfElites best individuals 
    elite_ids = es_elitism(fitness,p);
    elite = pop(:,elite_ids);
    
    % Updating covariance
    cov_mu = cmaes_rank_mu_update(elite,p,p.mean_g);    
    cov = (1-p.cov_mu)*cov+p.cov_mu*(1/p.sigma^2)*cov_mu;      
    
    
    % update mean individual from elites 
    p.mean_g = get_mean(elite,p);
    p.mean_fit = feval(p.task, p.mean_g,p);       
    
    if iGen < p.cov_mu_gens
        p.cov_mu = p.cov_mu - p.cov_mu_factor;
    end
    
    % Data Gathering
    [fitMax(iGen), iBest] = min(fitness);
    fitMed(iGen)          = median(fitness);
    best(:,iGen)          = pop(:,iBest);
        
    % break when converged
    if iGen >= p.maxGen || (iGen>50 &&  mean(fitMed(iGen-50:iGen))< p.accuracy && mean(fitness)<p.accuracy)
        convergedGen = iGen;
        %break;
    end
    iGen = iGen+1;
    time = time+1;
    
%     if mod(iGen,5) == 0
%         figure(1)
%         disp(iGen)
%         bestIndividual =best(:,iGen-1)';
%         visualize(bestIndividual, p);
%     end
    
    
end
output.fitMax = fitMax;
output.fitMed = fitMed;
output.best = best;
output.convergedGen = convergedGen;
