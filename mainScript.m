%% Loadig Dataset
load('dataset_BCIcomp1.mat');

%% Smapling Frequency in Hz 
Fs = 128;

%% Sampling Period 
dt = 1/128;

%% Signal Length in Sec
T = 9;

%% Remove Cz channel
x_train(:,2,:) = [];

%% Crop the Signals 
x_train = cropSignal(x_train, Fs, 4, 8);

%% Filter The Signals 
FL = 7.5;
FH = 15;

x_train = filterSignals(x_train, 'hamming', Fs, FL, FH, 3);

trialNum = 120;
N = size(x_train,1);
f = 0:Fs/N:Fs/2-Fs/N;
fftC3 = fft(x_train(:,1,trialNum));
fftC4 = fft(x_train(:,2,trialNum));
plot(f,abs (fftC3(1:end/2)), 'r');
hold on
plot(f,abs (fftC4(1:end/2)), 'g');