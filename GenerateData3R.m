% Run this code only ONCE!
clear
% Parameters of the robot
L1 = 5;
L2 = 3;
L3 = 2;
theta1 = 0:0.2:(pi/2);
theta2 = 0:0.2:(pi);
theta3 = 0:0.2:(pi/2);

% Generate data for 2R robot
[input,target] = generateData3R(L1,L2,L3,theta1,theta2,theta3);

% Split the data into training (80%) and testing (20%)
%%% Hint: try experimenting with the testing percentage
[in_train, out_train, in_test, out_test] = splitData(input,target,0.2);


%%
% Generate data for 2R robot using forward kinematics
% Inputs:
%   L1 - Length of first link
%   L2 - Length of 2nd link
%   Theta1 - Range of theta 1 values (1xN row vector)
%   Theta2 - Range of theta 2 values (1xN row vector)
%
% Output: 
%   input - Nx2 matrix with (X,Y) values of end-effector position
%   target - Nx2 matrix with (Theta1,Theta2) values used to reach (X,Y)
%
function [input,target] = generateData2R(L1, L2, Theta1, Theta2)
    [TH1,TH2] = meshgrid(Theta1,Theta2);
    x = L1*cos(TH1)+L2*cos(TH1+TH2);
    y = L1*sin(TH1)+L2*sin(TH1+TH2);
    input = [x(:),y(:)];
    target = [TH1(:),TH2(:)];
end

% Generate data for 3R robot using forward kinematics
% Inputs:
%   L1 - Length of first link
%   L2 - Length of 2nd link
%   L3 - Length of 3rd link
%   Theta1 - Range of theta 1 values (1xN row vector)
%   Theta2 - Range of theta 2 values (1xN row vector)
%   Theta3 - Range of theta 3 values (1xN row vector)
%
% Output: 
%   input - Nx2 matrix with (X,Y) values of end-effector position
%   target - Nx3 matrix with (Theta1,Theta2,Theta3) values used to reach (X,Y)
%
function [input,target] = generateData3R(L1, L2, L3, Theta1, Theta2, Theta3)
    [TH1,TH2,TH3] = meshgrid(Theta1,Theta2,Theta3);
    x = L1*cos(TH1)+L2*cos(TH1+TH2)+L3*cos(TH1+TH2+TH3);
    y = L1*sin(TH1)+L2*sin(TH1+TH2)+L3*sin(TH1+TH2+TH3);
    input = [x(:),y(:)];
    target = [TH1(:),TH2(:),TH3(:)];
end

% Split the data set into training/testing
%
% Inputs: 
%   input - Nx2 matrix with (X,Y) values of end-effector position
%   target - Nx2 or Nx3 matrix with "theta" values used to reach (X,Y)
%   percent_test - floating point number representing percentage of data
%   that will be used for testing. Example, if you want to split the data
%   into 70% training, 30% testing, then just input 0.3 in this field.
%
% Outputs:
%   x_train - feature dataset used for training
%   y_train - target dataset used for training
%   x_test - feature dataset used for testing
%   y_test - target dataset used for testing
%
function [x_train, y_train, x_test, y_test] = splitData(input, target, percent_test)
    rng(42)
    rand_arr = randperm(length(input));
    N = length(input);
    input_rand = []; target_rand = [];
    for k = 1:N
        input_rand(k,:) = input(rand_arr(k),:);
        target_rand(k,:) = target(rand_arr(k),:);
    end

    idx = floor(percent_test*N);
    x_test = input_rand(1:idx,:)';
    y_test = target_rand(1:idx,:)';
    x_train = input_rand(idx:N, :)';
    y_train = target_rand(idx:N, :)';

end