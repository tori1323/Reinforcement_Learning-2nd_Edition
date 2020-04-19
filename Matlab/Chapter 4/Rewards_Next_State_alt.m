function[V_Value] = Rewards_Next_State_alt(i,j,state_def,rental_reward,moving_cost,action,v_old,gamma)
    
    % Alternative code for the Exercise # 4.7
    % Changes made to account for nice employee and charge for > 10 cars
    % Remain dynamics of system are unchanged

    V_Value = 0; % Initalize value
    
    % Initialize expected values
    lambda_r1 = 3; % Location 1 request
    lambda_r2 = 4; % Location 2 request
    lambda_t1 = 3; % Location 1 return
    lambda_t2 = 2; % Location 2 return
    
    % Generate random probabilities for n expected
    n1_request = poisspdf((0:state_def),lambda_r1);
    n2_request = poisspdf((0:state_def),lambda_r2);
    n1_return = poisspdf((0:state_def),lambda_t1);
    n2_return = poisspdf((0:state_def),lambda_t2);
    
    % Since 0 cars start at i = 1 >> Adjust 
    i = i - 1;
    j = j - 1;
    
    % Start Loop
    for R_Location1 = 0:(state_def-1)
        for R_Location2 = 0:(state_def-1)
            for Returns1 = 0:(state_def-1)
                for Returns2 = 0:(state_def-1)
                    % Update new location based off of action
                    location1 = i - action;
                    location2 = j + action; % Do the opposite of location 1
                    
                    % Remove excess cars from inventory
                    if location1 > (state_def - 1)
                        location1 = (state_def - 1);
                    end
                    
                    if location2 > (state_def - 1)
                        location2 = (state_def - 1);
                    end
                    
                    % Requests for day
                    if R_Location1 > location1
                        Requests_True1 = location1; % Cannot rent out more than have
                    else
                        Requests_True1 = R_Location1;
                    end
                    
                    if R_Location2 > location2
                        Requests_True2 = location2; % Cannot rent out more than have
                    else
                        Requests_True2 = R_Location2;
                    end
                    
                    % Update Car Numbers
                    location1 = location1 - Requests_True1;
                    location2 = location2 - Requests_True2;
                    
                    % Returns for Day
                    location1 = location1 + Returns1;
                    location2 = location2 + Returns2;
                    
                    % Remove Access Cars
                    if location1 > (state_def - 1)
                        location1 = (state_def - 1);
                    end
                    
                    if location2 > (state_def - 1)
                        location2 = (state_def - 1);
                    end
                    
                    % Determine Profit for Day
                    Profit = (Requests_True1 + Requests_True2) * rental_reward;
                    
                    % Kind Employee who moves one free car
                    if action > 0
                        action = action - 1; % One free move from Location 1 to 2
                    end
                    
                    % Cost of Moving Each Car
                    Costs = abs(action) * moving_cost;
                    
                    % Extra cost for more than 10 cars per location
                    if R_Location1 > 10
                        Costs = Costs - 4;
                    end
                    
                    if R_Location2 > 10
                         Costs = Costs - 4;
                    end
                        
                    
                    % Total Reward
                    Reward = Profit + Costs;
                    
                    % Multiply probabilities together to get total
                    Prob_request = n1_request(1,(R_Location1+1)) * n2_request(1,(R_Location2+1));
                    Prob_return = n1_return(1,(Returns1+1)) * n2_return(1,(Returns2+1));
                    Prob = Prob_request * Prob_return;
                    
                    % Update the new V
                    V_Value = V_Value + (Prob * (Reward + (gamma * v_old((location1+1),(location2+1)))));
                end
            end
        end
    end
end