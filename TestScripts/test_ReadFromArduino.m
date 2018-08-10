%% test_ReadFromArduino
%
% This script sets up a serial communication link with the Arduino Uno and 
% attempts to read the Serial output from the 'setup()' function in the 
% Arduino code.

clear; close all;
%% Params
serialPort = 'COM3';

%% Load arduino with compiled code
sketchPath = fullfile('C:','Users','behaviour7','Documents','GitHub','OctaveBehaviorBooth',...
    'ArduinoHex','basic_serial_comm_test.ino.standard.hex');
[~,cmdOut] = loadArduinoSketch(serialPort,sketchPath);
disp(cmdOut);

%% Set up serial reader
s1 = serial(serialPort,9600);
set(s1,'TimeOut',10);

% Make 10 attempts to read from the serial buffer. If there is nothing
% there, stop.
a = readToTermination(s1,10);
disp(a)
