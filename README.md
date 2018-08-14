# OctaveBoothTestingSuite

This repository contains code that implements serial communication between Octave and Arduino that mirrors code used in Matlab for behavioral experiments in the Geffen lab (as of 8/10/2018). There are also several test scripts included that may be considered 'demos' for when trying to convert code from Matlab to Octave. Not every script is guaranteed to be relevant. Code has been tested using Octave 4.0.3 x64.

### Usage
#### This repository
This repository is organized as follows:
* `ArduinoHex` - compiled binaries of Arduino scripts in `ArduinoSrc`. Octave sends these to the Arduino to run.
* `ArduinoSrc` - folders containing simple Arduino scripts
* `External`   - functions copied from other geffenlab repos for convenience
* `OctaveSerial` - functions that implement serial communication mirroring current Geffen lab Matlab functions
* `TestScripts` - scripts that implement simple tests of serial communication between Octave and Arduino. Need to be connected to an Arduino device.

In most use cases, only `OctaveSerial` and `External` need to be on your path.

#### Dependencies
The `instrument-control` package for Octave needs to be installed and loaded to run the code in this repo. This package can be found [here](https://octave.sourceforge.io/instrument-control/index.html).

One of the test scripts requires `Psychtoolbox3` to be installed. Specifically, it requires v3.0.13. See Octave install instructions below for more details.

### Octave install instructions
1. Download and install Octave 4.2.0 64bit. The official installer can be found [here](https://ftp.gnu.org/gnu/octave/windows/). Download the third link: `octave-4.2.0-w64-installer.exe`.
2. Download and install the `instrument-control` package ([link](https://octave.sourceforge.io/instrument-control/index.html)). Install by navigating to the directory where you downloaded the package and typing: `pkg install *filename*`, where *filename* is the name of the compressed file downloaded. You can check that the package was installed successfully by typing: `pkg load instrument-control`.
3. **Optional** You can set Octave to load the `instrument-control` toolbox on startup by typing: `edit '~/.octaverc'` and adding `pkg load instrument-control` to the file that is opened in the editor.

### PTB3 install instructions
1. Download and install the latest GStreamer package from [here](https://gstreamer.freedesktop.org/). Version 1.14.2 has been tested to work. **This is necessary to ensure PTB compatibility!**
2. Acquire the installation script from the Psychtoobox [website](https://raw.githubusercontent.com/Psychtoolbox-3/Psychtoolbox-3/master/Psychtoolbox/DownloadPsychtoolbox.m). Copy this .m file somewhere and navigate to it in Octave. Then run: `DownloadPsychtoolbox(*dir*)` where *dir* is the directory in which PTB3 should be installed. Not that *dir* needs to be a full file path. The latest Psychtoolbox should work with Octave 4.2.0 x64. 
