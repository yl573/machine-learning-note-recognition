function accuracy = testExample(X, y)
    load('nnParams.mat');
    output = predict(Theta1, Theta2, X);
    m = size(X,1);
    passed = 0;
    for i = 1:m
        if(output(i,:) == y(i,:))
            passed = passed + 1;
        end
    end
    accuracy = passed/m;
end
