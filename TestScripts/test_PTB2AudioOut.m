%% test_PTB2AudioOut
%
% This script tries to play audio to two different sound cards using the
% PTB audio functions. Needs to have 2 Lynx cards installed and two
% speakers attached to relevant outputs. This script assumes both speakers
% are attached to the CH1 out of the respective audio cards.

clear; close all;
%%

% Initialize the PTB audio
InitializePsychSound;

% Get device names from PTB. This returns a struct array of information
% about audio devices attached to this computer. The speakers will contain
% the string 'Speakers' in the 'DeviceName' field. We find the relevant
% device indices so that we can open them in PTB. This will find all
% speakers on the machine, so we will cross-reference with 'Lynx'.
devs = PsychPortAudio('GetDevices');
speakerIdx = cellfun(@(X)~isempty(strfind(X,'Speakers')) && ~isempty(strfind(X,'Lynx')),...
  {devs(:).DeviceName},'UniformOutput',false);
speakerIdx = find(cell2mat(speakerIdx));

% This above might result in multiple results, as each speaker will be
% listed once per audio API. We can select to use a specific API by doing a
% search like above and then looking at the common elements between the two
% results.
audioAPIs = unique({devs(:).HostAudioAPIName});
disp(audioAPIs);
selectedAPI = audioAPIs{3};
apiIdx = cellfun(@(X) ~isempty(strfind(X,selectedAPI)),{devs(:).HostAudioAPIName},'UniformOutput',false);
apiIdx = find(cell2mat(apiIdx));

speakerIdx = intersect(speakerIdx,apiIdx);

%% Create audio tones to test the outputs
fs = 192000;
tone1 = tone(800,3/2*pi,2,fs);
tone1 = envelopeKCW(tone1,5,fs);

tone2 = tone(300,3/2*pi,2,fs);
tone2 = envelopeKCW(tone2,5,fs);

%% Open speakers via PTB and play sound
s1 = PsychPortAudio('Open',devs(speakerIdx(1)).DeviceIndex,1,3,fs,1);
s2 = PsychPortAudio('Open',devs(speakerIdx(2)).DeviceIndex,1,3,fs,1);

% Preload audio into buffers. Each row is an audio channel.
PsychPortAudio('FillBuffer', s1, tone1);
PsychPortAudio('FillBuffer', s2, tone2); 

% Play audio
PsychPortAudio('Start',s1,1);
PsychPortAudio('Start',s2,1);