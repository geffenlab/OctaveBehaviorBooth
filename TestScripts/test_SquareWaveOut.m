%% test_SquareWaveOut
%
% This script plays a square wave out of the audio device using PTB. Then,
% the user should manually measure the output using a oscilliscope so that
% we know what the input/output ratio is.

clear; close all;
%% 

InitializePsychSound;
devs = findPTBLynxSpeakers();
fs = 192e3;
s1 = PsychPortAudio('Open',devs(1).DeviceIndex,1,3,fs,2);


%%
stim = zeros(2,fs*1);
stim(:,1:end/2) = 1/11;
stim = repmat(stim,1,20);

%%
PsychPortAudio('FillBuffer', s1, stim);

% Play audio
PsychPortAudio('Start',s1,1);
WaitSecs(length(stim)/fs);

%%
PsychPortAudio('Close');