function out = serialRead(s,n)
% out = serialRead(s,n)
%
% Wrapper for serialReadOctave.

if nargin < 2
  out = serialReadOctave(s);
else
  out = serialReadOctave(s,n);
end

endfunction