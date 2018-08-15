%% test_SoundIO
%
% This script test the input output of a sound card using a pure sine wave.

clear; %close all;
%%
io.fs = 192e3;
fs = io.fs;
io.ref_Pa=20e-6;
io.VperPa=0.316;
InitializePsychSound;
pause(1);
io.dur = 2;

%%

devs = PsychPortAudio('GetDevices');
speakerIdx = cellfun(@(X)~isempty(strfind(X,'Speakers (Lynx')) && ~isempty(strfind(X,'Lynx')),...
    {devs(:).DeviceName},'UniformOutput',false);
speakerIdx = find(cell2mat(speakerIdx));

recorderIdx = cellfun(@(X)~isempty(strfind(X,'Record 01+02 (Lynx E44)')) && ~isempty(strfind(X,'Lynx')),...
    {devs(:).DeviceName},'UniformOutput',false);
recorderIdx = find(cell2mat(recorderIdx));

% Devices
audioAPIs = unique({devs(:).HostAudioAPIName});
disp(audioAPIs);
selectedAPI = audioAPIs{3};
apiIdx = cellfun(@(X) ~isempty(strfind(X,selectedAPI)),{devs(:).HostAudioAPIName},'UniformOutput',false);
apiIdx = find(cell2mat(apiIdx));

speakerIdx = intersect(speakerIdx,apiIdx);
recorderIdx = intersect(recorderIdx,apiIdx);

%%
if ~strcmp(selectedAPI,'ASIO')
    io.s = PsychPortAudio('Open', devs(speakerIdx).DeviceIndex, 1, 3, io.fs, 1);
    io.r = PsychPortAudio('Open', devs(recorderIdx).DeviceIndex, 2, 3, io.fs, 1);
else
    io.d = PsychPortAudio('Open', [], 3, 3, io.fs, [1 1]);
    io.s = io.d;
    io.r = io.d;
end
%%
PsychPortAudio('GetAudioData', io.r, io.dur);

tone1 = tone(10000,1,io.dur,io.fs);
tone1 = envelopeKCW(tone1,5,io.fs)/11;

PsychPortAudio('FillBuffer', io.s, tone1); % fill buffer
%%

t.play = PsychPortAudio('Start', io.r, 1);
if ~strcmp(selectedAPI,'ASIO')
    t.play = PsychPortAudio('Start', io.s, 1);
end
WaitSecs(2);
[data, ~, ~, t.rec] = PsychPortAudio('GetAudioData', io.r);
% PsychPortAudio('Stop',io.r);

figure;
plot(data);
title(selectedAPI);
% figure;
% plot(tone1);

%%
PsychPortAudio('Close');