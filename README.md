# phase_amplitude_coupling
Calculates and plots phase amplitude coupling of neural time series data

This script (tested on Matlab 2018a) uses the Fieldtrip toolbox (Oostenveld et al. 2011). Analysis pipeline adapted from Tort et al. 2010 and https://github.com/tortlab

# Installation
Step 1: Download Fieldtrip from https://www.fieldtriptoolbox.org/download/

Step 2: Load example_code_pac.m in Matlab editor. This is an example script on how to calculate phase-amplitude-coupling (PAC) at each electrode  and can be used as a template. Code can also be modified to incorporate PAC across pairs of electrodes.

Step 3: Change Fieldtrip file path in example_code_pac.m
```
addpath /my fieldtrip software location here/fieldtrip folder name
```
Step 4: Change scripts file path in example_code_pac.m
```
path(path,genpath('my traveling wave scripts here/my scripts folder name'));
```
Step 5: Run example_code_pac.m

# Data description
Electrocorticigraphy (ECoG) dataset with 5 grid electrodes (data.label). Registered to Human Connectome Project atlas (data.label2). Data in Fieldtrip format.

Freqranges: Frequency bands for Hilbert transform according to Voytek et al. 2013.


