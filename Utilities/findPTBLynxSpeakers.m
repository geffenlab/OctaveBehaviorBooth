function devices = findPTBLynxSpeakers()
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

% Find devices that use the MME API. Windows DirectSound has artifacts.
% This is the one we want to use to control the sound cards.
audioAPIs = unique({devs(:).HostAudioAPIName});
disp(audioAPIs);
selectedAPI = 'MME';
apiIdx = cellfun(@(X) ~isempty(strfind(X,selectedAPI)),{devs(:).HostAudioAPIName},'UniformOutput',false);
apiIdx = find(cell2mat(apiIdx));

% Keep only intersection between both lists, i.e. speakers using DirectSound.
speakerIdx = intersect(speakerIdx,apiIdx);
devices = devs(speakerIdx);

end