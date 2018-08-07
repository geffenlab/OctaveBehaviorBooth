%% test_ReadFromArduino
%
% This script sets up a serial communication link with the Arduino Uno and 
% attempts to read the Serial output from the 'setup()' function in the 
% Arduino code.



clear; close all;
%% Load instrument-control
% We need this package to communicate with the Arduino via a serial port

pkg load instrument-control

%% Params
serialPort = 'COM3';

%% Load arduino with compiled code
sketchPath = fullfile('C:','Users','behaviour7','Documents','GitHub','2AFC-wheel','hexFiles','wheel_habituation.ino.hex');
[~,cmdOut] = loadArduinoSketch(serialPort,sketchPath);
disp(cmdOut);

%% Set up serial reader
s1 = serial(serialPort,9600);
set(s1,'TimeOut',10);

a = ReadToTermination(s1);
disp(a)

srl_write(s1,'a');

pause(3);
disp(ReadToTermination(s1))