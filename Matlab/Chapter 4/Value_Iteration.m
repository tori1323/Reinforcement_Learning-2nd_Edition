function[Det_Policy,V] = Value_Iteration(theta,terminal_states,s,P_h,gamma)
    
    % Initialize Variables
    state_length = length(s); % Number of non-terminal states
    v_old = zeros(1,state_length);
    V = zeros(1,state_length);
    Det_Policy = zeros(1,state_length);

    % Begin Loop
    Delta = 1; % Initialize Loop
    j = 1; % Initialize Index
    while Delta > theta
        v_old(:,:,1) = V(:,:,end); % Save new values as old values
        % Update state values and policy 
        for i = 1:state_length
            [V_Value,P_Value] = Decision_Iteration(V(:,:,j),terminal_states,P_h,i,gamma);
            V(1,i,j) = V_Value; % Update with new value
            Det_Policy(1,i) = P_Value; % Update with new value
        end
        Delta = max(abs(V(:,:,end) - v_old)); % Determine max difference
        j = j + 1; % Iterate + 1
        V(:,:,j) =  V(:,:,j-1); % Copy old values to new layer
    end
end