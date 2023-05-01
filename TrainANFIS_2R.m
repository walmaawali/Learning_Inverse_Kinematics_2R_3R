% Formatting the data for ANFIS
input = in_train';
theta1 = out_train(1,:)';
theta2 = out_train(2,:)';

% Generating two ANFIS, one for each "theta"
% Each ANFIS has 5 membership functions and will be trained for 100 epochs
%%% Hint: try to experiment with these values!
anfis1 = ANFIS(input, theta1, 5, 100);
anfis2 = ANFIS(input, theta2, 5, 100);

% Test the performance
theta1_predict = evalfis(anfis1,in_test');
theta2_predict = evalfis(anfis2, in_test');
theta1_true = out_test(1,:)';
theta2_true = out_test(2,:)';

% Plot theta1 VS theta2 for the desired output (Blue) and
% predicted output (Red)
figure
plot(theta1_true,theta2_true,'O', 'MarkerSize',8, 'MarkerFaceColor',"Blue")
hold on
plot(theta1_predict,theta2_predict,'O', 'MarkerSize',8, 'MarkerFaceColor',"Red")
legend('Target','ANFIS Output')
xlabel("Theta 1"), ylabel("Theta 2")

figure
[X_true, Y_true] = findXY(L1, L2, theta1_true, theta2_true);
[X_predict, Y_predict] = findXY(L1, L2, theta1_predict, theta2_predict);
plot(X_true, Y_true ,'O', 'MarkerSize', 8 ,'MarkerFaceColor',"Blue")
hold on
plot(X_predict, Y_predict,'O', 'MarkerSize', 8 ,'MarkerFaceColor',"Red")
legend('Target','ANFIS Output')
xlabel("X"), ylabel("Y")

% Compute Root-Mean-Squared-Error (RMSE). The lower, the better
disp("RMSE error is: ")
RMSE = sqrt(immse([theta1_predict theta2_predict], out_test'))

%%
% Configure and return an ANFIS
function out_fis = ANFIS(input, target, num_membership, num_epochs)
    foptions = genfisOptions('GridPartition');
    foptions.NumMembershipFunctions = num_membership;
    foptions.InputMembershipFunctionType = "gbellmf";
    x = input; y = target;
    in_fis  = genfis(x,y,foptions);
    options = anfisOptions;
    options.InitialFIS = in_fis;
    options.EpochNumber = num_epochs;
    out_fis = anfis([x,y],options);
end

%%
function [X,Y] = findXY(L1, L2, TH1, TH2)
    X = L1*cos(TH1)+L2*cos(TH1+TH2);
    Y = L1*sin(TH1)+L2*sin(TH1+TH2);
end