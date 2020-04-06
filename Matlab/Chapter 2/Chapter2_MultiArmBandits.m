%% Chapter 2 - Multi-arm Bandits
% Victoria Nagorski - Main Script Ch 2

%% Exercise 2.4
clear; close all; clc;

% Initialize Variables
epsilon = 0.1; % Greedy factor
n = 10; % Number of arms
steps = 1000; 
alpha = 0.1; % contant
std = [0,sqrt(0.01)]; % [Mean, Sigma]
runs = 2000; % Number of runs to average over
version = ["Average","Incremental","Const"];
location = 'moving';
type = 'version';

% Run Test-Bed
[final_rewards,final_actions] = k_bandit_testbed(epsilon,n,steps,version,location,std,type,runs,alpha);

% Plot Data
figure(1)
hold on
plot((1:steps),final_rewards(:,1))
plot((1:steps),final_rewards(:,2))
plot((1:steps),final_rewards(:,3))
legend('Sample Average','Incrementally','Alpha')
xlabel('Steps')
ylabel('Average Reward')
hold off

figure(2)
hold on
plot((1:steps),final_actions(:,1))
plot((1:steps),final_actions(:,2))
plot((1:steps),final_actions(:,3))
legend('Sample Average','Incrementally','Alpha')
xlabel('Steps')
ylabel('% Optimal Action')
hold off

%% Exercise 2.11
clear; close all; clc;

% Initialize Variables
n = 10; % Number of arms
steps = 500; 
std = [0,sqrt(0.01)]; % [Mean, Sigma]
runs = 100; % Number of runs to average over
points = 6; % How many points between points
start = (steps/2) + 1; % Where to start averaging the rewards

% Parameter Study Variables
epsilon = 2.^linspace(-7,-1,points);
alpha = 2.^linspace(-5,2,points);
c = 2.^linspace(-4,2,points);
Q_0 = 2.^linspace(-2,2,points);

% Initialize Rewards
final_rewards = zeros((steps/2),5);
rewards = zeros(points,5);

% Start Loop
for i = 1:points % Run through each point
    for k = 1:runs    
        % Algoritms
        [r1,~] = Action_Value(steps,std,n,'moving','Average',0.1,epsilon(i));
        [r2,~] = Action_Value(steps,std,n,'moving','Const',0.1,epsilon(i));
        [r3,~] = Gradient_Bandit(steps,std,n,'moving',alpha(i));
        [r4,~] = UCB(steps,std,n,'moving',c(i));
        [r5,~] = Optimistic(steps,std,n,'moving',Q_0(i),0); % Greedy Optimstic eps = 0

        % Save half of the values
        final_rewards(:,1) = final_rewards(:,1) + r1(1,(start:steps))';
        final_rewards(:,2) = final_rewards(:,2) + r2(1,(start:steps))';
        final_rewards(:,3) = final_rewards(:,3) + r3(1,(start:steps))';
        final_rewards(:,4) = final_rewards(:,4) + r4(1,(start:steps))';
        final_rewards(:,5) = final_rewards(:,5) + r5(1,(start:steps))';
    end
    
    % Average the outputs
    final_rewards = final_rewards./runs; 

    % Average the rewards
    rewards(i,1) = mean(final_rewards(:,1));
    rewards(i,2) = mean(final_rewards(:,2));
    rewards(i,3) = mean(final_rewards(:,3));
    rewards(i,4) = mean(final_rewards(:,4));
    rewards(i,5) = mean(final_rewards(:,5));
    
    % Empty final rewards for next iteration
    final_rewards = zeros((steps/2),5);
end

% Graphing
figure(3)
hold on
plot(epsilon,rewards(:,1)) % Average
plot(epsilon,rewards(:,2)) % Const
plot(alpha,rewards(:,3)) % Gradient
plot(c,rewards(:,4)) % UCB
plot(Q_0,rewards(:,5)) % Optimistic
legend('Action - Eps','Const - Eps','Gradient - Alpha','UCB - c','Optimistic - Q_0')
title('Parameter Study')
ylabel('Average Reward')
xlabel('Eps, Alpha, c, Q_0')
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'linear')
xlim([0,8])
hold off

