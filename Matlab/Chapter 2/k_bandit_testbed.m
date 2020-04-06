function[final_rewards,final_actions] = k_bandit_testbed(eps,arms,steps,version,location,std,type,runs,alpha)
% Inputs:
    % - eps     : Greedy factor
    % - arms    : Number of arms on the bandit testbed
    % - steps   : How many steps for the bandit to take
    % - version : Which algorithm to use
    % - location: Stationary or moving?
    % - std     : Information to generation random standard deviation points
    % - type    : "version" or "epsilon"
    % - runs    : Average over steps
% Outputs:
    % - final_rewards: Final Rewards to Graph
    % - final_actions: Final Actions to Graph
    
    
% Start Code:
    % Initialize rewards and actions
    if strcmp(type,'version') == 1
        final_rewards = zeros(steps,length(version));
        final_actions = zeros(steps,length(version));
    elseif strcmp(type,'epsilon') == 1
        final_rewards = zeros(steps,length(eps));
        final_actions = zeros(steps,length(eps));
    else
        fprintf('Does not support')
    end
    
    % Begin Loop >> First Check if solving versions or epsilon
    if strcmp(type,'version') == 1 % If looking at versions
        for i = 1:length(version) % Run over the different versions
            if strcmp(version(i),'Average') == 1 || strcmp(version(i),'Const') == 1
                for k = 1:runs    
                    [r,o_a] = Action_Value(steps,std,arms,location,version(i),alpha,eps);
                    final_rewards(:,i) = final_rewards(:,i) + r';
                    final_actions(:,i) = final_actions(:,i) + o_a';
                end
            elseif strcmp(version(i),'Incremental') == 1
                for k = 1:runs
                    [r,o_a] = Incrementally(steps,std,arms,location,eps);
                    final_rewards(:,i) = final_rewards(:,i) + r';
                    final_actions(:,i) = final_actions(:,i) + o_a';
                end
            else
                % Do nothing
                fprintf('Library does not support version')
            end
        end
    % STILL TO BE BUILT IF NEEED::
    elseif strcmp(type,'epsilon') == 1 % If looking at Epsilons
        for i = 1:length(eps) % Run over the different epsilons
            if strcmp(version,'Average') == 1 
                for k = 1:runs
                    q = normal(std(1),std(2),1,arms); % The real reward
                    % TO BE BUILT
                end
            elseif strcmp(version,'Incremental') == 1
                for k = 1:runs
                    q = normal(std(1),std(2),1,arms); % The real reward
                    % TO BE BUILT
                end
            elseif strcmp(version,'Const') == 1
                for k = 1:runs
                    q = normal(std(1),std(2),1,arms); % The real reward
                    % TO BE BUILT
                end
            else
                % Do nothing
                fprintf('Library does not support version')
            end
        end
    else
        fprintf('Does not support')
    end
    
    % Average the outputs
    final_rewards = final_rewards./runs; 
    final_actions = final_actions./runs; 
end