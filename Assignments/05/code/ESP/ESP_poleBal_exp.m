clear;clc;
nOutputs= 1;
nInputs = 6;
nHidden = 6;
%% 
p = networkESP(nHidden,nInputs,nOutputs);
%%
tic;
output = networkESP(nHidden,nInputs,nOutputs,p);
toc;
%%
plot(output.fitnessGen)
max(output.fitnessGen)
