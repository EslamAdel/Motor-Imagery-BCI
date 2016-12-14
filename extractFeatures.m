function featureSpace = extractFeatures (inSignal)

%% The Features are based on the energy of the signal E = Sum X^2

%Squaring The Signal
inSignal = inSignal.^2;

%Sum Now 
[n,c,t] = size(inSignal);
featureSpace = sum(inSignal,1);
featureSpace = reshape(featureSpace,c,t)';
end