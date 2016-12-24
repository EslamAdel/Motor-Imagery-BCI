function pointClass  = classifyTrails (trainFeatures, trainClasses, testPoint, k)
%% pointClass  = classifyTrails (trainFeatures, trainClasses, testPoint, k)
% determine the class of the input point according to the output of 
% training stage
% inputs : 
% trainFeatures : a matrix with the energy of C3 and C4 of x_train 
%                 its size is number of trials x 2 x number of windows
% trainClasses : the class of each train it is actually y_train
% testPoint : Energy of window from test data.
% k : number of neighbours for KNN

%% Get Size of feature space
[t, c, w] = size(trainFeatures);

%% Initialize distance matrix
distances = zeros(t,w);

%% Calculate distance from all points in feature space
for i = 1:w
  trained = trainFeatures(:,:,i);
  distances(:,i) = sum((trained - testPoint).^2, 2) .^ 0.5;
end

%% Sort distances and select min K ones 
[dist, idx] = sort(distances(:));
classesIdx = idx(1:k)-1;
classesIdx = mod(classesIdx,t)+1;

%% Get the most frequent class 
[c, f] = mode(trainClasses(classesIdx(1:k),end));

%% Classification is as follow 
% the sign negative, and positive for class left, and right
% respectly and the value is for the confidence of classification 
if c == 1
 pointClass = -1*f/k;
else
 pointClass = f/k;
end 
end
