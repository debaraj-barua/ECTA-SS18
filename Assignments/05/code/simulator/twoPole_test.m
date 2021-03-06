function [ steps ] = twoPole_test( wMat, activateNet, targetFitness, varargin)
%TWOPOLE_TEST Double pole balancing
%   See cart_pole2.m for details and original authors
%   state = [ x           <- the cart position
%             x_dot       <- the cart velocity
%             theta       <- the angle of the pole
%             theta_dot   <- the angular velocity of the pole.
%             theta2      <- the angle of the 2nd pole
%             thet2a_dot  <- the angular velocity of the 2nd pole.
%
% environment parameters (these MUST match the corresponding values in cart_pole.m)

%% Initialization
vis = false;
initial_state = [0 0 .017 0 0.0 0]';
simLength = targetFitness;

if nargin > 3 
    if strcmp(varargin{end},'vis')
        vis = true;
        axis_range = [-3 3 0 2];
        hf = figure; % generate a new figure to be used by cpvisual()
        hf2 =figure; % generate a new figure to be used by cpvisual2()
        tic; % initialize timer, which is used to make animation with cpvisual()
        % more realistic.
    end
    if strcmp(varargin{1},'setInit')
        initial_state = varargin{2};
    end
end


pole_length = 0.5*2; % full pole length (not just half as in cart_pole.m)
pole_length2 = 0.05*2; % full pole length (not just half as in cart_pole.m)
tau = 0.01; % time between each step (in s)
state = initial_state; % initial state (note, it is a column vector) (1 degree = .017 rad)
force = 10;
steps = 0;

bias = 1;

scaling = [ 2.4 10.0 0.628329 5 0.628329 16]';
activation = zeros(1,length(wMat));

%% Sim loop
while ( abs(state(3)) < pi/2 && ...    % Pole #1 Balanced
        abs(state(5)) < pi/2 && ...    % Pole #2 Balanced
        abs(state(1)) < 2.16 && ...    % Cart still on track
        abs(state(2)) < 1.35 && ...    % Cart never too fast
        steps < simLength)
    
    steps = steps + 1;
    
    %% Action Selection
    scaledInput = state./scaling;
    input = scaledInput';

    activation = feval(activateNet,wMat,[bias input],activation);
    output = activation(end);
    
    action = (-0.5+output).*2.*force;
    
    if vis
        % Visualization
        while toc < tau, end % wait until at least the time between state
        % changes, tau, has passed since the last graph.
        cpvisual( hf, pole_length, state(1:4), axis_range, action );
        cpvisual( hf2, pole_length2, state([1 2 5 6]), axis_range, action );
        tic; % reset timer (used for realistic visualization)
    end
    
    % Take action and return new state:
    state = cart_pole2( state, action );
end


