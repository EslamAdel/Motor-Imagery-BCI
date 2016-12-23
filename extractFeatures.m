function featureSpace = extractFeatures (inSignal)
%% Extract Features base on the energy of input signal 
% 1 - normalize the niput input signals => 
%     (signal - min*signal)/(max(signal) - min(signal))
% 2 - Calculate the energy of the signal : E = Sum X^2
% input : signal of size signal length x number of channels x number of trails
% output : feature Space of size  number of channels x number of trails

%% Get Signal Size 
[n,c,t] = size(inSignal);

%% Noralize Signal 
inSignal = (inSignal-min(inSignal(:)))./(max(inSignal(:))-min(inSignal(:)));

%Squaring The Signal
inSignal = inSignal.^2;

%Sum Now 
featureSpace = sum(inSignal,1);

%Reshape the feature space 
featureSpace = reshape(featureSpace,c,t)';
end