function output = naca_cmaes_ep (task, nacaNum, p)

if nargin < 3
    
    p.task      = task;
    p.nGenes    = 32;
    p.maxGen    = 150;
    p.popSize   = 50;
    
    % NACA Parameters
    p.numEvalPts = 256;
    paramArray =  [[0, 0, 1, 2];[5, 5, 2, 2]; [9, 7, 3, 5]];
    p.nacafoil = create_naca(paramArray(nacaNum,:),p.numEvalPts);
    
    % breaking condition
    p.accuracy = 1e-4; 
    
    % ES params
    % p.rho = 1; 
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
        
    % EP params
    p.n = p.nGenes;
    p.cc = 0.01;%4/(p.n+4);
    p.c1 = 0.05;%2/(p.n)^2; or for faster convrgence, but lower optimum 0.08;
    p.psigma = zeros([ 1 p.nGenes]);
    p.csigma = 0.1;%1/p.nGenes;
    p.dsigma = 1.0;
    
    % Elitism params
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
cov = eye(32);
P_c = zeros([1 p.nGenes]);

%% 
while iGen <= p.maxGen
    
    pop = create_children(p,cov);   
    fitness =  feval(p.task, pop,p);
       
    % select the p.noOfElites best individuals 
    elite_ids = es_elitism(fitness,p);
    elite = pop(elite_ids,:);
    new_mean = get_mean(elite,p);
        
    P_c =  (1-p.cc)*P_c + sqrt(p.cc*(2-p.cc)*p.mu_eff)*((new_mean-p.mean_g)/p.sigma);
        
    % Updating covariance
    cov = (1-p.c1-p.cov_mu)*cov+p.c1*(P_c * P_c')+cmaes_ep_rank_mu_update(pop,p); 
    
    [p.psigma,p.sigma] = CStepAdapt(p,cov,new_mean);
    
    % update mean individual from elites 
    p.mean_g = get_mean(elite,p);
    p.mean_fit = feval(p.task, p.mean_g,p);
    
    % Data Gathering
    [fitMax(iGen), iBest] = min(fitness);
    fitMed(iGen)          = median(fitness);
    best(:,iGen)          = pop(iBest,:);
    
    
    % break when converged
    if iGen >= p.maxGen || (iGen>50 &&  mean(fitMed(iGen-50:iGen))< p.accuracy && mean(fitness)<p.accuracy)
        convergedGen = iGen;
        break;
    end     
    iGen = iGen+1;
    
    if mod(iGen,20) == 0
        figure(1)
        disp(iGen)
        bestIndividual =best(:,iGen-1)';
        visualize(bestIndividual, p);
    end
    
end
output.fitMax = fitMax;
output.fitMed = fitMed;
output.best = best;
output.convergedGen = convergedGen;
