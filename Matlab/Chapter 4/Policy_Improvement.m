function [policy_stable, Policy] = Policy_Improvement(Policy,state_def,V_pi,actions,gamma,rental_reward,moving_cost,n_actions,alt)
    
    % Initialize old_action
    old_action = Policy;
    
    % Update the Policy
    for i = 1:state_def
        for j = 1:state_def
            Policy(i,j) = Best_Action(V_pi,actions,gamma,rental_reward,moving_cost,i,j,state_def,n_actions,alt);
        end
    end
    
    % Test to see if new Policy is stable
    if old_action == Policy
        policy_stable = true;
    else
        policy_stable = false;
    end

end