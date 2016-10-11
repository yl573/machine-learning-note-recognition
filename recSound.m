% Record your voice for 1 seconds.
function result = recSound()
Fs = 20000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period 
time = 1;      
L = Fs*time;             % Length of signal
recObj = audiorecorder(Fs,8,1);
recordblocking(recObj, time);
raw = getaudiodata(recObj);
Y = fft(raw);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;


noteFreq = zeros(88,1)
for i = 1:88
    noteFreq(i) = 27.5 * (1.0594630943592952645618252949463 ^ (i-1));
end

P1(1:25*L/Fs) = 0;
k = 1;
harmonics = zeros(88,1);
maxAmp = 0;

% Has problem with the last harmonics, but this note is almost never played
for j = 1:size(P1)
    
    fLow = noteFreq(k);
    fHigh = noteFreq(k+1);
    fMid = (fHigh+fLow)/2;
    if f(j) >= fMid
        harmonics(k) = maxAmp;
        maxAmp = 0;
        k = k + 1;
    end
    if k >= 88
        break;
    end
    if P1(j) > maxAmp
        maxAmp = P1(j);
    end      
end
[maxValue, maxIndex] = max(harmonics);
fprintf('largest harmonic is at %f\n', noteFreq(maxIndex));
harmonics = harmonics/maxValue;

plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

result = predictExample(harmonics');


end

