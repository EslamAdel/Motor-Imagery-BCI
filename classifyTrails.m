function classVector  = classifyTrails (trainFeatures, trainClasses, testPoint, k)
[t, c, w] = size(trainFeatures);
distances = zeros(t,w);
for i = 1:w
trained = trainFeatures(:,:,i);
[dist, idx] = getDistance(trained, testPoint);
distances(:,i) = dist;
end
%leftCount = 0;
%rightCount = 0;
%maxVal = max(distance);
%for j = 1:k
%[minval, idx] = min(distance);
%if(trainClasses(idx) == 1)
%leftCount = leftCount + 1;
%else 
%rightCount = rightCount + 1;
%end
%distance(idx) = 100* maxVal;
%end
%if(leftCount > rightCount)
%classVector(i) = -1*leftCount/k;
%else
%classVector(i) = rightCount/k;
%end
%end
%end
% The MIT License (MIT)
%
% Copyright (c) 2016 Markus Bergholz
% https://github.com/markuman/fastKNN

function [classified, k, dist, idx] = classifyTrails(trained, unknown, k)
    [dist, idx] = getDistance(trained, unknown);    
    classified  = mode(trained(idx(1:k), end));
end 
function [values, idx] = getDistance(x, y)
    [values, idx] = sort (sum ( abs( (x(:,1:end-1) - y(ones(size(x,1),1), :) ) .^2), 2) .^ 0.5);
end

