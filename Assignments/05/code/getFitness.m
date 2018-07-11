function fitness = getFitness(pop,p)
for i = 1:size(pop, 1)
    ind = pop(i, :);
    if (p.nInputs == 4) 
        initialState = [0 0 .017 0]';
        scaling = [ 2.4 10.0 0.628329 5]';
        state = initialState;
        pole2Up = true;
    else
        initialState = [0 0 .017 0 0.0 0]';
        scaling = [ 2.4 10.0 0.628329 5 0.628329 16]'; 
        state = initialState;
        pole2Up = abs(state(5)) < pi/2;  % Pole #2 Balanced
    end
    nSample = 1;
    p.simParams.force = 10;
    totalSteps = 1000;
    for step=1:totalSteps
        %% Check that all states are legal
        onTrack = abs(state(1)) < 2.16;
        notFast = abs(state(2)) < 1.35;
        pole1Up = abs(state(3)) < pi/2;
        failureConditions = ~[onTrack notFast pole1Up pole2Up];
        
        if any(failureConditions)   
            fitness(i) = step; break;
        else % Do the next time step
            %% ACTION SELECTION [your code goes here]
            scaledInput = state./scaling; % Normalize state vector for ANN

            wActive = zeros(p.nNode);
            wMat = zeros(p.nNode);
            if p.nInputs == 6
                for j = 1:p.nHidden
                    % make groups of 6 and assign
                    wMat([1 2 3 4 5 6], p.nInputs+j) = ind((j-1)*6+1:6*j);
                    wActive([1 2 3 4 5 6], p.nInputs+j) = 1;
                end
                % hidden to output
                wMat(p.nInputs+1:p.nInputs+p.nHidden,end) = ind(6*p.nHidden+1:end);
                wActive (p.nInputs+1:p.nInputs+p.nHidden,end) = 1;
            elseif p.nInputs == 4
                    % input to hidden
                    for j = 1:p.nHidden
                        % make groups of 4 and assign
                        wMat([1 2 3 4], p.nInputs+j) = ind((j-1)*4+1:4*j);
                        wActive([1 2 3 4], p.nInputs+j) = 1;
                    end
                    % hidden to output
                    wMat(p.nInputs+1:p.nInputs+p.nHidden,end) = ind(4*p.nHidden+1:end);
                    wActive (p.nInputs+1:p.nInputs+p.nHidden,end) = 1;
            else
                wMat([1 3 5], 7) = ind(1:3);
                wMat([1 3 5], 8) = ind(4:6);
                wMat([7 8], 9) = ind(7:8);
                wActive([1 3 5], [7 8]) = 1;
                wActive([7 8], 9) = 1;
            end

            wMat = wMat.*wActive;

            nodeAct = zeros(nSample,p.nNode);
            nodeAct(1:p.nInputs) = scaledInput;

            for iNode = (p.nInputs+1):p.nNode
               nodeAct(iNode) = tanh(nodeAct*wMat(:,iNode)); 
            end

            output = nodeAct(end);
            action = output*p.simParams.force; % Scale to full force

            %% SIMULATE RESULT
            % Take action and return new state:
            if size(ind, 2) == 10
                state = cart_pole1( state, action );
            else
                state = cart_pole2( state, action );
            end
        end
    end
    fitness(i) = step;
end
end

