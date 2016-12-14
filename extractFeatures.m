function featureSpace = extractFeatures (inSignal)

%% The Features are based on the energy of the signal E = Sum X^2

%Squaring The Signal
inSignal = inSignal.^2;

%Sum Now 
featureSpace = sum(inSignal,1);
end