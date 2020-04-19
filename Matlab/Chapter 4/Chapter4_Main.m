%% Chapter 4 - Dynamic Programming
% Victoria Nagorski - Main Script Ch 4

%% Example 2.16
clear;close all;clc;
% Define Variables
rental_reward = 10; % $/car rented
moving_costs = -2; % $/car moved at night
max_location = 20; % Cars allowed in one location
gamma = 0.9; % Discount rate
theta = 10^-30; % Error
actions = (-5:5); % Vector of possible actions
state_vector = (0:max_location); % Possible States
alt = false; % Example Dynamics

[V_pi, Policy] = Policy_Iteration(rental_reward,moving_costs,state_vector,gamma,theta,actions,alt);

figure(1)
hold on
pcolor(state_vector,state_vector,Policy)
title('Policy')
ylabel('Location 1')
xlabel('Location 2')
colorbar
hold off

figure(2)
surf(state_vector,state_vector,V_pi)
title('State Values')
ylabel('Location 1')
xlabel('Location 2')
colorbar
axis ij


%% Exercise 4.7
clear;close all;clc;
% Define Variables
rental_reward = 10; % $/car rented
moving_costs = -2; % $/car moved at night
max_location = 20; % Cars allowed in one location
gamma = 0.9; % Discount rate
theta = 10^-30; % Error
actions = (-5:5); % Vector of possible actions
state_vector = (0:max_location); % Possible States
alt = true; % Exercise Dynamics

[V_pi, Policy] = Policy_Iteration(rental_reward,moving_costs,state_vector,gamma,theta,actions,alt);

figure(1)
hold on
pcolor(state_vector,state_vector,Policy)
title('Policy')
ylabel('Location 1')
xlabel('Location 2')
colorbar
hold off

figure(2)
surf(state_vector,state_vector,V_pi)
title('State Values')
ylabel('Location 1')
xlabel('Location 2')
colorbar
axis ij


%% Exercise 4.9
clear;close all;clc;
% Define Variables for both parts
theta = 10^-30; % Error
s = (1:99); % States to take actions in
terminal_states = [0,100]; % If 0 capital end episode
gamma = 1; % Undiscounted

% PART A
P_h = 0.25; % Probability of heads

% Solve Problem
[Det_Policy,Value_Estimates] = Value_Iteration(theta,terminal_states,s,P_h,gamma);

% Plot Data
figure(1)
hold on
plot(s,Value_Estimates(:,:,1))
plot(s,Value_Estimates(:,:,2))
plot(s,Value_Estimates(:,:,3))
plot(s,Value_Estimates(:,:,5))
plot(s,Value_Estimates(:,:,25))
plot(s,Value_Estimates(:,:,end))
legend('Sweep 1','Sweep 2','Sweep 3','Sweep 5','Sweep 25','Final Sweep')
xlabel('Capital')
title('P_h = 0.25')
ylabel('Value Estimates')
hold off

figure(2)
hold on
title('Policy')
xlabel('Capital')
ylabel('Final Policy')
plot(s,Det_Policy)
hold off

% Clear some variabels before continuing
clearvars -except theta terminal_states s gamma 

% PART B
P_h = 0.55; % Probability of heads

% Solve Problem
[Det_Policy,Value_Estimates] = Value_Iteration(theta,terminal_states,s,P_h,gamma);

% Plot Data
figure(3)
hold on
plot(s,Value_Estimates(:,:,1))
plot(s,Value_Estimates(:,:,2))
plot(s,Value_Estimates(:,:,3))
plot(s,Value_Estimates(:,:,5))
plot(s,Value_Estimates(:,:,25))
plot(s,Value_Estimates(:,:,32))
plot(s,Value_Estimates(:,:,end))
legend('Sweep 1','Sweep 2','Sweep 3','Sweep 5','Sweep 25','Sweep 32','Final Sweep')
xlabel('Capital')
title('P_h = 0.55')
ylabel('Value Estimates')
hold off

figure(4)
hold on
title('Policy')
xlabel('Capital')
ylabel('Final Policy')
plot(s,Det_Policy)
hold off