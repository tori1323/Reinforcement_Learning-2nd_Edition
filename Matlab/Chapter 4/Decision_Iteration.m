function[Expected_Value,Policy_Value] = Decision_Iteration(v_old,terminal_states,P_h,Loc,gamma)
    
    % Initialize Variables
    actions = (1:min(Loc,(100-Loc))); % Need to start from 1 to force movement
    num_actions = length(actions); % Number of actions
    V = zeros(1,num_actions); % Initialize V for each state
    
    for i = 1:num_actions
        % Next States
        Next_State1 = Loc + actions(1,i); % For heads
        Next_State2 = Loc - actions(1,i); % For tails
               
        % Solve for reward of action
        if Next_State1 >= terminal_states(1,2)
            v_value1 = 1;
        else
            v_value1 = v_old(1,Next_State1);
        end        
        
        % Solve Location if terminal
        if Next_State2 <= terminal_states(1,1)
            v_value2 = 0;
        else
            v_value2 = v_old(1,Next_State2);
        end
        
        % Sum together the expected state values
        V_heads = P_h * (gamma * v_value1);
        V_tails = (1 - P_h) * (gamma * v_value2); % Cannot receive reward from a loss
        V(1,i) = V_heads + V_tails; % Add Values Together
    end
    
    % Pull out max values
    [Expected_Value,Index] = max(V); % Pull out max value and location index
    Policy_Value = actions(1,Index); % Pull out action
    
end