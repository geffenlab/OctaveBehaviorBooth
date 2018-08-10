%% test_OctaveSerialSetup
%
% This script tests the function 'setupSerialOctave'. That function uses
% strings to communicate with Arduino via the serial buffer. This tells
% Octave that the Arduino code has successfully loaded and is running.

clear; close all;
%% COM port name
comPort = 'COM3';

%% Load arduino with compiled code
sketchPath = fullfile('C:','Users','behaviour7','Documents','GitHub','OctaveBehaviorBooth',...
    'ArduinoHex','matlab_setup_test.ino.standard.hex');
[~,cmdOut] = loadArduinoSketch(comPort,sketchPath);
disp(cmdOut);

%% Run function
%
% This step tends to hang when something is not right. In fact, this test
% is somewhat poorly designed since the 'setupSerialOctave' function does
% not set an upper limit on tries for reading from the serial buffer so you
% cannot force exit using crtl-C in Octave. Need to use task manager if
% this happens.
setupSerialOctave(comPort);