clc;
clear;
close all;

%% Loadig Dataset
load('dataset_BCIcomp1.mat');

%% Smapling Frequency in Hz 
Fs = 128;

%% Signal Length in Sec
T = 9;

%% Desired interval
ti = 3;
tf = 9;

%% Filter Specs  
FL = 5;
FH = 15;
windowType = 'blackman';

%% --------------- Training Stage ----------

trainFeatures = processData(x_train,ti, tf, Fs, FL, FH, windowType);
 %%Plot Feature Space
 trainLeft  = trainFeatures(find(y_train == 1),:,:);
 trainRight = trainFeatures(find(y_train == 2),:,:);
 
 xL = trainLeft(:,1,:);
 yL = trainLeft(:,2,:);
 
 leftClass = [xL(:) yL(:)];
 plot(leftClass(:,1), leftClass(:,2),'ro','linewidth',1.5);
 hold on 
 
 xR = trainRight(:,1,:);
 yR = trainRight(:,2,:);
 
 rightClass = [xR(:) yR(:)];
 plot(rightClass(:,1), rightClass(:,2),'bo','linewidth',1.5);
 title('The Feature Space of Training Data');
 xlabel('Energy of C3'), ylabel('Energy of C4');
 legend('left', 'right');

%% -------------------------------------------

%% ----------------- Testing Stage -------------
%% Classification
k = 7;
w = Fs;
testFeatures = processData(x_test,ti, tf, Fs, FL, FH, windowType);
[trials, channels, numWindows] = size(testFeatures);
dataOutput = zeros(trials, numWindows);
for i = 1:trials
for j = 1:numWindows
point = testFeatures(i,:,j);
class = classifyTrails(trainFeatures, y_train, point,k);
dataOutput(i,j) = class;
end 
end 

finalClass = mode(dataOutput,2);
finalClass(find(finalClass > 0)) = 2;
finalClass(find(finalClass < 0)) = 1;



