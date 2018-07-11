clear;clc;
nOutputs= 1;
nInputs = 5;
nHidden = 2;
%% 

%%

for i = 1:5    
    p = networkESP(nHidden,nInputs,nOutputs);
    tic;
    outputs(i) = networkESP(nHidden,nInputs,nOutputs,p);
    times(i)=toc;
end

%%
plot(outputs(1).fitnessGen)
max(outputs(1).fitnessGen)

%% op visualiization
fig = figure(1);
hold on;
for i = 1:10
    plot(outputs(i).fitnessGen)
end
hold off;
drawnow;
