function features = processData(inData, ti, tf, Fs, FL, FH, windowType, ... 
                                 windowLength, wStep);
%% features = processData(inData, ti, tf, Fs, FL, FH, windowType, ... 
%                                 windowLength, wStep);
% Process input Data to Extract features 
% 1 - Remove Cz channel 
% 2 - Process Only Signal From ti to tf.
% 3 - Get a window of windowLength (in seconds).
% 4 - Band pass Filter to extract mu band only.
% 5 - Extract Features of each window.
% 6 - update feature space
% input : 
% inData : original dataset (x_train or x_test)
% ti : starting time for processing. 
% tf : ending time for processing. 
% Fs : sampling frequency 
% FL : lower frequency of bandpass filter. 
% FH : upper frequency. 
% windowType : type of window for FIR filter design.
% windowLength: Length of window from signal in seconds.
% wStep : Step or jump for the window in seconds
% output : 
% features : the extracted features of each window, features are the 
% energy of both C3 and C4 channels of each window.
% size of features Trials x 2 x Number of windows

%% Remove Cz channel
inData(:,2,:) = [];

% convert step from seconds to actual number of samples
wStep = round(wStep*Fs);

if wStep  < 1 
    wStep = 1;
end

% convert windowLength from seconds to actual number of samples
windowLength = round(windowLength * Fs);

%% Take Signals From ti to tf
inData = inData(1+Fs*ti:Fs*tf,:,:);

%% Get size of data 
[signalLength,c,t] = size(inData);

%% Intialize features matrix
r = 1:wStep:signalLength-windowLength;
features = zeros(t,c,length(r));

idx = 0;
%% Extract Features For each window of the signal
for i = r(1:end)

  %% Check for last window to avoid error index
  sigFrom = i;
  if i+windowLength > signalLength
    sigTo = signalLength;
  else
    sigTo = i+windowLength;
  end
  range = sigFrom:sigTo;
  %% Extract a window 
  subSignal = inData(range,:,:);
  
  %% Apply bandpass filter 
  subSignal = filterSignals(subSignal, windowType, Fs, FL, FH);
  idx = idx + 1;
  
  %% Extract Features
  features(:,:,idx) = extractFeatures(subSignal);
  end
end
