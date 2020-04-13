function [V_pi] = Policy_Evaluation(state_def,gamma,Policy,V_pi,theta,rental_reward,moving_cost,alt)
    
    delta = 1; % Intialize Loop
    while delta > theta
        v_old = V_pi; % Copy Values
        for i = 1:state_def
            for j = 1:state_def
                action = Policy(i,j); % Action to do next
                if alt == false
                    V_pi(i,j) = Rewards_Next_State(i,j,state_def,rental_reward,moving_cost,action,v_old,gamma);
                else
                    V_pi(i,j) = Rewards_Next_State_alt(i,j,state_def,rental_reward,moving_cost,action,v_old,gamma);
                end
            end
        end
        delta = max(abs(V_pi-v_old)); % Update the delta value
    end
end