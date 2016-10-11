function trainTogetherStochastic(notes, cont)

input_layer_size  = 88;  % harmonics
hidden_layer_size = 300;   % hidden units
num_labels = size(notes,2); % output


load('trainingData.mat')

if cont == false
    initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
    initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
    nn_params = [initial_Theta1(:) ; initial_Theta2(:)];
else
    load('nnParams.mat')
    nn_params = [Theta1(:) ; Theta2(:)];
end

rep = 10;
m = size(X,1);
interval = 100;

%%Training

alpha = 0.1;
lambda = 0;
cost = zeros(rep*floor(m/interval),1);
total = 0;
for j = 1:rep
    fprintf('iteration %d\n',j);
    for i = 1:m
        [J, grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X(i,:), y(i,notes), lambda);

        nn_params = nn_params - alpha * grad;
        if rem(i,interval) == 0
            cost(j*floor(i/interval)) = total/interval;
            total = 0;
        else
            %if ~isnan(J)
                total = total + J;
            %end     
        end
    end
    plot(1:rep*floor(m/interval),cost);
    
    
end




Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
             
save 'nnParams.mat' 'Theta1' 'Theta2';

end

