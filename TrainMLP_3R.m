% Initalizing an MLP with 2 hidden layers each with 5 neurons
%%% Hint: Try experimenting with the number of neurons & hidden layer!
net = feedforwardnet([50 50 50]);
configure(net, in_train, out_train);

net.divideParam.trainRatio = 0.9; % training set [%]
net.divideParam.valRatio = 0.1; % validation set [%]
net.divideParam.testRatio = 0.000; % test set [%]

% Training the MLP
net = train(net, in_train, out_train);

% Test performance of MLP on the testing set
out_predict = net(in_test);
p = perform(net,out_test,out_predict);

% Plotting Theta1 VS Theta2 for the desired (Blue) 
% and predicted output (Red)

theta1_true = out_test(1,:);
theta2_true = out_test(2,:);
theta3_true = out_test(3,:);

theta1_predict = out_predict(1,:);
theta2_predict = out_predict(2,:);
theta3_predict = out_predict(3,:);

figure
plot3(theta1_true, theta2_true , theta3_true, 'O', 'MarkerSize', 8 ,'MarkerFaceColor',"Blue")
hold on
plot3(theta1_predict, theta2_predict, theta3_predict, 'O', 'MarkerSize', 8 ,'MarkerFaceColor',"Red")
legend('Target','MLP Output')
xlabel("Theta 1"), ylabel("Theta 2"), zlabel("Theta 3")

figure
[X_true, Y_true] = findXY(L1, L2, L3, theta1_true, theta2_true, theta3_true);
[X_predict, Y_predict] = findXY(L1, L2, L3, theta1_predict, theta2_predict, theta3_predict);
plot(X_true, Y_true ,'O', 'MarkerSize', 8 ,'MarkerFaceColor',"Blue")
hold on
plot(X_predict, Y_predict,'O', 'MarkerSize', 8 ,'MarkerFaceColor',"Red")
legend('Target','MLP Output')
xlabel("X"), ylabel("Y")

% Compute Root-Mean-Squared-Error (RMSE). The lower, the better
disp("RMSE error is: ")
RMSE = sqrt(immse(out_predict, out_test))

%%
function [X,Y] = findXY(L1, L2, L3, TH1, TH2, TH3)
    X = L1*cos(TH1)+L2*cos(TH1+TH2)+L3*cos(TH1+TH2+TH3);
    Y = L1*sin(TH1)+L2*sin(TH1+TH2)+L3*sin(TH1+TH2+TH3);
end