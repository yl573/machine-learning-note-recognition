function out = predictExample(X)
load('nnParams.mat');
m = size(X,1);
X = [ones(m,1) X];
a1 = sigmoid(X*Theta1');
a1 = [ones(m,1) a1];
out = sigmoid(a1*Theta2');
out = out > 0.5;
end

