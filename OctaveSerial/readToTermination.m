function [char_array,int_array] = readToTermination(srl_handle,term_char)
% [char_array,int_array] = readToTermination(srl_handle,term_char)
%
% Reads data from the serial buffer until a specified termination character
% is encountered. term_char is an optional input. The default termination
% character is '\r'.
%
% Inputs:
%   srl_handle - Octave serial object 
%   term_char  - (Optional) Termination character to stop reading from
%                serial buffer
%
% Outputs:
%   char_array - String output from serial buffer
%   int_array  - Unconverted integers read from serial buffer
%
% Adapted from https://www.edn.com/Pdf/ViewPdf?contentItemId=4440674
%
% xd  8/XX/18  adapted from above and cleaned up

%% Check inputs
%
% parameter term_char is optional, if not specified
% then CR = '\r' = 13dec is the default.
if(nargin == 1)
    term_char = 13;
end

%% Read from buffer
not_terminated = true;
i = 1;
int_array = uint8(1);
while not_terminated
    % Read 1 byte at a time from the serial buffer.
    val = srl_read(srl_handle, 1);
    if(val == term_char)
        not_terminated = false;
    end
    
    % Sometimes val can be empty for some reason. This seems to occur at
    % line endings though, so this should not change functionality. Just
    % avoids the error when trying to assign an empty array to an array
    % entry.
    if isempty(val)
        not_terminated = false;
    else
        % Add char received to array
        int_array(i) = val;
        i = i + 1;
    end
end

% Remove LF and CR chars from int_array. These make string comparisons
% tricky and are just provide new line characters.
int_array(int_array == 10) = [];
int_array(int_array == 13) = [];

% Change int array to a char array and return a string
char_array = char(int_array);
endfunction
