function s = setupSerialOctave(comPort)
% s = setupSerialOctave(comPort)
% 
% Initialise serial port connection between Octave and Arduino. We check
% the connection by sending strings between the two via the serial buffer.
%
% Inputs:
%   comPort  -  A string that is the serial port name
% Outputs:
%   s        -  Octave serial object
%
% See https://octave.sourceforge.io/instrument-control/overview.html for
% more info about serial com functions in Octave.
%
% xd  8/XX/18  adapted from existing code in behavior repos and commented

%% Set up serial port parameters
s=serial(comPort);
set(s,'BaudRate', 9600);
set(s,'ByteSize',8);
set(s,'StopBits', 1);
set(s,'Parity','N');
set(s,'TimeOut',10);

%% Read signal from arduino
%
% Here we wait for the arduino to post a specific string to the serial
% buffer. This tells us that the arduino has loaded its program and has
% started running it.
a = 'b';
tries = 10;
while ~strcmp(a,'testing') && tries > 0
   a = serialReadOctave(s);
%   disp(a)
   tries = tries - 1;
end

if strcmp(a,'testing')
    disp('Serial data read');
end

%% Send signal to arduino
%
% Once we have read the signal from the arduino, we will send a return
% string to signal the arduino to run. Until then, it is paused in the
% setup() function of the Arduino code.
if srl_write(s,'a') 
  disp('Serial connection established');
end
  
endfunction
