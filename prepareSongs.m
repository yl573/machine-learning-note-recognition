function prepareSongs()
%TRAINSONGS 此处显示有关此函数的摘要
%   此处显示详细说明

arr = {'Marriagedamour','acommeamour','chpn_op7_1','chpn_op7_2_format0','chpn_op10_e01_format0','chpn_op10_e05_format0','chpn_op10_e12_format0'};

%arr = {'chpn_op10_e12_format0'};

[X,y] = prepareMidiTraining([char(arr(1)), '.mid'],[char(arr(1)), '.mp3']);
for a = 2:size(arr,2)
    [Xt,yt] = prepareMidiTraining([char(arr(a)), '.mid'],[char(arr(a)), '.mp3']);
    X = [X;Xt];
    y = [y;yt];
end

fprintf('Size X and y');
size(X)
size(y)

randOrder = randperm(size(X,1));
X = X(randOrder,:);
y = y(randOrder,:);
dataLength = size(X,1);
numTrain = floor(dataLength * 0.8);
p = randperm(dataLength);
X = X(p,:);
y = y(p,:);
Xtrain = X(1:numTrain,:);
ytrain = y(1:numTrain,:);
Xtest = X(numTrain+1:end,:);
ytest = y(numTrain+1:end,:);
X = Xtrain;
y = ytrain;
save 'trainingData.mat' 'X' 'y'
X = Xtest;
y = ytest;
save 'testData.mat' 'X' 'y'
end

