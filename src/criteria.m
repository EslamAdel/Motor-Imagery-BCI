function [maxITR, I, ERR]=criteria(d,c);
% CRITERIA returns the maximum of the mutual information [1]
% [maxITR, I, ERR ]=criteria(d,c);
%   d   output DATA (each row is one trial) 
%   c   CLASS, vector with 0 and 1 
%   I   time course of the mutual information
%   ERR time course of the error rate
%   maxMI maximum of the mutual information 
%   maxITR maximum of information transfer rate

% References:
% [1] Schlögl A., Neuper C. Pfurtscheller G.
% Estimating the mutual information of an EEG-based Brain-Computer-Interface
% Biomedizinische Technik 47(1-2): 3-8, 2002

%	Version 1.22
%	27 Nov 2002
%	Copyright (c) 1997-2002 by  Alois Schloegl
%	a.schloegl@ieee.org	

% Copyright (C) 1998-2002 Alois SCHLOEGL
%
% This library is free software; you can redistribute it and/or
% modify it under the terms of the GNU Library General Public
% License as published by the Free Software Foundation; either
% version 2 of the License, or (at your option) any later version.
%
% This library is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% Library General Public License for more details.
%
% You should have received a copy of the GNU Library General Public
% License along with this library; if not, write to the
% Free Software Foundation, Inc., 59 Temple Place - Suite 330,
% Boston, MA  02111-1307, USA.

c=c(:);
ntr=length(c);
[nr,nc]=size(d);

CL=unique(c);
if length(CL)~=2, 
        error('invalid class label');
end;

for k = 8:8:nc,
        td = reshape(d(:,k+(-7:0)),ntr*8,1);
        tc = reshape(c(:,ones(8,1)),ntr*8,1);
        
        % time course of the SNR+1, Mutual Information, and the Error rate [1]
        SNR8p1(k/8) = 2*var(td)./(var(td(tc==CL(1)))+var(td(tc==CL(2))));
        ERR8(k/8)   = 1/2 - mean(sign(td).*sign(tc-mean(CL)))/2;
end;
I8 = log2(SNR8p1)/2;


SNRp1 = 2*var(td)./(var(d(c==CL(1),:))+var(d(c==CL(2),:)));
ERR   = 1/2 - mean(sign(d).*sign(c(:,ones(1,nc))-mean(CL)))/2;
I     = log2(SNRp1)/2;


% sample rate of the dataset from Graz
Fs = 128; 
if length(I)==9*Fs;
        t8 = 4*Fs/8+1 : 9*Fs/8;
        maxMI = max(I8(t8));
        [maxITR8,tmp] = max(I8(t8)./(8*t8/Fs-3))
        t = 4*Fs+1 : 9*Fs;
        maxITR = max(I(t)./(t/Fs-3));
else
        maxMI  = max(I);
        maxITR = max(I./((1:length(I))/Fs-3));
end;

