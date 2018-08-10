%% test_OctaveSerialSetup


clear; close all;
%% Params
comPort = 'COM3';

%% Load arduino with compiled code
sketchPath = fullfile('C:','Users','behaviour7','Documents','GitHub','OctaveBehaviorBooth',...
    'ArduinoHex','matlab_setup_test.ino.standard.hex');
[~,cmdOut] = loadArduinoSketch(comPort,sketchPath);
disp(cmdOut);

%% 
setupSerialOctave(comPort);