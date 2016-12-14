%% Loadig Dataset
load('dataset_BCIcomp1.mat');

%% Smapling Frequency in Hz 
Fs = 128;

%% Signal Length in Sec
T = 9;

%% Remove Cz channel
x_train(:,2,:) = [];

%% Crop the Signals
ti = 4;
tf = 8;
x_train = cropSignal(x_train, Fs, ti, tf);

%% Filter The Signals 
FL = 7.5;
FH = 15;
filterOrder = 3;
x_train = filterSignals(x_train, 'hamming', Fs, FL, FH, filterOrder);

%% Extract Features
featureSpace = extractFeatures(x_train);

%%Plot Feature Space
left  = featureSpace(:,:,find(y_train == 1));
right = featureSpace(:,:,find(y_train == 2));
scatter(left(:,1,:), left(:,2,:));
hold on 
scatter(right(:,1,:), right(:,2,:),"filled");