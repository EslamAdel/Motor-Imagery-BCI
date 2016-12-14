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
ti = 4;
tf = 8;

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
%% Extract Features of testing Data 
testFeatures = processData(x_test, ti, tf, Fs, FL, FH, filterOrder);

%% Classification
k = 3;
testClasses = classifyTrails(trainFeatures, y_train, testFeatures, k);