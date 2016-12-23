function features = processData(inData, ti, tf, Fs, FL, FH, filterOrder);
%% Process input Data to Extract features 
% 1 - Remove Cz channel 
% 2 - Process Only Signal From t = 3 sec to t = 9 sec
% 3 - Get a window of 1 sec of the signal 
% 4 - Band pass Filter to extract mu band only.
% 5 - Extract Features of each window.
% 6 - update feature space
% input : 
% inData : original dataset (x_train and x_test)
% ti : starting time for processing 
% tf : ending time for processing 
% Fs : sampling frequency 
% FL : lower frequency of bandpass filter 
% FH : upper frequency 
% filterOrder : order of butterworth filter 
% output : 
% features : the extracted features of each window, features are the 
% energy of both C3 and C4 channels of each window.
% size of features Trials x 2 x Number of windows

%% Remove Cz channel
inData(:,2,:) = [];

%% Take Signals From t = 3 sec to t = 9 sec 
inData = inData(Fs*ti:Fs*tf,:,:);

%% Get size of data 
[signalLength,c,t] = size(inData);

%% window lengh = 1 sec 
windowLength = Fs;

%% Intialize features matrix
features = zeros(t,c,round(signalLength/windowLength));

%% Extract Features For each window of the signal
for i = 0:round(signalLength/windowLength)-1

  %% Check for last window to avoid error index
  if (i+1)*windowLength > signalLength
    sigTo = signalLength;
  else
    sigTo = (i+1)*windowLength;
  end
  
  %% Extract a window 
  subSignal = inData(i*windowLength+1:sigTo,:,:);
  
  %% Apply bandpass filter 
  subSignal = filterSignals(subSignal, 'hanning', Fs, FL, FH, filterOrder);
  
  %% Extract Features
  features(:,:,i+1) = extractFeatures(subSignal);
  end
end
