function out = predictTogether(Theta1, Theta2, X)
m = size(X,1);
X = [ones(m,1) X];
a1 = sigmoid(X*Theta1');
a1 = [ones(m,1) a1];
out = sigmoid(a1*Theta2') > 0.5;
end

