function[Action] = Decision_Maker_Policy(n_actions,Policy)
    dice = rand(1); % Generate random number between 0 and 1
    
    %Policy = Policy + normrnd(0,.01,1,n_actions); % Add some randomness
    [Policy_L2G,index] = sort(Policy,'ascend'); % Least to greatest
    
    
    % Decide which action to take
    if dice == 1
        Action = n_actions;
    elseif Policy_L2G(1) >= dice
        Action = 1;
    else
        i = 1; % Initialize index number for actions
        sum = Policy_L2G(i); % Sum probabilities
        while dice > sum && i < n_actions
            i = i + 1; % Increment until find
            sum = sum + Policy_L2G(i); % Increment
        end
        Action = index(1,i); % Pull out index of action
    end
end