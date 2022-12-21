%% file path
restoredefaultpath
addpath /my fieldtrip software location here/fieldtrip folder name
ft_defaults
path(path,genpath('my traveling wave scripts here/my scripts folder name'));

%% user inputs
area_oi = 'LatTemp';
toi = [-.4 0];
pfreq = [7 12];
afreq = [60 200];

%% load data
load data.mat

%% define phase bins
nbin = 18; % number of phase bins
position=zeros(1,nbin); % this variable will get the beginning (not the center) of each phase bin (in rads)
winsize = 2*pi/nbin;
for j=1:nbin 
    position(j) = -pi+(j-1)*winsize; 
end

%% PAC for each unique area name
unique_labels = unique(data.label2(:, 3));
tic
for jitu =1:length(unique_labels)

%% select area of interest channels
choi = [];
choi =  find(strcmp(data.label2(:, 3), unique_labels{jitu}) == 1)
cfg = [] ;
cfg.channel =  ft_channelselection(choi, data);
cfg.latency = toi;
data_aoi = ft_selectdata(cfg, data); 

%% zero-mean time series
cfg = [];
cfg.demean          = 'yes';
cfg.baselinewindow  = 'all';

data_aoi_dm      = ft_preprocessing(cfg, data_aoi);
data_aoi_dm.label2 = data_aoi.label2;




PhaseFreqVector = frequencyranges(1:22, :); % phase vector is [4 30]
AmpFreqVector = frequencyranges; % amplitude vector is 4 200]

%% calculate comulodogram for each channel
parfor knj =1:size(data_aoi_dm.label  , 1)
    
    % average over trials
    tort_A1     = [];
    cfg = [];
    cfg.channel     = ft_channelselection(knj, (data_aoi_dm.label));
    cfg.avgoverrpt  = 'yes';
    tort_A1         = ft_selectdata(cfg, data_aoi_dm);
    tort_A1.label2 = data_aoi_dm.label2(knj, :)

%% Tort



% 
PhaseFreq_BandWidth=4;
AmpFreq_BandWidth=20;

% 
PhaseFreqVector = frequencyranges(1:22, :);
AmpFreqVector = frequencyranges;
% 
nbin = 18
%% calculate comodulogram
[position1, comodulogram_A1(jitu, knj, :, :), comodulogram_A1_swap(jitu, knj, :, :)] = tort_cal1(tort_A1, nbin, PhaseFreqVector, AmpFreqVector,PhaseFreq_BandWidth, AmpFreq_BandWidth, 'A1', strcat(unique_labels{jitu}, ":", tort_A1.label2(:, 1)) );
[pp1(jitu, knj, :), MI_1(jitu, knj)] = tort_cal2(tort_A1,pfreq, afreq, position, 'modulation', unique_labels{jitu});

end
end
toc

%% plot comodulogram
area_id = find(contains(unique_labels, area_oi) == 1)
conf =[];
confi.PhaseFreqVector       = PhaseFreqVector    ;
confi.AmpFreqVector         = AmpFreqVector;
confi.PhaseFreq_BandWidth   = abs(PhaseFreqVector(:, 1) - PhaseFreqVector(:, 2));
confi.AmpFreq_BandWidth     = abs(AmpFreqVector(:, 1) - AmpFreqVector(:, 2));


confi.color_axis            = [0 0.003];
confi.ylimit                = [20 200];
confi.xlimit                = [4 30];
confi.toi                   = toi;
confi.area_name             = unique_labels{area_id};

[plot_com] = plot_comodulogram(confi, squeeze(((comodulogram_A1(area_id, :, :, :)) - (comodulogram_A1_swap(area_id, :, :, :)))), 'comodulogram');


%% plot amplitude modulation bar
confi =[];
confi.ylimit = [0.03 .1];
confi.pf1 = pfreq(1) ;
confi.pf2 = pfreq(2);
confi.af1 = afreq(1);
confi.af2 = afreq(2);
[p] = plot_tort(confi, squeeze(pp1(area_id, :, :)), MI_1(area_id, :), 'MI');



