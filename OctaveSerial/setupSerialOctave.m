function s = setupSerialOctave(comPort)
% s = setupSerialOctave(comPort)
% 
% Initialise serial prot connection between matlab and arduino and chech
% the connection

%% Set up serial port parameters
s=serial(comPort);
set(s,'BaudRate', 9600);
set(s,'ByteSize',8);
set(s,'StopBits', 1);
set(s,'Parity','N');
set(s,'TimeOut',10);

%% Send signal to arduino
%
% Once we have read the signal from the arduino, we will send a return
% string to signal the arduino to run. Until then, it is paused in the
% setUp() function of the Arduino code.
srl_write(s,'a') 
disp('Serial connection established');

%% Read signal from arduino
%
% Here we wait for the arduino to post a specific string to the serial
% buffer. This tells us that the arduino has loaded its program and has
% started running it.
a = 'b';
tries = 10;
while strcmp(a,'start') && tries > 0
   a = serialReadOctave(s);
   disp(a)
   tries = tries - 1;
end

if strcmp(a,'a')
    disp('Serial connection read')
end


endfunction
