function [speakers,recorders] = findPTBLynxSpeakers()
% devices = findPTBLynxSpeakers()
% 
% Finds speakers that use the Windows DirectSound API. Returns a struct 
% array with the same formatting as 'PsychPortAudio('GetDevices')';
%
% xd  8/14/18  wrote it

% Search for speaker devices by finding devices with the word 'Speakers' in 
% their name.
devs = PsychPortAudio('GetDevices');
speakerIdx = cellfun(@(X)~isempty(strfind(X,'Speakers')) && ~isempty(strfind(X,'Lynx')),...
  {devs(:).DeviceName},'UniformOutput',false);
speakerIdx = find(cell2mat(speakerIdx));

% Also finderrecording devices 
recorderIdx = cellfun(@(X)~isempty(strfind(X,'Record 01+02')) && ~isempty(strfind(X,'Lynx')),...
  {devs(:).DeviceName},'UniformOutput',false);
recorderIdx = find(cell2mat(recorderIdx));

% Find devices that use the MME API. Windows DirectSound has artifacts.
% This is the one we want to use to control the sound cards.
audioAPIs = unique({devs(:).HostAudioAPIName});
disp(audioAPIs);
selectedAPI = 'MME';
apiIdx = cellfun(@(X) ~isempty(strfind(X,selectedAPI)),{devs(:).HostAudioAPIName},'UniformOutput',false);
apiIdx = find(cell2mat(apiIdx));

% Keep only intersection between both lists, i.e. speakers using DirectSound.
speakerIdx = intersect(speakerIdx,apiIdx);
speakers = devs(speakerIdx);
speakers = fliplr(speakers);
recorders = devs(intersect(recorderIdx,apiIdx));
end