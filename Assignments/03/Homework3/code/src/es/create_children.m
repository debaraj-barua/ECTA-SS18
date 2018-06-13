%function children = create_children(pop,p)
function children = create_children(p,cov)
%
if nargin<2
    cov = eye(p.nGenes);
end
%identity_cov = eye(p.nGenes);
%zero_mu =  zeros([p.popSize,p.nGenes]);

zero_mu =  zeros([1,p.nGenes]);
mean_individual = p.mean_g;
children=nan(p.popSize,p.nGenes);
for i = 1: p.popSize
  children(i,:)=  mean_individual + p.sigma * mvnrnd(zero_mu,cov);
end

%children = pop + p.sigma * mvnrnd(zero_mu,identity_cov);


