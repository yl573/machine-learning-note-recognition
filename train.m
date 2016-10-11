function train( notes , cont)
%TRAIN 此处显示有关此函数的摘要
%   此处显示详细说明

input_layer_size  = 88;  % harmonics
hidden_layer_size = 300;   % hidden units
num_labels = size(notes,2); % output

%{
arr = {'Marriagedamour','acommeamour','chpn_op7_1','chpn_op7_2_format0','chpn_op10_e01_format0','chpn_op10_e05_format0','chpn_op10_e12_format0'};

arr = {'chpn_op10_e12_format0'};

[X,y] = prepareMidiTraining([char(arr(1)), '.mid'],[char(arr(1)), '.mp3']);
for a = 2:size(arr,2)
    [Xt,yt] = prepareMidiTraining([char(arr(a)), '.mid'],[char(arr(a)), '.mp3']);
    X = [X;Xt];
    y = [y;yt];
end

fprintf('Size X and y');
size(X)
size(y)
%}
load('trainingData.mat')

if cont == false
    initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
    initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
    initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];
else
    load('nnParams.mat')
    initial_nn_params = [Theta1(:) ; Theta2(:)];
end

%%Training
options = optimset('MaxIter', 100);

lambda = 0;
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y(:,notes), lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
             
save 'nnParams.mat' 'Theta1' 'Theta2';

end

