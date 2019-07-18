function out = serialReadOctave(s,n)
% out = serialReadOctave(s)
%
% Takes in an Octave serial port object and reads until seeing a
% termination character. If the serial buffer is empty, this function will
% loop until a nonempty character is presented. Alternatively, include an
% optional 2nd argument to tell this function how many attempts to make at
% reading from the serial buffer before giving up. A successful attempt is
% when a non-NULL string is read from the serial buffer.
%
% Inputs:
%   s - Octave serial object
%   n - number of attempts to read from the serial buffer
%
% Outputs:
%   out - string read from serial buffer. Will return an empty string if
%         n is provided and no attempt at reading from the serial port
%         succeeds
%
% xd  8/XX/18  commented and cleaned up

%% Check for number of inputs
if nargin < 2
    n = -1;
end

%% Read from serial buffer
[char_out,int_out] = readToTermination(s);
while all(int_out == 1)
    [char_out,int_out] = readToTermination(s);  
    n = n - 1;
    
    % Since n is initialized to equal -1 if no second input provided, it
    % will never reach 0 and break the loop.
    if n == 0
        out = '';
        return;
    end
    
    
end

% Proper exit, so assign the serial string to the output
out = char_out;

endfunction