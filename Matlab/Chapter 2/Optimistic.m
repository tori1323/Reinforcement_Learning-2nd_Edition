function[rewards,optimal_action] = Optimistic(steps,std,arms,location,Q_0,eps)
 % Initialize Variables
    if strcmp(location,'moving') == 1
        q = ones(1,arms);
    else
        q = normrnd(std(1),std(2),1,arms); % The real reward
    end
    action_count = zeros(1,arms); % How many times an action is taken
    rewards = zeros(1,steps); % Track rewards at each step
    optimal_action = zeros(1,steps); % Track optimal actions at each step
    Q = Q_0 * ones(1,arms); % Estimated values
    
    % Start Loop
    for i = 1:steps
        % Determine action to take
        if eps > rand(1) % Check to see if to act randomly or not
            Action = Decision_Maker(arms); % Determine random decision || Dice
        else % Greedy action
            [~,Action] = max(Q); 
        end
        
        % Updates about the action
        action_count(Action) = action_count(Action) + 1; % Increment value
        [~,best_action] = max(q);
        if Action == best_action
            optimal_action(1,i) = 1; % Update for optimal action
        end
        Count = action_count(Action);
        reward = q(1,Action)+ normrnd(std(1),std(2));
        rewards(1,i) = reward;
        
        % Update Q Values
        Value = Q(1,Action) + (1/Count) * (reward - Q(1,Action));
        Q(1,Action) = Value; % Update Q_(n+1)
        
        % For non-stationary simulations
        if strcmp(location,'moving') == 1
            q = q + normrnd(std(1),std(2),1,arms);
        end
    end
end