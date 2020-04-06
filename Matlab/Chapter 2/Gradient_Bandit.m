function[rewards,optimal_action] = Gradient_Bandit(steps,std,arms,location,alpha)
    % Initialize Variables
    if strcmp(location,'moving') == 1
        q = ones(1,arms);
    else
        q = normrnd(std(1),std(2),1,arms); % The real reward
    end
    action_count = zeros(1,arms); % How many times an action is taken
    rewards = zeros(1,steps); % Track rewards at each step
    optimal_action = zeros(1,steps); % Track optimal actions at each step
    H = zeros(1,arms); % Preference start at 0
    Policy = ones(1,arms)./arms; % Must all add to one
    r_bar = 0; % Mean reward
    
    % Start Loop
    for i = 1:steps
        % Determine action to take
        [Action] = Decision_Maker_Policy(arms,Policy);
%        Action = randsample(10,1,true,Policy);
        
        % Updates about the action
        action_count(Action) = action_count(Action) + 1; % Increment value
        [~,best_action] = max(q);
        if Action == best_action
            optimal_action(1,i) = 1; % Update for optimal action
        end
        reward = q(1,Action)+ normrnd(std(1),std(2));
        rewards(1,i) = reward;
        
        r_bar = r_bar + (1/i) * (reward - r_bar);
        
        % Update H Values
        for j = 1:arms
            if j == Action
                H(1,j) = H(1,j) + (alpha * (reward - r_bar) * (1 - Policy(1,j)));
            else
                H(1,j) = H(1,j) - (alpha * (reward - r_bar) * Policy(1,j));
            end
        end
        
        % Update the Policy
        bottom = sum(exp(H));
        for j = 1:arms
            Policy(1,j) = exp(H(j))/bottom;
        end

        % For non-stationary simulations
        if strcmp(location,'moving') == 1
            q = q + normrnd(std(1),std(2),1,arms);
        end
    end
end