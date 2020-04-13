function[Action] = Best_Action(V_pi,actions,gamma,rental_reward,moving_cost,i,j,state_def,n_actions,alt)
    
    % Solve for all possible Vs given all actions
    V = zeros(1,n_actions); % Initialize V
    
    % Loop through actions
    for m = 1:n_actions
        action = actions(1,m);
        if alt == false
            % Example Problem
            V(1,m) = Rewards_Next_State(i,j,state_def,rental_reward,moving_cost,action,V_pi,gamma);
        else
            % Exercise Problem
            V(1,m) = Rewards_Next_State_alt(i,j,state_def,rental_reward,moving_cost,action,V_pi,gamma);
        end
    end

    % Best action
    [~,Location] = max(V);
    Action = actions(1,Location); % Pull out the action
end