function [acc,pre,rec,fst] = testAll(type, notes)
    load(strcat(type,'Data.mat'))  
    load('nnParamsStochastic.mat')
    output = predict(theta1, theta2, X);
    m = size(X,1);
    passed = 0;
    for i = 1:m
        if(output(i,:) == y(i,notes))
            passed = passed + 1;
        end
    end
    acc = passed/m;
    pre = 0;
    rec = 0;
    fst = 0;
end