function trainStochastic(notes, cont)
%TRAINSTOCHASTIC 此处显示有关此函数的摘要
%   此处显示详细说明
input_layer_size  = 88;  % harmonics
hidden_layer_size = 30;   % hidden units
num_labels = 1;
%num_labels = size(notes,2);  % output


rep = 5;
load('trainingData.mat')
m = size(X,1);
interval = m;
n = size(notes,2);
theta1 = zeros(hidden_layer_size, (input_layer_size + 1), n);
theta2 = zeros(num_labels, (hidden_layer_size + 1), n);

if cont == 0
    initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
    initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
    nn_params = repmat([initial_Theta1(:) ; initial_Theta2(:)], 1, n);
else
    load('nnParamsStochastic.mat');
    for i = 1:n
        nn_params(:,:,i) = [reshape(theta1(:,:,i),hidden_layer_size * (input_layer_size + 1), 1),...
        reshape(theta2(:,:,i),(1 + (hidden_layer_size * (input_layer_size + 1))), 1)];
    end
end

alpha = 1;
lambda = 0;
cost = zeros(rep*floor(m/interval),1);
total = 0;
for j = 1:rep
    fprintf('iteration %d\n',j);
    for i = 1:m
        for k = 1:n
            [J, grad] = nnCostFunction(nn_params(:,k), ...
                                       input_layer_size, ...
                                       hidden_layer_size, ...
                                       num_labels, ...
                                       X(i,:), y(i,notes(k)), lambda);

            nn_params(:,k) = nn_params(:,k) - alpha * grad;
            if rem(i,interval) == 0
                cost(j*floor(i/interval)) = total/interval;
                total = 0;
            else
                total = total + J;
            end
            
        end
    end
    %plot(1:rep*floor(m/interval),cost);
end

for i = 1:n
    theta1(:,:,i) = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1), i), ...
        hidden_layer_size, (input_layer_size + 1));
    theta2(:,:,i) = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end, i), ...
        num_labels, (hidden_layer_size + 1));
end


save 'nnParamsStochastic.mat' 'theta1' 'theta2';

end

