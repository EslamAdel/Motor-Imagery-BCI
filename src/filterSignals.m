function filteredSignal = filterSignals (inSignal, windowType, Fs, FL, FH)
%% filteredSignal = filterSignals (inSignal, windowType, Fs, FL, FH)
% Filter the signals to select desired frequency band in EEG signals
% FIR Bandpass filter is applied.
% input : 
% inSignal : input Signal
% windowType : type of window used in FIR filter design.
% Fs : sampling Frequency. 
% FL : lower corner frequency.
% FH : upper corner frequecny.
% output : 
% filteredSignal.

%% Get The Size of Signal
[N, numChannels, numTrials] = size(inSignal);

%% Check window type 
switch windowType 
  case 'hanning'
  lengthFactor = 3.1;
  case 'hamming'
  lengthFactor = 3.3;
  case 'blackman'
  lengthFactor = 5.5;
  otherwise 
  error('window type not supported');
end 

%% Get Length of filter
filterLenght = round(Fs*lengthFactor/abs(FH-FL));

%% Get Filter Coefficients
b = BPFIRFilter(filterLenght,FL, FH, Fs, windowType);

%% Apply Filter
filteredSignal = filter(b, 1, inSignal);

end