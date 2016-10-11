function [X, y] = prepareMidiTraining(midifile, mp3file)
song = readmidi(midifile);
[stereo,Fs] = audioread(mp3file);
Mono = (stereo(:,1)+stereo(:,2))/2;

time = floor(size(Mono,1)/Fs)  
%sound(sample,Fs);
%time = 20;
m = (time-1)*10;
y = zeros(m, 88);
X = zeros(m, 88);
songduration = song;
songduration(:,6) = songduration(:,6) + songduration(:,7);
noteFreq = zeros(88,1);
for n = 1:88
    noteFreq(n) = 27.5 * (1.0594630943592952645618252949463 ^ (n-1));
end
for i = 0 : m
%====================== y part ============================================
    from = i/10;
    to = 1+i/10;

    period1 = onsetwindow(song,from,to,'sec');
    period2 = onsetwindow(songduration,from,to,'sec');
    temp = zeros(88,1);
    notes = union(period1(:,4)-20, period2(:,4)-20);
    for j = 1:size(notes,1)
        temp(notes(j)) = 1;
    end
    y(i+1,:) = temp';

%========================== X part ========================================
    a = int32(1+from*Fs);
    b = int32(to*Fs);
    sample = Mono(a:b);
    L = Fs;             % Length of signal
    Y = fft(sample);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;
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

    [maxValue, ~] = max(harmonics);
    harmonics = harmonics/maxValue;
    X(i+1,:) = harmonics';
end

end

