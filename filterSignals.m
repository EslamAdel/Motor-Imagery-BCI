function filteredSignal = filterSignals (inSignal, windowType, Fs, FL, FH, filterOrder)

%% Get The Size of Signal
[N, numChannels, numTrials] = size(inSignal);

%% Check window type 
if(windowType == 'hanning')
W = hanning(N);
elseif (windowType == 'hamming')
W = hamming(N);
else
error("not Supprted window for now");
end

%% Apply Windowing 
inSignal = inSignal.*W;

%% Use butterworth band pass filter.
[b, a] = butter(filterOrder, [2*FL/Fs, 2*FH/Fs]);

%% Apply Filter
filteredSignal = filter(b, a, inSignal);

end