function [acc,pre,rec,fst] = testTogether(type, notes)
%TESTTOGETHER �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
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

