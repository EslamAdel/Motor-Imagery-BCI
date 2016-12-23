function b = BPFIRFilter(N, FL,FH, Fs, windowType)
%% b = BPfirFilter(N, WL,WH, windowType)
% calculate filter coefficietions for band pass FIR filter
% input : 
% N : filter lenght or number of tabs
% FL : Lower frequency 
% FH : Upper frequency 
% Fs : Sampling Frequency 
% windowType : type of window 
% output : 
% b : filter Coefficients

%% Mid Point 
M = round((N-1)/2);

%% Convert to rad/sec and normalization.
WH = FH*2*pi/Fs;
WL = FL*2*pi/Fs;

%% Band Pass Filter h(n)
h1 = sin(WH*(-M:-1))./((-M:-1)*pi);
h1(M+1) = WH/pi;

% symmetry property
h1(M+2:N) = h1(M:-1:1);

h2 = sin(WL*(-M:-1))./((-M:-1)*pi);
h2(M+1) = WL/pi;

% symmetry property
h2(M+2:N) = h2(M:-1:1);

h = h1 - h2;

%% Select Window
switch windowType 
  case 'hanning'
  w = hanning(N);
  case 'hamming'
  w = hamming(N);
  case 'blackman'
  w = blackman(N);
  otherwise 
  error('window type not supported');
end 
%% Multiply Filter by the window function.
b = h .* w';
end 