clc;
clear;
close all;
%% Loadig Dataset
load('dataset_BCIcomp1.mat');

%% Smapling Frequency in Hz 
Fs = 128;

%% Signal Length in Sec
T = 9;

%% Crop the Signals
ti = 3;
tf = 9;

%% Filter The Signals 
FL = 7.5;
FH = 15;
filterOrder = 4;

%% --------------- Training Stage ----------
trainFeatures = processData(x_train,ti, tf, Fs, FL, FH, filterOrder);
%%Plot Feature Space
trainLeft  = trainFeatures(find(y_train == 1),:);
trainRight = trainFeatures(find(y_train == 2),:);
scatter(trainLeft(:,1), trainLeft(:,2));
hold on 
scatter(trainRight(:,1), trainRight(:,2),"filled");
title('The Feature Space of Training Data');
legend('left', 'right');
%% -------------------------------------------

%% ----------------- Testing Stage -------------
%% Classification
k = 3;
w = 128;
x_test(:,2,:) = [];
x_test = cropSignal(x_test, Fs, ti, tf);
filteredSignal = filterSignals(x_test,'hanning',Fs, FL, FH, filterOrder);
idx = 1;
for i = 1:(tf-ti-1)*Fs
signalsWindow = filteredSignal(i:i+w,:,:);
dataFeatures = extractFeatures(signalsWindow);
classes = classifyTrails(trainFeatures, y_train, dataFeatures, k);
outputData(:,idx) = classes;
idx++;
end
finalClasses = zeros(140,1);
for i = 1:140
neg = length(find(outputData(i,:) == -1));
pos = length(find(outputData(i,:) == 1));
if neg > pos
finalClasses(i) = 1;
else 
finalClasses(i) = 2;
end
end
[maxITR, I, ERR]=criteria(outputData, finalClasses);

figure,
plot(abs(I),'b');
hold on
plot(ERR, 'r');
legend('MI', 'ERR');
