function croppedSignal = cropSignal (inSignal, Fs, ti, tf)
%% Get Startng and Ending indices
idx1 = Fs * ti;
idx2 = Fs * tf;

%% Crop The Signal
croppedSignal = inSignal(idx1:idx2,:,:);

end