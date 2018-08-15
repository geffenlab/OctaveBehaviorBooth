%% test_daqIO
%
% ONLY WORKS IN MATLAB
function test_daqIO
clear; close all;
%%


speakerName = 'Speakers (Lynx';
recorderName = 'Record 01+02 (Lynx E44)';

devs = daq.getDevices;

fs = 192e3;
sind = find(contains({devs.Description},speakerName));
sdev = devs(sind);
rind = find(contains({devs.Description},recorderName));
rdev = devs(rind);

s = daq.createSession('directsound');
r = daq.createSession('directsound');
sch = addAudioOutputChannel(s,sdev.ID,1);
rch = addAudioInputChannel(r,rdev.ID,1);
s.Rate = fs;
r.Rate = fs;

tone1 = tone(1000,1,10,fs);
tone1 = envelopeKCW(tone1,5,fs)/11;

r.IsContinuous = true;

queueOutputData(s,tone1');

hf = figure;
hp = plot(zeros(1000,1));
T = title('Discrete FFT Plot');
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
grid on;

plotFFT = @(src, event) continuous_fft(event.Data, src.Rate, hp);
hl = addlistener(r, 'DataAvailable', plotFFT);
startBackground(s);
startBackground(r);
pause(10);
stop(s);
stop(r);
s.IsContinuous = false;

end

function continuous_fft(data, Fs, plotHandle)
% Calculate FFT(data) and update plot with it. 

lengthOfData = length(data);
nextPowerOfTwo = 2 ^ nextpow2(lengthOfData); % next closest power of 2 to the length

plotScaleFactor = 4;
plotRange = nextPowerOfTwo / 2; % Plot is symmetric about n/2
plotRange = floor(plotRange / plotScaleFactor);

yDFT = fft(data, nextPowerOfTwo); % Discrete Fourier Transform of data

h = yDFT(1:plotRange);
abs_h = abs(h);

freqRange = (0:nextPowerOfTwo-1) * (Fs / nextPowerOfTwo);  % Frequency range
gfreq = freqRange(1:plotRange);  % Only plotting upto n/2 (as other half is the mirror image)

set(plotHandle, 'ydata', abs_h, 'xdata', gfreq); % Updating the plot
set(plotHandle, 'ydata',data,'xdata',1:length(data));
drawnow; % Update the plot

end
