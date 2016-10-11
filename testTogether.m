function [acc,pre,rec,fst] = testTogether(type, notes)
%TESTTOGETHER 此处显示有关此函数的摘要
%   此处显示详细说明
    load(strcat(type,'Data.mat'))  
    load('nnParams.mat')
    output = predictTogether(Theta1, Theta2, X);
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

