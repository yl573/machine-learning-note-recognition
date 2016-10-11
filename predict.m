function out = predict(Theta1, Theta2, X)
n = size(Theta1,3);
m = size(X,1);
X = [ones(m,1) X];
out = zeros(m,n);
for i = 1:n
    a1 = sigmoid(X*Theta1(:,:,i)');
    a1 = [ones(m,1) a1];
    out(:,i) = sigmoid(a1*Theta2(:,:,i)') > 0.5;
end
end

