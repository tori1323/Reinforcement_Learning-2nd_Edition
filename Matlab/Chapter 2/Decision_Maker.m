function[Action] = Decision_Maker(n_actions)
    dice = rand(1)*.01; % Generate random number between 0 and 1
    set = zeros(1,n_actions); % Generate array to hold limits
    limit_start = 1/n_actions; % Define start limit
    
    % Edit the set array
    set(1,1) = limit_start; % Edit first index
    for i = 2:n_actions
        set(1,i) = limit_start + set(1,i-1); 
    end
    
    if dice == 1
        Action = n_actions;
    else
        Action = 1; % Initialize index number for actions
        while dice > set(1,Action)
            Action = Action + 1; % Increment until find
        end
    end

end