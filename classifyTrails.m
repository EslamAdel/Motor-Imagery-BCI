function classVector  = classifyTrails (trainFeatures, trainClasses, testFeatures, k)
N  = size(testFeatures,1);
M  = size(trainFeatures, 1);
for i = 1:N
point = repmat(testFeatures(i,:),M,1);
distance = sum(sqrt((trainFeatures-point).^2),2);
leftCount = 0;
rightCount = 0;
maxVal = max(distance);
for j = 1:k
[minval, idx] = min(distance);
if(trainClasses(idx) == 1)
leftCount = leftCount + 1;
else 
rightCount = rightCount + 1;
end
distance(idx) = 100* maxVal;
end
if(leftCount > rightCount)
classVector(i) = -1*leftCount/k;
else
classVector(i) = rightCount/k;
end
end
end