function fitness = getFitness2Nvl(wMat,p)
    %fig = figure(1);
    %clf('reset')
    nOutputs= 1;
    nInputs = 6;
    totalSteps = 1000;
    maxforce = 10;

    %   state = [ x           <- the cart position
    %             x_dot       <- the cart velocity
    %             theta       <- the angle of the pole
    %             theta_dot   <- the angular velocity of the pole.
    %             theta2      <- the angle of the 2nd pole
    %             thet2a_dot  <- the angular velocity of the 2nd pole.
    %           ]
    
    initialState = [0 0 .017 0 0.0 0]';  % initial state (note, it is a column vector) (1 degree = .017 rad)
    scaling =  [ 2.4 10.0 0.628329 5 0.628329 16]'; % Divide state vector by this to scale state to numbers between 1 and 0
    state = initialState;
    nodeAct = zeros(1,p.nNode);
    
    for step=1:totalSteps
        % Check that all states are legal
        onTrack = abs(state(1)) < 2.16; % Cart still on track
        notFast = abs(state(2)) < 1.35; % Cart never too fast
        pole1Up = abs(state(3)) < pi/2; % Pole #1 Balanced
        pole2Up = abs(state(5)) < pi/2;  % Pole #2 Balanced
        failureConditions = ~[onTrack notFast pole1Up pole2Up];
        if any(failureConditions)   
            fitness = step; 
            return;
        else            
            scaledInput = state./scaling; % Normalize state vector for ANN             
            nodeAct(1:nInputs) = scaledInput';
            nodeAct = tanh(nodeAct*wMat);
            output=nodeAct(end);
            
            action = output*maxforce;
%             disp(output);
%             disp(action);
            state = cart_pole2( state, action );  
             %% Visualize result (optional and slow, don't use all the time!)
            % clf
%             cpvisual(fig, 1, state(1:4), [-3 3 0 2], action );         % Pole 1
%             cpvisual(fig, 0.5, state([1 2 5 6]), [-3 3 0 2], action ); % Pole 2
%             pause(0.02);
        end
    end
    fitness = totalSteps;