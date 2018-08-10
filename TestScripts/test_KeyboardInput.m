%% KeyboardInput
%
% Tests what the ESC key is bound to using the kbhit function.

clear; close all;
%%

isLoop = true;
while isLoop
  x = kbhit();
  disp(x)
  if x == 'x'
    isLoop = false;
  end
end
