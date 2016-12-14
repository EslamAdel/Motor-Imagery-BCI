function features = processData(inData, ti, tf, Fs, FL, FH, filterOrder);
%% Remove Cz channel
inData(:,2,:) = [];

%% Crop Signals
inData = cropSignal(inData,Fs, ti, tf);

%% Filter Data
inData = filterSignals(inData, 'hanning', Fs, FL, FH, filterOrder);

%% Extract Features
features = extractFeatures(inData);
end
